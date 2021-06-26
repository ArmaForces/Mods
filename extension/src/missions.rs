#[derive(serde::Deserialize)]
pub struct Mission {
    pub id: String,
    pub title: String,
    pub date: String,
}

impl Mission {
    fn empty() -> Self {
        Mission {
            id: "".to_string(),
            title: "".to_string(),
            date: "".to_string(),
        }
    }
}

pub fn get_missions() -> Result<Vec<Mission>, String> {
    match reqwest::blocking::get(&format!("{}/missions", *crate::MISSION_API))
        .unwrap()
        .json::<Vec<Mission>>()
    {
        Ok(r) => Ok(r),
        Err(e) => Err(e.to_string()),
    }
}

pub fn get_current_mission() -> Result<Mission, String> {
    let resp = match reqwest::blocking::get(&format!("{}/currentMission", *crate::MISSION_API)) {
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

pub fn post_attendance(mission_id: &String, steam_id: &u64) -> Result<(), String> {
    warn!(
        "Attendance POST not implemented yet! - {}, {}",
        mission_id, steam_id
    );
    Ok(())
}
