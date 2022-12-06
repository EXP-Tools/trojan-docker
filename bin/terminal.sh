#!/bin/bash
#------------------------------------------------
# 进入容器的交互终端
# 示例：bin/terminal.sh
#------------------------------------------------


CONTAINER_NAME="ARK_SVC"
CONTAINER_ID=`docker ps -aq --filter name="$CONTAINER_NAME"`
if [[ "${CONTAINER_ID}x" = "x" ]] ; then
    echo "[$CONTAINER_NAME] 容器没有运行 ..."
else
    docker exec -it -u $USER $CONTAINER_ID bash
fi
