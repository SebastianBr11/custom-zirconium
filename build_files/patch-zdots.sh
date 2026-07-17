echo "Patching zdots"

SHARE_PATH=/usr/share
CTX_SHARE_PATH=/ctx/system/usr/share

export ZDOTS_DMS_SETTINGS=$SHARE_PATH/zirconium/zdots/dot_config/DankMaterialShell/settings.json
export CUSTOM_DOTS_DMS_SETTINGS=$CTX_SHARE_PATH/custom-zirconium/cz-dotfiles/.config/DankMaterialShell/settings-patch.json
export ZDOTS_DMS_SESSION=$SHARE_PATH/zirconium/zdots/private_dot_local/state/DankMaterialShell/session.json
export CUSTOM_DOTS_DMS_SESSION=$CTX_SHARE_PATH/custom-zirconium/cz-dotfiles/.local/state/DankMaterialShell/session-patch.json

echo "Patching DankMaterialShell config with"
cat "$CUSTOM_DOTS_DMS_SETTINGS"

yq -i '. *= load(strenv(CUSTOM_DOTS_DMS_SETTINGS))' "$ZDOTS_DMS_SETTINGS"

echo "Patching DankMaterialShell session with"
cat "$CUSTOM_DOTS_DMS_SESSION"

yq -i '. *= load(strenv(CUSTOM_DOTS_DMS_SESSION))' "$ZDOTS_DMS_SESSION"

echo "settings.json"
cat "$ZDOTS_DMS_SETTINGS"

echo "session.json"
cat "$ZDOTS_DMS_SESSION"

echo "Patched zdots"
