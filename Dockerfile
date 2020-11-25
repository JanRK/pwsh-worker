FROM quay.io/janrk/pwsh-slim

RUN apt-get update; \
        apt-get install -y --no-install-recommends wget tzdata software-properties-common unzip curl gnupg libunwind8 nano httpie iputils-ping iputils-tracepath traceroute iproute2 dnsutils netcat git; \
		# apt-get install -y --no-install-recommends mtr
		apt-get upgrade; \
        apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*

# Kubernetes
RUN wget -O /usr/share/keyrings/kubernetes-key.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg; \
		. /etc/os-release; \
		sh -c "echo 'deb [signed-by=/usr/share/keyrings/kubernetes-key.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' > /etc/apt/sources.list.d/kubernetes.list"; \
		apt-get update; \
		apt-get install -y --no-install-recommends kubectl openssh-server; \
		apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*
