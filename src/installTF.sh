#!/bin/bash

# Install Terraform
function installTF { 
    cd /tmp 
    curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/${INPUT_TERRAFORMVERSION}/terraform_${INPUT_TERRAFORMVERSION}_linux_amd64.zip
    echo -e "${INPUT_TERRAFORMSHA256} terraform.zip" | sha256sum -c -s
    unzip terraform.zip
    sudo mv terraform /usr/bin
    sudo cat > /root/.terraform.rc << EOF
credentials "app.terraform.io" {
    token = "${INPUT_TERRAFORMCLOUDTOKEN}"
}
EOF
}