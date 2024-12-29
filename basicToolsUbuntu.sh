#!/bin/bash
touch ~/.bashrc

apt-get install -y sudo

sudo apt-get update 
sudo apt-get install -y wget
sudo apt-get install -y  vim
sudo apt-get install -y  git
sudo apt-get install -y  htop
sudo apt-get install -y python3
sudo apt-get install netcat-traditional


# Install Terraform - Not yet working
# https://developer.hashicorp.com/terraform/install
install_terraform() {
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform

    terraform -help
}

#Install Helm
# https://helm.sh/docs/intro/install/
install_helm(){
    curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
    sudo apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    sudo apt-get update
    sudo apt-get install helm
}

#Install kubectl - Not yet working 
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/ 
install_kubectl(){
    sudo apt-get update
    # apt-transport-https may be a dummy package; if so, you can skip that package
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

    # This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list   # helps tools such as command-not-found to work correctly

    sudo apt-get update
    sudo apt-get install -y kubectl

    # verify
    kubectl cluster-info

}

#Install minikube 
# https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Farm64%2Fstable%2Fbinary+download
install_minikube(){
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64
    sudo install minikube-linux-arm64 /usr/local/bin/minikube && rm minikube-linux-arm64
}

verify_tools_installation(){
    python3 --version
    git --version
    helm version
    minikube version
}

# install_terraform
install_helm
install_minikube
verify_tools_installation


