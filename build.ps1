$ErrorActionPreference = "Stop"

if(!(Get-Command -Name .\packer.exe )){
    Write-Error "packer command not found. Please install from https://packer.io/"
    exit 1
}

if(!(Get-Command -Name 7z.exe )){
    Write-Error "7z command not found. Please install from http://www.7-zip.org/"
    exit 1
}

$box_url="http://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7.box"
$box_tmp="boxtemp\7"

if(!(Test-Path -Path $box_tmp)){
    New-Item -ItemType directory -Path $box_tmp | Out-Null
}

if(!(Test-Path -Path "${box_tmp}\t.box")){
    Write-Host "Downloading ${box_url} to ${box_tmp}\t.box"
    Invoke-WebRequest -Uri $box_url -OutFile "${box_tmp}\t.box"
}

pushd $box_tmp
7z -y e "t.box"
7z -y x "t"
popd

if(!(Test-Path -Path "${box_tmp}\vagrant.key")){
    Write-Host "Downloading vagrant insecure key"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant" -OutFile "${box_tmp}\vagrant.key"
}

$env:HOST_SWITCH="VirtualBox Host-Only Ethernet Adapter"
$env:NIC2_IPV4="192.168.56.151"

.\packer build -force devbox-centos7.json
