FROM ubuntu:20.04 as build
LABEL author=cphillipson@pivotal.io

# Welcome to tf4k8s-toolsuite!
# This image installs the following versions of CLIs on an Ubuntu Focal image

ARG DEBIAN_FRONTEND=noninteractive 

ENV TZ=America/Los_Angeles \
    BOSH_VERSION=6.4.0 \
    CF_VERSION=7.1.0 \
    CREDHUB_VERSION=2.8.0 \
    HELM_VERSION=3.3.4 \
    HELMFILE_VERSION=0.125.7 \
    AWS_IAM_AUTHENTICATOR_VERSION="1.18.8/2020-09-18" \
    KAPP_VERSION=0.35.0 \
    KBLD_VERSION=0.27.0 \
    KUBECTL_VERSION=1.19.6 \
    OM_VERSION=6.3.0 \
    PIVNET_VERSION=2.0.1 \
    TERRAFORM_VERSION=0.15.3 \
    TERRAFORM_DOCS_VERSION=0.9.1 \
    LEFTOVERS_VERSION=0.62.0 \
    TF_K14S_PLUGIN_VERSION=0.6.0 \
    TMC_VERSION=0.2.0-33567c83 \
    VENDIR_VERSION=0.13.0 \
    YTT_VERSION=0.30.0

RUN mkdir downloads && cd downloads && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt update -y && \
    apt install build-essential curl git gpg graphviz httpie libnss3-tools jq nodejs npm openssl python3-pip python3-dev ruby-dev sudo tzdata unzip wget -y && \
    apt install apt-transport-https ca-certificates gnupg lsb-release software-properties-common dirmngr -y && \
    add-apt-repository ppa:longsleep/golang-backports && \
    apt update -y && \
    python3 -m pip install --user --upgrade pip && \
    python3 -m pip install --user virtualenv && \
    useradd -m docker && echo "docker:docker" | chpasswd && \
    adduser docker sudo && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    curl -o aws-iam-authenticator curl -o aws-iam-authenticator "https://amazon-eks.s3.us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR_VERSION}/bin/linux/amd64/aws-iam-authenticator" && \
    chmod +x aws-iam-authenticator && \
    sudo mv aws-iam-authenticator /usr/local/bin && \
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt update -y && apt install google-cloud-sdk -y && \
    gem install cf-uaac && \
    wget https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
    mv bosh-cli-${BOSH_VERSION}-linux-amd64 bosh && \
    chmod +x bosh && \
    sudo mv bosh /usr/local/bin && \
    wget -O cf.tgz "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_VERSION}&source=github-rel" && \
    tar -xvf cf.tgz && \
    rm -Rf cf.tgz && \
    sudo mv cf7 cf && \
    sudo mv cf /usr/local/bin && \
    wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/${CREDHUB_VERSION}/credhub-linux-${CREDHUB_VERSION}.tgz && \
    tar -xvzf credhub-linux-${CREDHUB_VERSION}.tgz && \
    rm -Rf credhub-linux-${CREDHUB_VERSION}.tgz && \
    sudo mv credhub /usr/local/bin && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    sudo mv kubectl /usr/local/bin && \
    wget https://github.com/pivotal-cf/om/releases/download/${OM_VERSION}/om-linux-${OM_VERSION} && \
    mv om-linux-${OM_VERSION} om && \
    chmod +x om && \
    sudo mv om /usr/local/bin && \
    wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v${PIVNET_VERSION}/pivnet-linux-amd64-${PIVNET_VERSION} && \
    mv pivnet-linux-amd64-${PIVNET_VERSION} pivnet && \
    chmod +x pivnet && \
    sudo mv pivnet /usr/local/bin && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    sudo mv terraform /usr/local/bin && \
    curl -Lo ./terraform-docs https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-$(uname | tr '[:upper:]' '[:lower:]')-amd64 && \
    chmod +x ./terraform-docs && \
    sudo mv terraform-docs /usr/local/bin && \
    wget https://github.com/genevieve/leftovers/releases/download/v${LEFTOVERS_VERSION}/leftovers-v${LEFTOVERS_VERSION}-linux-amd64 && \
    mv leftovers-v${LEFTOVERS_VERSION}-linux-amd64 leftovers && \
    chmod +x leftovers && \
    sudo mv leftovers /usr/local/bin && \
    mkdir -p ~/.terraform.d/plugins && \
    curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v${TF_K14S_PLUGIN_VERSION}/terraform-provider-k14s-binaries.tgz" && \
    tar xzvf terraform-provider-k14s-binaries.tgz -C ~/.terraform.d/plugins/ && \
    rm -Rf terraform-provider-k14s-binaries.tgz && \
    wget -O tmc https://vmware.bintray.com/tmc/${TMC_VERSION}/linux/x64/tmc && \
    chmod +x tmc && \
    mv tmc /usr/local/bin && \
    curl -LO "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" && \
    tar -xvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    sudo mv linux-amd64/helm /usr/local/bin && \
    curl -Lo ./helmfile https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod +x helmfile && \
    sudo mv helmfile /usr/local/bin && \
    wget -O ytt https://github.com/k14s/ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64 && \
    chmod +x ytt && \
    sudo mv ytt /usr/local/bin && \
    wget -O vendir https://github.com/k14s/vendir/releases/download/v${VENDIR_VERSION}/vendir-linux-amd64 && \
    chmod +x vendir && \
    sudo mv vendir /usr/local/bin && \
    wget -O kapp https://github.com/k14s/kapp/releases/download/v${KAPP_VERSION}/kapp-linux-amd64 && \
    chmod +x kapp && \
    sudo mv kapp /usr/local/bin && \
    wget -O kbld https://github.com/k14s/kbld/releases/download/v${KBLD_VERSION}/kbld-linux-amd64 && \
    chmod +x kbld && \
    sudo mv kbld /usr/local/bin && \
    curl -LO https://dl.min.io/client/mc/release/linux-amd64/mc && \
    chmod +x mc && \
    sudo mv mc /usr/local/bin && \
    cd .. && rm -Rf downloads /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt clean

USER docker

FROM scratch

COPY --from=build / /

CMD /bin/bash
      