#!/usr/bin/env bash
# Usage 
# ./build_and_push.sh MAXMIND_LICENSE_KEY
# You can get a free license key from them.
# Instructions here : https://dev.maxmind.com/geoip/geolite2-free-geolocation-data?lang=en
# VARS
dailytag=$(date -I)
imagename='pilbbq/deluge'
dailyimage="$imagename:$dailytag"
latestimage="$imagename:latest"
maxmind_licensekey="$1"
geolite2country_url="https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country-CSV&license_key=$maxmind_licensekey&suffix=zip"
geoip_target_location="root/usr/share/GeoIP/GeoIP.dat"
geolite2legacy_image="pilbbq/geolite2legacy"
geolite2_zip="Geolite2-Country.zip"
# SCRIPT
if [ $# -eq 0 ]; then
    echo "No arguments provided, please provide maxmind license key"
    exit 1
fi
curl -o $geolite2_zip -sL $geolite2country_url
docker run -it -v $(pwd):/src $geolite2legacy_image -i /src/$geolite2_zip -o /src/$geoip_target_location -6

if [[ -f $geoip_target_location ]]
then
    # Build daily and latest
    docker build -t $dailyimage -t $latestimage .
    # Push all tags
    docker push -a $imagename
else
    echo "GeoIP.dat is not present, exiting"
    exit 1
fi
