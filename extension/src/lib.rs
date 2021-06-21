use arma_rs::{rv, rv_callback, rv_handler};

#[macro_use]
extern crate lazy_static;

#[macro_use]
extern crate log;

static EXT: &str = "armaforces_mods";

lazy_static! {
    static ref MISSION_API: String = std::env::var("AF_MISSION_API")
        .unwrap_or(String::from("https://boderator.armaforces.com/api"));
    static ref TOKEN: String = std::env::var("AF_MISSION_API_TOKEN").unwrap_or_default();
}

pub mod missions;

#[rv]
fn setup() -> bool {
    if TOKEN.is_empty() {
        error!("Token is empty, disabled");
        false
    } else {
        info!("Token not empty, enabled");
        true
    }
}

#[rv(thread = true)]
fn get_current_mission_id() {
    match missions::get_current_mission() {
        Ok(m) => rv_callback!(EXT, "set_current_mission_id", m.get_id()),
        Err(e) => error!("Could not fetch current mission id - {}", e),
    }
}

#[rv(thread = true)]
fn post_attendance(mission_id: String, steam_id: u64) {}

// Logger
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

// needs to be at the bottom after all #[rv] functions
#[rv_handler]
fn init() {
    let _ = log::set_logger(&LOGGER).map(|()| log::set_max_level(LevelFilter::Info));
}
