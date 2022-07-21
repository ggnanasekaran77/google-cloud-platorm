gcloud compute networks subnets create proxy-only-subnet \
    --purpose=REGIONAL_MANAGED_PROXY \
    --role=ACTIVE \
    --region=asia-southeast1 \
    --network=safi-sandbox-istio1-vpc \
    --range=10.129.0.0/23


gcloud compute firewall-rules create allow-proxy-connection \
    --allow=TCP:9376 \
    --source-ranges=10.129.0.0/23 \
    --network=safi-sandbox-istio1-vpc


gcloud compute networks subnets create ilb-subnet-asia-southeast1 --network=safi-sandbox-istio1-vpc --region=asia-southeast1 --range=10.20.0.0/24


gcloud container clusters create ilb-cluster \
    --enable-ip-alias \
    --zone=asia-southeast1-a \
    --network=safi-sandbox-istio1-vpc \
    --subnetwork=ilb-subnet-asia-southeast1




gcloud compute instances create l7-ilb-client-us-central1-a \
    --image-family=debian-9 \
    --image-project=debian-cloud \
    --network=safi-sandbox-istio1-vpc \
    --subnet=safi-sandbox-istio1-subnet \
    --zone=asia-southeast1-a \
    --tags=allow-ssh


gcloud compute firewall-rules   create ilb-fw-ssh-allow --direction=INGRESS --priority=1000 --network=safi-sandbox-istio1-vpc --action=ALLOW --rules=tcp:22 --source-ranges=0.0.0.0/0

gcloud compute ssh l7-ilb-client-us-central1-a \
   --zone=asia-southeast1-a


gcloud compute addresses create ilb-ingress \
    --region asia-southeast1 --subnet ilb-subnet-asia-southeast1



ilb-ingress 10.20.0.7


helm repo add nginx-stable https://helm.nginx.com/stable

helm install my-ingress-release nginx-stable/nginx-ingress -n ingress-nginx --create-namespace -f values.yaml

❯ k get ingress
NAME                      CLASS    HOSTS                                        ADDRESS     PORTS   AGE
httpbin-demo-ingress      <none>   httpbin.ilb-hostname-server.example.com      10.20.0.7   80      3m58s
httpbintwo-demo-ingress   <none>   httpbintwo.ilb-hostname-server.example.com   10.20.0.7   80      8s
