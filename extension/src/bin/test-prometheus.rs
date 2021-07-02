use std::{
    sync::{
        mpsc::{self, Receiver, SyncSender},
        Arc, Mutex,
    },
    thread::sleep,
    time::{Duration, Instant},
};

use armaforces_mods::prometheus;
use log::info;

#[macro_use]
extern crate lazy_static;

lazy_static! {
    static ref FETCH: Mutex<bool> = Mutex::new(false);
    static ref METRICS_SENDER: Mutex<Option<SyncSender<prometheus::Metrics>>> = Mutex::new(None);
}

fn export_metrics() {
    println!("requesting metrics");

    std::thread::spawn(|| {
        sleep(Duration::from_secs(2));
        send_metrics();
    });
}

fn send_metrics() {
    println!("sending metrics");

    let lock = METRICS_SENDER.lock().unwrap();

    println!("got lock");
    let tx = lock.as_ref().clone().unwrap();

    let mut metrics = prometheus::Metrics::default();
    metrics.fetch_time = Some(Instant::now());

    println!("tx");
    tx.send(metrics).unwrap();
}

fn main() {
    println!("Test");

    let (tx, rx) = mpsc::sync_channel(0);

    let mut lock = METRICS_SENDER.lock().unwrap();
    *lock = Some(tx);
    drop(lock);

    let server =
        prometheus::start("0.0.0.0:8080".parse().unwrap(), || export_metrics(), rx).unwrap();

    loop {
        std::thread::park()
    }
}
