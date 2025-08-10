fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'rex-fasttravel'
version '2.0.0'

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

dependencies {
    'rsg-core',
    'ox_lib',
}

files {
  'locales/*.json'
}

lua54 'yes'
