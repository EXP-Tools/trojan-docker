# PowerShell
# 清理 ARK 的存档、配置、日志
#------------------------------------------------
# 示例：bin/clean.ps1
#------------------------------------------------

$STEAM_DIR = "./volumes/steam"
$STEAM_GAME_DIR = "${STEAM_DIR}/games"
$ARK_APP_DIR = "${STEAM_GAME_DIR}/ark"
$ARK_SAVED_DIR = "${ARK_APP_DIR}/ShooterGame/Saved/SavedArks"
$ARK_CONFIG_DIR = "${ARK_APP_DIR}/ShooterGame/Saved/Config"
$ARK_LOGS_DIR = "${ARK_APP_DIR}/ShooterGame/Saved/Logs"


$CACHE_DIRS = "${ARK_SAVED_DIR}", "${ARK_CONFIG_DIR}", "${ARK_LOGS_DIR}"
FOREACH ($dir IN $CACHE_DIRS) {
    Write-Host "remove ${dir} ..."
    if (Test-Path $dir) {
        Remove-Item $dir -Recurse -Force
    }
}
Write-Host "done ."
