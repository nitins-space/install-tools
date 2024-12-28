#!/bin/bash
sudo apt-get update 
sudo apt-get install -y  vim
sudo apt-get install -y  git
sudo apt-get install -y  htop
sudo apt-get install -y python3
sudo apt-get install -y python3-pip


# Install Terraform 
# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
install_terraform() {
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update && sudo apt-get install -y terraform

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

verify_tools_installation(){
    python3 --version
    git --version

}

install_terraform
install_helm
verify_tools_installation


