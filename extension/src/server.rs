#[derive(serde::Deserialize, Debug)]
#[serde(tag = "status")]
pub enum ServerStatus {
    Starting {
        #[serde(rename = "modsetName")]
        modset_name: String,
    },
    Started {
        #[serde(rename = "modsetName")]
        modset_name: String,
        map: String,
        players: i16,
        #[serde(rename = "playersMax")]
        players_max: i16,
    },
    Stopped {},
}

impl arma_rs::ToArma for ServerStatus {
    fn to_arma(&self) -> arma_rs::ArmaValue {
        let data: Vec<String> = match self {
            ServerStatus::Starting { modset_name } => {
                vec!["Starting".to_string(), modset_name.to_string()]
            },
            ServerStatus::Started { modset_name, map, players, players_max } => {
                vec!["Started".to_string(), modset_name.to_string(), players.to_string(), players_max.to_string(), map.to_string()]
            },
            ServerStatus::Stopped {} => vec!["Stopped".to_string()],
        };

        data.to_arma()
    }
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
