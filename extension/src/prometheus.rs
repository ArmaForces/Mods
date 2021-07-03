use std::{
    io::{Read, Write},
    net::{SocketAddr, TcpListener, TcpStream},
    sync::{mpsc, Arc, Mutex},
    thread, time,
};

#[derive(Clone, Copy)]
pub struct Metrics {
    fps: f32,
    players: u16,
    pub fetch_time: Option<std::time::Instant>,
}
impl Metrics {
    pub fn is_stale(&self) -> bool {
        match self.fetch_time {
            Some(time) => time.elapsed() > std::time::Duration::from_secs(5),
            None => true,
        }
    }
}
impl Default for Metrics {
    fn default() -> Self {
        Self {
            fps: 0.0,
            players: 0,
            fetch_time: None,
        }
    }
}

/// Helper to request metrics from Arma and receive them via Receiver
pub struct MetricsFetcher<F>
where
    F: Fn() + Send + 'static,
{
    pub requester: F,
    pub receiver: mpsc::Receiver<Metrics>,
}
impl<F> MetricsFetcher<F>
where
    F: Fn() + Send + 'static,
{
    /// Request Metrics
    fn request(&self) {
        (self.requester)()
    }

    /// Receive Metrics on the receiver channel, will return error if receiving takes too long.
    fn receive(&self) -> Result<Metrics, mpsc::RecvTimeoutError> {
        const RECEIVE_TIMEOUT: u64 = 3;

        self.receiver
            .recv_timeout(time::Duration::from_secs(RECEIVE_TIMEOUT))
    }
}

pub fn start<F>(address: SocketAddr, fetcher: MetricsFetcher<F>) -> Result<(), String>
where
    F: Fn() -> () + Send + 'static,
{
    MetricsServer::new(address).start(fetcher)
}

pub struct MetricsServer {
    address: SocketAddr,
    metrics: Arc<Mutex<Metrics>>,
}
impl MetricsServer {
    fn new(address: SocketAddr) -> Self {
        Self {
            address,
            metrics: Arc::new(Mutex::new(Metrics::default())),
        }
    }

    /// Starts HTTP server and fetches Metrics when stale
    pub fn start<F>(self, fetcher: MetricsFetcher<F>) -> Result<(), String>
    where
        F: Fn() -> () + Send + 'static,
    {
        let listener = match TcpListener::bind(self.address) {
            Ok(l) => l,
            Err(e) => {
                return Err(format!(
                    "Failed to start server at: {} - {}",
                    self.address, e
                ))
            }
        };

        println!("Server started at: {}", self.address);

        let metrics_arc = self.metrics.clone();
        std::thread::spawn(move || {
            for stream in listener.incoming() {
                let stream = stream.unwrap();

                // if metrics are stale request them from separate thread and wait for the result
                let mut metrics = metrics_arc.lock().unwrap();
                if metrics.is_stale() {
                    fetcher.request();

                    *metrics = fetcher.receive().unwrap();
                }

                Self::handle_request(stream, *metrics);
            }
        });

        Ok(())
    }

    fn handle_request(mut stream: TcpStream, metrics: Metrics) {
        const STATUS_SUCCESS: &str = "HTTP/1.1 200 OK";
        const STATUS_BAD_REQUEST: &str = "HTTP/1.1 404 NOT FOUND";

        const REQUEST_METRICS: &[u8; 23] = b"GET /metrics HTTP/1.1\r\n";

        let mut request = [0; 1024];
        stream.read(&mut request).unwrap();

        let (status, content) = if request.starts_with(REQUEST_METRICS) {
            let duration = match metrics.fetch_time {
                Some(time) => time::Instant::now().duration_since(time),
                None => time::Duration::from_secs(0),
            };

            (STATUS_SUCCESS, duration.as_secs().to_string())
        } else {
            (STATUS_BAD_REQUEST, "NOT FOUND".to_string())
        };

        let response = format!(
            "{}\r\nContent-Length: {}\r\n\r\n{}",
            status,
            content.len(),
            content
        );

        stream.write(response.as_bytes()).unwrap();
        stream.flush().unwrap();

        // thread::sleep(Duration::from_millis(10));
    }

    fn update_metrics() {
        // let arc = self.fetch_lock.clone();

        // let (mutex, condvar) = &*arc;
        // std::thread::spawn(move || {
        //     sleep(Duration::from_secs(2));

        //     let mut lock = mutex.lock().unwrap();
        //     *lock = true;

        //     condvar.notify_all();

        //     println!("Refreshed");
        // });
    }
}
