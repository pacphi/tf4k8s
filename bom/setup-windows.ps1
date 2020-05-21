Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
Set-ExecutionPolicy RemoteSigned -scope CurrentUser

scoop bucket add extras

#####################
# SOFTWARE
#####################

# 7Zip
scoop install 7zip

# Dev Tools
choco install bosh-cli
scoop install curl
scoop install git
scoop install vscode
scoop install aliyun
scoop install azure-cli
scoop install aws
scoop install doctl
scoop install gcloud
scoop install graphviz
scoop install terraform
scoop install tflint
scoop install httpie -source python
scoop install kubectl
scoop install helm
scoop install helmfile
scoop install octant
scoop tar install

Set-Variable TF_K14S_PLUGIN_VERSION 0.4.0
md $HOME/.terraform.d/plugins -ea 0
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v$TF_K14S_PLUGIN_VERSION/terraform-provider-k14s-binaries.tgz" && \
tar xzvf terraform-provider-k14s-binaries.tgz -C $HOME/.terraform.d/plugins/
Remove-Item terraform-provider-k14s-binaries.tgz


md $HOME/bin/k14s -ea 0

Set-Variable YTT_VERSION 0.27.2
curl -LO "https://github.com/k14s/ytt/releases/download/v$YTT_VERSION/ytt-windows-amd64.exe"
Rename-Item -Path "ytt-windows-amd64.exe" -NewName "ytt.exe"

Set-Variable VENDIR_VERSION 0.8.0
curl -LO "https://github.com/k14s/vendir/releases/download/v$VENDIR_VERSION/vendir-windows-amd64.exe"
Rename-Item -Path "vendir-windows-amd64.exe" -NewName "vendir.exe"

Set-Variable KAPP_VERSION 0.26.0
curl -LO "https://github.com/k14s/vendir/releases/download/v$KAPP_VERSION/kapp-windows-amd64.exe"
Rename-Item -Path "kapp-windows-amd64.exe" -NewName "kapp.exe"

Set-Variable PIVNET_VERSION 1.0.3
curl -LO "https://github.com/pivotal-cf/pivnet-cli/releases/download/v$PIVNET_VERSION/pivnet-windows-amd64-$PIVNET_VERSION"
Rename-Item -Path "pivnet-linux-amd64-$PIVNET_VERSION.exe" -NewName "pivnet.exe"

$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$HOME/bin/k14s"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

# @see https://docs.cloud.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm for how to install Oracle Cloud CLI