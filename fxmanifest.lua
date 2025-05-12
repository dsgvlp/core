fx_version 'cerulean'
game 'gta5'

author 'dsgvlp'
version '1.0.0'

shared_scripts {
    'class/events_shared.lua',
    'class/utils/console/client/console.lua',
    'class/utils/webhook/shared/*.lua',
    'class/utils/_utils.lua'
}

client_scripts {
    'class/events_client.lua',
    'modules/**/client/*.lua'
}

server_scripts {
    'class/events_server.lua',
    'class/utils/console/server/*.lua',
    'class/utils/webhook/*.lua',
    'modules/**/server/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js',
    'html/metadata/*.wav'
}
