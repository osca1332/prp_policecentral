fx_version 'bodacious'
game {'gta5'}

author "Oscar Lajgaard"
description "Politablet til ProvinsenRP"
version "1.3.0"

client_scripts {
    "lib/Proxy.lua",
    "lib/Tunnel.lua",
    "client.lua",
}

ui_page "html/index.html"

files {
  "html/index.html",
  "html/index.js",
  "html/index.css",
  "html/reset.css",
}

server_scripts {
"@mysql-async/lib/MySQL.lua",
    "@vrp/lib/utils.lua",
"server.lua"
}