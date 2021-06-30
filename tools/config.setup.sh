#------------------------------------------------------------
# [[APP_NAME]] ([[APP_URL]])
#
# @link      [[APP_REPOSITORY_URL]]
# @copyright Copyright (c) [[COPYRIGHT_YEAR]] [[COPYRIGHT_HOLDER]]
# @license   [[LICENSE_URL]] ([[LICENSE]])
#--------------------------------------------------------------
#!/bin/bash

#------------------------------------------------------
# Scripts to setup configuration files
#------------------------------------------------------

if [ -f config/config.json.sample ]; then
    cp config/config.json.sample config/config.json
fi
if [ -f config/config.ini.sample ]; then
    cp config/config.ini.sample config/config.ini
fi
cp build.prod.cfg.sample build.prod.cfg
cp build.dev.cfg.sample build.dev.cfg
cp build.cfg.sample build.cfg
cp defines.cfg.sample defines.cfg

#------------------------------------------------------
# Replace target compilation based on platform
#------------------------------------------------------
if [["$OSTYPE" == "freebsd"*]]; then
    sed -i '' 's/\-Tlinux/\-Tfreebsd/g' build.cfg
elif [["$OSTYPE" == "msys"*]]; then
    sed -i '' 's/\-Tlinux/\-Twin64/g' build.cfg
fi