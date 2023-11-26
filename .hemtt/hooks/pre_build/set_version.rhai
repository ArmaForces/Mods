
let modCpp = HEMTT_VFS
    .join("mod.cpp")
    .open_file()
    .read()
;

modCpp.replace("0.0.0", HEMTT.project().version().to_string_short());

HEMTT_VFS
    .join("mod.cpp")
    .create_file()
    .write(modCpp)
;
