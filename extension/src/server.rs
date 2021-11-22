#[derive(serde::Deserialize, Debug)]
#[serde(tag = "status")]
pub enum ServerStatus {
    Started {
        name: String,
        #[serde(rename = "modsetName")]
        modset_name: String,
        map: String,
        players: i16,
        #[serde(rename = "playersMax")]
        players_max: i16,
    },
    Stopped {},
}

pub fn get_status() -> Result<ServerStatus, String> {
    let resp = match reqwest::blocking::get(&format!("{}/status", *crate::SERVER_API)) {
        Ok(r) => r,
        Err(e) => return Err(e.to_string()),
    };

    match resp.json::<ServerStatus>() {
        Ok(m) => Ok(m),
        Err(e) => Err(e.to_string()),
    }
}

#[test]
fn test_get_status() {
    let status = get_status().unwrap();
    println!("{:?}", status);
}
