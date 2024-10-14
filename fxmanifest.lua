shared_script '@ray-test/shared_fg-obfuscated.lua'
shared_script '@ray-test/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'
lua54 "yes"

ui_page 'hud_ui/index.html'

files {
    'hud_ui/index.html',
    'hud_ui/style.css',
    'hud_ui/script.js'
}

client_scripts {
    '@ox_lib/init.lua',
    'client.lua'
}