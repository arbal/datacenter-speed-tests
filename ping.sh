#!/bin/bash

printf "DigitalOcean Ping Test:\n\n"

# https://www.digitalocean.com/docs/platform/availability-matrix/
for DC in NYC1 NYC2 NYC3 SFO1 SFO2 SFO3 TOR1 LON1 FRA1 AMS2 AMS3 SGP1 BLR1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest-$DC.digitalocean.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


printf "\n\nLinode Ping Test:\n\n"

# https://www.linode.com/speed-test/
for DC in newark atlanta dallas fremont london frankfurt singapore tokyo2 syd1 toronto1 mumbai1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q speedtest.$DC.linode.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


printf "\n\nAWS Ping Test:\n\n"

# https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html
for DC in us-east-1 us-east-2 us-west-1 us-west-2 af-south-1 ap-east-1 ap-south-2 ap-southeast-3 ap-southeast-5 ap-southeast-4 ap-south-1 ap-northeast-3 ap-northeast-2 ap-southeast-1 ap-southeast-2 ap-east-2 ap-southeast-7 ap-northeast-1 ca-central-1 ca-west-1 eu-central-1 eu-west-1 eu-west-2 eu-south-1 eu-west-3 eu-south-2 eu-north-1 eu-central-2 il-central-1 mx-central-1 me-south-1 me-central-1 sa-east-1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q ec2.$DC.amazonaws.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


printf "\n\nGCP Ping Test:\n\n"

# https://cloud.google.com/compute/docs/regions-zones
for DC in africa-south1 asia-northeast1 asia-south1 asia-southeast1 asia-southeast2 europe-west3 europe-west4 europe-west6 europe-west9 us-central1 us-east1 us-east4 us-east5 us-south1 us-west1
do
    printf "$DC: \t$(ping -i .2 -c 10 -q $DC.gcp.cloudharmony.net | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done


printf "\n\nVultr/Choopa Ping Test:\n\n"

# https://www.vultr.com/resources/faq/#downloadspeedtests
for DC in NJ-US IL-US GA-US FL-US TX-US SJO-CA-US LAX-CA-US WA-US TOR-CA FRA-DE AMS-NL PAR-FR LON-GB SYD-AU SGP HND-JP SEL-KOR
do
    printf "$DC: \t$(ping -i .2 -c 10 -q $DC-ping.vultr.com | awk -F/ '/^round|^rtt/{print $5}') ms\n" | expand -t 20
done
