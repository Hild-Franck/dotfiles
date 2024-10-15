#!/bin/sh

API_URL=https://discord.com/api/download/stable\?platform\=linux\&format\=deb
VERSION_FILE=~/.discord-version
DEB_TEMP_LOCATION=/tmp/discord.deb

current_version=$(cat $VERSION_FILE 2>/dev/null)
latest_version=$(curl -sIX HEAD "$API_URL" | grep -Po "discord-.*?\.deb")

echo "Current version: $current_version"

if [ "$current_version" != "$latest_version" ]; then
  echo "New discord version available: $latest_version."
  curl -o "$DEB_TEMP_LOCATION" -LX GET "$API_URL"
  sudo dpkg -i "$DEB_TEMP_LOCATION"
  echo "$latest_version" > $VERSION_FILE
else
  echo "Discord is up-to-date"
fi
