--[[
    __             _                                 __
   / /   ____ _   (_)____ _ ____ _ ____ _ _____ ____/ /
  / /   / __ `/  / // __ `// __ `// __ `// ___// __  / 
 / /___/ /_/ /  / // /_/ // /_/ // /_/ // /   / /_/ /  
/_____/\__,_/__/ / \__, / \__,_/ \__,_//_/    \__,_/   
            /___/ /____/                               

Det her er udviklet af Oscar Lajgaard, og udviklet for ProvinsenRP.
Må ikke kopieres. Copyright 2020.

Version: BETA-0.1

]]

resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

dependency "mysql-async"

ui_page "html/index.html"

files {
  "html/index.html",
  "html/index.js",
  "html/index.css",
  "html/reset.css",
}



client_scripts {
  "lib/Proxy.lua",
  "lib/Tunnel.lua",
  "client.lua",


}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
	"@vrp/lib/utils.lua",
  "server.lua"
}