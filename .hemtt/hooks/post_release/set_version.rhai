
let modCpp = HEMTT_OUTPUT
    .join("mod.cpp")
    .open_file()
    .read()
;

modCpp.replace("0.0.0", HEMTT_PROJECT_VERSION);

HEMTT_OUTPUT
    .join("mod.cpp")
    .create_file()
    .write(modCpp)
;
