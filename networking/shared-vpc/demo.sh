#!/bin/bash

echo ==========testing dev-to-prd-and-cicd==========
gcloud config set project dev-service-1
gcloud compute ssh --zone "asia-southeast1-a" "dev-service-1-vm-svpc"  --tunnel-through-iap --project "dev-service-1" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.2.2:22 -v'
gcloud compute ssh --zone "asia-southeast1-a" "dev-service-1-vm-svpc"  --tunnel-through-iap --project "dev-service-1" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.3.2:22 -v'

echo

echo ==========testing prd-to-dev-and-cicd==========
gcloud config set project prd-service-1
gcloud compute ssh --zone "asia-southeast1-a" "prd-service-1-vm-svpc"  --tunnel-through-iap --project "prd-service-1" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.1.2:22 -v'
gcloud compute ssh --zone "asia-southeast1-a" "prd-service-1-vm-svpc"  --tunnel-through-iap --project "prd-service-1" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.3.2:22 -v'

echo

echo ==========testing cicd-to-dev-and-prd==========
gcloud config set project cicd-monitor
gcloud compute ssh --zone "asia-southeast1-a" "cicd-monitor-vm-svpc"  --tunnel-through-iap --project "cicd-monitor" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.1.2:22 -v'
gcloud compute ssh --zone "asia-southeast1-a" "cicd-monitor-vm-svpc"  --tunnel-through-iap --project "cicd-monitor" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.2.2:22 -v'
