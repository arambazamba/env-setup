# Windows Subsystem for Linux

Install Windows Subsystem for Linux

```
wsl --install
```

Reboot PC -> Start Ubuntu und set initial credentials

Create hushlogin:

```
touch ~/.hushlogin
```

## Azure CLI

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

Enable dynamic extension download

```
az config set extension.use_dynamic_install=yes
```

## Node

```
sudo apt update
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo bash
sudo apt-get install -y nodejs
```

## .NET

```bash
wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-3.1

sudo apt-get update; \
sudo apt-get install -y apt-transport-https && \
sudo apt-get update && \
sudo apt-get install -y dotnet-sdk-6.0
```
