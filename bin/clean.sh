#!/bin/bash
# 清理 ARK 的存档、配置、日志
#------------------------------------------------
# 示例：bin/clean.sh
#------------------------------------------------

STEAM_DIR="./volumes/steam"
STEAM_GAME_DIR="${STEAM_DIR}/games"
ARK_APP_DIR="${STEAM_GAME_DIR}/ark"
ARK_SAVED_DIR="${ARK_APP_DIR}/ShooterGame/Saved/SavedArks"
ARK_CONFIG_DIR="${ARK_APP_DIR}/ShooterGame/Saved/Config"
ARK_LOGS_DIR="${ARK_APP_DIR}/ShooterGame/Saved/Logs"


echo "remove ${ARK_SAVED_DIR} ..."
rm -rf ${ARK_SAVED_DIR}

echo "remove ${ARK_CONFIG_DIR} ..."
rm -rf ${ARK_CONFIG_DIR}

echo "remove ${ARK_LOGS_DIR} ..."
rm -rf ${ARK_LOGS_DIR}

echo "done ."
