
let modCpp = HEMTT_VFS
    .join("mod.cpp")
    .open_file()
    .read()
;

modCpp.replace("0.0.0", `${HEMTT_PROJECT_VERSION_MAJOR}.${HEMTT_PROJECT_VERSION_MINOR}.${HEMTT_PROJECT_VERSION_PATCH}`);

HEMTT_VFS
    .join("mod.cpp")
    .create_file()
    .write(modCpp)
;
