fx_version 'bodacious'
games { 'gta5' }

client_script "@srp-errorlog/client/cl_errorlog.lua"

export "SetEnableSync"

server_scripts {
	"server/server.lua"
}

client_scripts {
	"client/client.lua"
}