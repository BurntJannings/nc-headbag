game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'


client_script {
    "cl_main.lua",
    "config.lua"
    }

server_script {
    "sv_main.lua",
    "config.lua"
    }
ui_page "interface/interface.html";
files {
    "interface/*",
}
