use reqwest::StatusCode;

#[derive(serde::Deserialize)]
pub struct Mission {
    pub title: String,
    pub date: String,
}

impl Mission {
    fn empty() -> Self {
        Mission {
            title: "".to_string(),
            date: "".to_string(),
        }
    }
    pub fn get_id(&self) -> String {
        chrono::NaiveDateTime::parse_from_str(&self.date, "%Y-%m-%dT%H:%M:%S")
            .unwrap()
            .timestamp()
            .to_string()
    }
}

pub fn get_missions() -> Result<Vec<Mission>, String> {
    match reqwest::blocking::get(format!("{}/missions", *crate::MISSION_API))
        .unwrap()
        .json::<Vec<Mission>>()
    {
        Ok(r) => Ok(r),
        Err(e) => Err(e.to_string()),
    }
}

pub fn get_current_mission() -> Result<Mission, String> {
    let resp = match reqwest::blocking::get(format!("{}/currentMission", *crate::MISSION_API)) {
        Ok(r) => r,
        Err(e) => return Err(e.to_string()),
    };

    // return empty Mission struct when no ongoing mission
    if resp.status() == reqwest::StatusCode::from_u16(404).unwrap() {
        return Ok(Mission::empty());
    }

    match resp.json::<Mission>() {
        Ok(m) => Ok(m),
        Err(e) => Err(e.to_string()),
    }
}

#[derive(serde::Serialize)]
struct AttendanceBody<'a> {
    #[serde(rename = "missionId")]
    mission_id: &'a str,
    #[serde(rename = "playerId")]
    steam_id: &'a u64,
}

#[derive(serde::Deserialize)]
struct AttendanceResponse {
    detail: String,
}

pub fn post_attendance(mission_id: &str, steam_id: &u64) -> Result<(), String> {
    let resp = reqwest::blocking::Client::new()
        .post(format!("{}/attendances", *crate::ATTENDANCE_API))
        .header("X-API-KEY", crate::ATTENDANCE_TOKEN.clone())
        .json(&AttendanceBody {
            mission_id,
            steam_id,
        })
        .send();

    match resp {
        Ok(r) => match r.status() {
            StatusCode::CREATED => Ok(()),
            s => {
                let resp = r
                    .json::<AttendanceResponse>()
                    .unwrap_or(AttendanceResponse {
                        detail: format!("Unkown error - {}", s),
                    });
                Err(resp.detail)
            }
        },
        Err(e) => Err(e.to_string()),
    }
}

#[test]
fn test_mission_get_id() {
    let mission = Mission {
        title: "".to_string(),
        date: "2021-07-04T14:00:01".to_string(),
    };

    assert_eq!("1625407201", mission.get_id());
}
