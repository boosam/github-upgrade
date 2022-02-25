#!/bin/bash

set -e

display_usage() { 
	echo -e "\nExecute the script with the version number you want to upgrade too!!" 
	echo -e "Usage:\ngithub-upgrade.sh <version> \n" 
	}

if [ $# -ne 1 ]; then
	display_usage
    exit 1
fi

SERVER="codetest.espn.com"                                                 
KEY="/Users/boosam/Git-Repos/espnautomation/id_rsa"
GHE_PACKAGE="github-enterprise-esx"
VERSION=$1

SCRIPTPATH=`pwd`

echo "** Connecting to the GHE Server : $SERVER **"
### Connecting to the GHE-DB 
ssh -i $KEY "admin@"$SERVER -p 122 << EOF

### Download the upgrade package :
curl -L -O https://github-enterprise.s3.amazonaws.com/esx/updates/$GHE_PACKAGE-$VERSION.pkg

### Run the ghe-upgrade command :
ghe-upgrade -y $GHE_PACKAGE-$VERSION.pkg

echo "--done--"
EOF
