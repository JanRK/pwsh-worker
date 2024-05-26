FROM quay.io/janrk/pwsh-slim

RUN apt-get update; \
	        apt-get install -y --no-install-recommends wget tzdata software-properties-common unzip curl gnupg libunwind8 nano httpie iputils-ping iputils-tracepath traceroute iproute2 dnsutils netcat-openbsd git; \
		# apt-get install -y --no-install-recommends mtr
		apt-get upgrade; \
	        apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*

# Kubernetes
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg; \
		chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg; \
  		echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list; \
		sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list; \
		apt-get update; \
		apt-get install -y --no-install-recommends kubectl; \
		apt-get purge -y --auto-remove; apt-get clean; rm -rf /var/lib/apt/lists/*
