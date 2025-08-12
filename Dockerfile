FROM jenkins/inbound-agent:latest

USER root

# 安装 Terraform
RUN apt-get update && apt-get install -y \
    curl unzip gnupg lsb-release software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    terraform -install-autocomplete && \
# 安装 kubectl（适配 ARM64 架构）
    curl -LO "https://dl.k8s.io/release/v1.28.0/bin/linux/arm64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    apt-get clean

USER jenkins
