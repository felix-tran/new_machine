!/bin/bash

if [[ $(defaults read .GlobalPreferences com.apple.mouse.scaling) != -1 ]]; then
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
  echo "Disabling Mouse Acceleration.."
else
  echo "Mouse Acceleration is already disabled."
fi
