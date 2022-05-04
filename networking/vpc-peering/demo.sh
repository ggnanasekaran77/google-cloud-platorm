#!/bin/bash

echo set project test-1
gcloud config set project test-1-348414 --verbosity=none
echo ========== connection test from test-1 to test-2 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-1-ce-peer-poc"  --tunnel-through-iap --project "test-1-348414" --verbosity=none -- 'echo quit | curl -s telnet://10.0.2.2:22 -v | grep port'
echo
echo
echo ========== connection test from test-1 to test-3 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-1-ce-peer-poc"  --tunnel-through-iap --project "test-1-348414" --verbosity=none -- 'echo quit | curl -s telnet://10.0.3.2:22 -v | grep port'
echo
echo
echo set project test-2
gcloud config set project test-2-348414 --verbosity=none
echo ========== connection test from test-2 to test-1 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-2-ce-peer-poc"  --tunnel-through-iap --project "test-2-348414" --verbosity=none -- 'echo quit | curl -s telnet://10.0.1.4:22 -v | grep port'
echo
echo
echo ========== connection test from test-2 to test-3 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-2-ce-peer-poc"  --tunnel-through-iap --project "test-2-348414" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.3.2:22 -v'
echo
echo
echo set project test-3
gcloud config set project test-3-348414 --verbosity=none
echo ========== connection test from test-3 to test-1 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-3-ce-peer-poc"  --tunnel-through-iap --project "test-3-348414" --verbosity=none -- 'echo quit | curl -s telnet://10.0.1.4:22 -v | grep port'
echo
echo
echo ========== connection test from test-3 to test-2 ==============
echo
gcloud compute ssh --zone "asia-southeast1-a" "test-3-ce-peer-poc"  --tunnel-through-iap --project "test-3-348414" --verbosity=none -- 'echo quit | curl -s --connect-timeout 10 telnet://10.0.2.2:22 -v'
echo
echo
