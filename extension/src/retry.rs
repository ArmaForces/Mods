pub fn backoff<F, T, E>(callback: F) -> Result<T, E>
where
    F: Fn() -> Result<T, E>,
    E: ToString,
{
    backoff_custom(callback, Option::None, Option::None)
}

pub fn backoff_custom<F, T, E>(callback: F, retries: Option<u8>, delay: Option<u64>) -> Result<T, E>
where
    F: Fn() -> Result<T, E>,
    E: ToString,
{
    let mut retries = retries.unwrap_or(3);
    let mut delay = delay.unwrap_or(10);
    loop {
        match callback() {
            Err(e) if retries > 0 => {
                warn!("Retrying in {}s - {}", delay, e.to_string());

                retries -= 1;
                std::thread::sleep(std::time::Duration::from_secs(delay));
                delay *= 2;
            }
            r => return r,
        }
    }
}
