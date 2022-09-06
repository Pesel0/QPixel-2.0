fx_version 'cerulean'
game 'gta5'


client_script {
    '@desirerp-lib/client/cl_interface.lua',
    '@desirerp-lib/client/cl_rpc.lua',
    'config.lua',
	'client/*.lua',
    'client/cl_rpc.lua'
}

server_script {
    'server/*.lua',
    'server/sv_rpc.lua',
    '@desirerp-lib/server/sv_rpc.lua'
}

shared_script {
    '@desirerp-lib/shared/sh_util.lua'
  }

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/*.css',
    'html/*.js',
    'html/img/*.png',
    'html/static/js/*.js',
    'html/static/css/*.css',
    'html/static/media/*.ttf',
    'html/static/media/*.png',
    'html/static/media/*.jpg',
    'html/static/media/*.gif',
    'html/static/media/*.ogg',
}

exports {
    'sendfpscarhud',
    'dobuffthing',
    'IntelegenceBuff',
    'MoneyBuff'
}