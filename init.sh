sudo apt-mark hold kubeadm kubelet kubectl
sudo swapoff -a
sudo kubeadm reset -f
sudo rm -rf /etc/cni/net.d
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
sleep 2
sudo mkdir -p $HOME/.kube
sleep 1
sudo \cp /etc/kubernetes/admin.conf $HOME/.kube/config
sleep 1
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 2
sudo kubectl taint nodes ${HOSTNAME,,} node-role.kubernetes.io/master-
sleep 100
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl create ns oai
kubectl create secret docker-registry personalkey --docker-server=https://index.docker.io/v1/ --docker-username=schristakis --docker-password=sosotatis1999 --docker-email=schristakis@uth.gr -n oai
kubectl create secret docker-registry personalkey --docker-server=https://index.docker.io/v1/ --docker-username=schristakis --docker-password=sosotatis1999 --docker-email=schristakis@uth.gr
sleep 15
cd multus-cni
cat ./deployments/multus-daemonset-thick.yml | kubectl apply -f -
cd ..
sleep 15
cd oai-cn5g-fed/charts/
helm install mysql mysql/
sleep 20
helm install nrf oai-nrf/
sleep 20
helm install amf oai-amf/
sleep 15
helm install smf oai-smf/
sleep 15
helm install upf oai-spgwu-tiny/
sleep 15
helm install gnb oai-gnb/
sleep 15
helm install nrue oai-nr-ue/
sleep 10
sudo kubectl exec -ti $(kubectl get pods | grep nr-ue  | awk {'print $1'}) -c nr-ue bash


