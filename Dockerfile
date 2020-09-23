FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive
ENV POWERSHELL_CLI_TELEMETRY_OPTOUT=1
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_TELEMETRY_OPTOUT=1

RUN apt-get update; \
        apt-get install -y --no-install-recommends wget ca-certificates tzdata software-properties-common apt-transport-https unzip curl gnupg libunwind8 nano httpie mtr iputils-ping iputils-tracepath traceroute mtr iproute2 dnsutils; \
		apt-get upgrade; \
        apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*

# Kubernetes Powershell
RUN wget --directory-prefix=/usr/share/keyrings https://packages.microsoft.com/keys/microsoft.asc; \
        gpg --dearmor --yes /usr/share/keyrings/microsoft.asc; \
        . /etc/os-release; \
        echo "deb [signed-by=/usr/share/keyrings/microsoft.asc.gpg] https://packages.microsoft.com/debian/$VERSION_ID/prod $VERSION_CODENAME main" > /etc/apt/sources.list.d/microsoft.list; \
		wget -O /usr/share/keyrings/kubernetes-key.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg; \
		sh -c "echo 'deb [signed-by=/usr/share/keyrings/kubernetes-key.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list"; \
		apt-get update; \
		apt-get install -y --no-install-recommends powershell kubectl google-cloud-sdk; \
		apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["pwsh"]


