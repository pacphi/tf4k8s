# This script should be run in an administrative shell
# It installs software using combination of two package managers: Chocolately and Scoop

# @see https://gist.github.com/mkropat/c1226e0cc2ca941b23a9
function Add-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -notcontains $Path) {
            $persistedPaths = $persistedPaths + $Path | where { $_ }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | where { $_ }
        $env:Path = $envPaths -join ';'
    }
}

function Remove-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    if ($Container -ne 'Session') {
        $containerMapping = @{
            Machine = [EnvironmentVariableTarget]::Machine
            User = [EnvironmentVariableTarget]::User
        }
        $containerType = $containerMapping[$Container]

        $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';'
        if ($persistedPaths -contains $Path) {
            $persistedPaths = $persistedPaths | where { $_ -and $_ -ne $Path }
            [Environment]::SetEnvironmentVariable('Path', $persistedPaths -join ';', $containerType)
        }
    }

    $envPaths = $env:Path -split ';'
    if ($envPaths -contains $Path) {
        $envPaths = $envPaths | where { $_ -and $_ -ne $Path }
        $env:Path = $envPaths -join ';'
    }
}

function Get-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Machine', 'User')]
        [string] $Container
    )

    $containerMapping = @{
        Machine = [EnvironmentVariableTarget]::Machine
        User = [EnvironmentVariableTarget]::User
    }
    $containerType = $containerMapping[$Container]

    [Environment]::GetEnvironmentVariable('Path', $containerType) -split ';' |
        where { $_ }
}

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')


#####################
# BILL OF MATERIALS
#####################

scoop install git
scoop bucket add extras

# 7Zip
scoop install 7zip

# Dev Tools
scoop install aria2
choco install -y bosh-cli
scoop install curl
scoop install vscode
scoop install aliyun
scoop install azure-cli
choco install -y aws-iam-authenticator
scoop install aws
choco install -y cloudfoundry-cli
scoop install doctl
scoop install gcloud
choco install -y gnupg
scoop install graphviz
scoop install terraform
choco install -y terraform-docs
scoop install tflint
choco install -y httpie -source python
choco install -y keybase
scoop install kubectl
scoop install k9s
scoop install helm
scoop install helmfile
scoop install octant
scoop tar install

Set-Variable TF_K14S_PLUGIN_VERSION 0.4.0
md $HOME/.terraform.d/plugins -ea 0
curl -LO "https://github.com/k14s/terraform-provider-k14s/releases/download/v$TF_K14S_PLUGIN_VERSION/terraform-provider-k14s-binaries.tgz"
tar xzvf terraform-provider-k14s-binaries.tgz -C $HOME/.terraform.d/plugins/
Remove-Item terraform-provider-k14s-binaries.tgz


md $HOME/.apps/bin -ea 0
cd $HOME/.apps/bin

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

Set-Variable ARGOCD_VERSION 1.5.6
curl -LO "https://github.com/argoproj/argo-cd/releases/download/v$ARGOCD_VERSION/argocd-windows-amd64.exe"
Rename-Item -Path "argocd-windows-amd64.exe" -NewName "argocd.exe"

Add-EnvPath -Path "$HOME/.apps/bin" -Container "Machine"
