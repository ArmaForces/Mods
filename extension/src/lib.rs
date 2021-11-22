use arma_rs::{rv, rv_callback, rv_handler};

#[macro_use]
extern crate lazy_static;

#[macro_use]
extern crate log;

static EXT: &str = "armaforces_mods";

lazy_static! {
    static ref MISSION_API: String = std::env::var("AF_MISSION_API")
        .unwrap_or_else(|_| String::from("https://boderator.armaforces.com/api"));
    static ref ATTENDANCE_API: String = std::env::var("AF_ATTENDANCE_API")
        .unwrap_or_else(|_| String::from("https://armaforces.com/api"));
    static ref SERVER_API: String = std::env::var("AF_SERVER_API")
        .unwrap_or_else(|_| String::from("https://server.armaforces.com:8888"));
    static ref ATTENDANCE_TOKEN: String =
        std::env::var("AF_ATTENDANCE_API_TOKEN").unwrap_or_default();
}

pub mod missions;
mod retry;
pub mod server;

#[rv]
fn setup() -> bool {
    if ATTENDANCE_TOKEN.is_empty() {
        error!("Attendance token is empty, disabled");
        false
    } else {
        info!("Attendance token not empty, enabled");
        true
    }
}

// region: Attendance

#[rv(thread = true)]
fn get_current_mission_id() {
    match retry::backoff(missions::get_current_mission) {
        Ok(m) => rv_callback!(EXT, "set_current_mission_id", m.get_id()),
        Err(e) => {
            error!("Could not fetch current mission id - {}", e);
            rv_callback!(
                EXT,
                "get_current_mission_error",
                format!("Could not fetch current mission id - {}", e)
            );
        }
    }
}

#[rv(thread = true)]
fn post_attendance(mission_id: String, steam_id: u64) {
    if mission_id.is_empty() {
        return warn!(
            "Unable to send attendance for {} - mission_id empty.",
            steam_id
        );
    }

    info!("Sending attendance for: {}, {}", mission_id, steam_id);

    match retry::backoff(|| missions::post_attendance(&mission_id, &steam_id)) {
        Ok(_) => info!("Saved attendance for: {}", steam_id),
        Err(e) => error!("Failed to post attendance for: {} - {}", steam_id, e),
    };
}

// endregion

// region: Server

#[rv(thread = true)]
fn get_server_status() {
    info!("Fetching server status");

    match retry::backoff(server::get_status) {
        Ok(s) => {
            info!("Server status: {:?}", s);
            match s {
                server::ServerStatus::Started { .. } => {
                    rv_callback!(EXT, "get_server_status", "started")
                }
                server::ServerStatus::Stopped {} => {
                    rv_callback!(EXT, "get_server_status", "stopped")
                }
            }
        }
        Err(e) => error!("Could not fetch server status - {}", e),
    }
}

// endregionm

// region: Logger

use log::{Level, LevelFilter, Metadata, Record};
struct ArmaLogger;
impl log::Log for ArmaLogger {
    fn enabled(&self, metadata: &Metadata) -> bool {
        metadata.level() <= Level::Info
    }

    fn log(&self, record: &Record) {
        if self.enabled(record.metadata()) {
            rv_callback!(
                "armaforces_mods_log",
                format!("{}", record.level()).to_uppercase(),
                format!("{}", record.args())
            );
        }
    }

    fn flush(&self) {}
}
static LOGGER: ArmaLogger = ArmaLogger;

// endregion

// needs to be at the bottom after all #[rv] functions
#[rv_handler]
fn init() {
    let _ = log::set_logger(&LOGGER).map(|()| log::set_max_level(LevelFilter::Info));
}
