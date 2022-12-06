# ------------------------
# 发布镜像
# bin/deploy.ps1 [-n NAMESPACE] [-v VERSION]
#   -n docker hub 的命名空间
#   -v 镜像版本号
# ------------------------

param([string]$v="", [string]$n="")

$VERSION = Get-Date -format "yyyyMMddHH"
if(![String]::IsNullOrEmpty($v)) {
    $VERSION = $v
}

$NAMESPACE = "expm02"
if(![String]::IsNullOrEmpty($n)) {
    $NAMESPACE = $n
}


function deploy_image([string]$image_name) {
    $remote_url = "${NAMESPACE}/${image_name}"
    docker tag ${image_name} "${remote_url}:${VERSION}"
    docker push "${remote_url}:${VERSION}"
    docker tag ${image_name} "${remote_url}:latest"
    docker push "${remote_url}:latest"
    Write-Host "Pushed to ${remote_url}"
}


Write-Host "Login to docker hub ..."
docker login
$image_name = (Split-Path $pwd -leaf)
deploy_image -image_name ${image_name}

Write-Host "finish ."