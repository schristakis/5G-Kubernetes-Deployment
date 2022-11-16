
# Docker Installation 

>sudo apt-get update

> sudo apt-get upgrade

> sudo apt-get install docker.io

> sudo systemctl enable docker

> sudo systemctl status docker

> sudo systemctl start docker

> apt-cache madison docker-ce | awk '{ print $3 }'

> sudo apt-get install docker-ce=5:19.03.10~3-0~ubuntu-focal docker-ce-cli=5:19.03.10~3-0~ubuntu-focal

# Kubernetes Installation
> curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

> sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

> sudo apt install kubeadm=1.17.0-00 kubectl=1.17.0-00 kubelet=1.17.0-00

> sudo apt-mark hold kubeadm kubelet kubectl

> sudo swapoff -a

> sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

### When installing caution(kubelet isn't running issue): 

> sudo nano /etc/docker/daemon.json

put lines below:
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}

> sudo systemctl daemon-reload

> sudo systemctl restart docker

> sudo systemctl restart kubelet

###############################################

# Cluster Initialization

> kubeadm reset -f

> rm -rf  /etc/cni/net.d

> kubeadm init --pod-network-cidr=10.244.0.0/16

> mkdir -p $HOME/.kube

> cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

> chown $(id -u):$(id -g) $HOME/.kube/config

> kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Helm Installation

> curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get

> chmod +x get_helm.sh

> ./get_helm.sh --version v3.5.3

# Multus CNI Installation

> git clone https://github.com/k8snetworkplumbingwg/multus-cni.git && cd multus-cni

> cat ./deployments/multus-daemonset-thick.yml | kubectl apply -f -

> kubectl taint nodes  socratis-oai-cn node-role.kubernetes.io/master-

> kubectl create ns oai

> kubectl create secret docker-registry personalkey --docker-server=https://index.docker.io/v1/ --docker-username=schristakis --docker-password=sosotatis1999 --docker-email=schristakis@uth.gr -n oai

> kubectl create secret docker-registry personalkey --docker-server=https://index.docker.io/v1/ --docker-username=schristakis --docker-password=sosotatis1999 --docker-email=schristakis@uth.gr 
