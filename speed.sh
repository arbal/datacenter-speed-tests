#!/bin/bash

function spinner()
{
#    local lines='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $1)" ]; do
#        local temp=${lines#?}
#        printf "\r [%c]  " "$lines"
#        local lines=$temp${lines%"$temp"}
        sleep 0.15
    done
    printf "\r"
}

printf "DigitalOcean Speed Test: (100MB each)\n\n"

# https://www.digitalocean.com/docs/platform/availability-matrix/
for DC in NYC1 NYC2 NYC3 SFO1 SFO2 SFO3 TOR1 LON1 FRA1 AMS2 AMS3 SGP1 BLR1
do
    printf "$DC: "
    printf "$(wget -O /dev/null http://speedtest-$DC.digitalocean.com/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\n" & spinner $!
done


printf "\n\nLinode Speed Test: (100MB each)\n\n"

# https://www.linode.com/speed-test/
for DC in newark atlanta dallas fremont london frankfurt singapore tokyo2 syd1 toronto1 mumbai1
do
    printf "$DC: "
    printf "$(wget -O /dev/null http://speedtest.$DC.linode.com/100MB-$DC.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\n" & spinner $!
done


printf "\n\nAWS Speed Test: (10MB each)\n\n"

# https://cloudharmony.com/speedtest-for-aws:ec2
for DC in us-east-1 us-east-2a us-east-2b us-west-1 us-west-2 ca-central-1 eu-north-1 eu-central-1 eu-west-1 eu-west-2 eu-west-3 eu-north-1 eu-south-1 ap-east-1 ap-northeast-1 ap-northeast-2 ap-south-1 ap-southeast-1 ap-southeast-2 sa-east-1 me-south-1 af-south-1
do
    printf "$DC: "
    printf "$(wget -O /dev/null http://$DC-ec2.cloudharmony.net/probe/test10mb.jpg 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\n" & spinner $!
done


printf "\n\nGCP Speed Test: (10MB each)\n\n"

# From https://github.com/GoogleCloudPlatform/gcping
gcp_regions=$(curl -s https://global.gcping.com/api/endpoints | grep -o '"[a-z0-9-]*":{"Region":"[a-z0-9-]*","RegionName":"[^"]*","URL":"[^"]*"}' | awk -F'"' '{print $2, $12}' | sed 's|https://||' | sed 's|/api/endpoints||' | grep -v global)
for gcp_region in $(echo "$gcp_regions" | awk '{print $1}'); do
    url=$(echo "$gcp_regions" | grep "^$gcp_region " | awk '{print $2}')
    printf "$gcp_region: "
    printf "$(wget -O /dev/null $url 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\n" & spinner $!
done


printf "\n\nVultr/Choopa Speed Test: (100MB each)\n\n"

# https://www.vultr.com/resources/faq/#downloadspeedtests
for DC in NJ-US IL-US GA-US FL-US TX-US SJO-CA-US LAX-CA-US WA-US TOR-CA FRA-DE AMS-NL PAR-FR LON-GB SYD-AU SGP HND-JP SEL-KOR
do
    printf "$DC: "
    printf "$(wget -O /dev/null http://$DC-ping.vultr.com/vultr.com.100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}')\n" & spinner $!
done
