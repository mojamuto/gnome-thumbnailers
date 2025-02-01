#!/bin/bash

sudo xbps-install -Sy ImageMagick librsvg-utils #papirus-icon-theme
cat <<EOF |sudo tee /usr/bin/folder-thumbnailer>/dev/null
ICON=\$(cat "\$2/.directory"|grep =|sed 's@Icon=@/usr/share/icons/Papirus/64x64/places/@g')
rsvg-convert -w 256 -h 256 "\$ICON".svg -o "\$2/.tmp-folder-icon.png"
if [ -f "\$2/.tmp-folder-icon.png" ]; then
	convert -thumbnail "\$1" "\$2/.tmp-folder-icon.png" "\$3" 1>/dev/null 2>&1
	rm -rf "\$2/.folder-icon.png"
elif [ -f "\$2/.cover.jpg" ]; then
	convert -thumbnail "\$1" "\$2/.cover.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.cover.png" ]; then
	convert -thumbnail "\$1" "\$2/.cover.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/cover.jpg" ]; then
	convert -thumbnail "\$1" "\$2/cover.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/cover.png" ]; then
	convert -thumbnail "\$1" "\$2/cover.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.folder.jpg" ]; then
	convert -thumbnail "\$1" "\$2/.folder.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.folder.png" ]; then
	convert -thumbnail "\$1" "\$2/.folder.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/folder.jpg" ]; then
	convert -thumbnail "\$1" "\$2/folder.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/folder.png" ]; then
	convert -thumbnail "\$1" "\$2/folder.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.logo.jpg" ]; then
	convert -thumbnail "\$1" "\$2/.logo.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.logo.png" ]; then
	convert -thumbnail "\$1" "\$2/.logo.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/logo.jpg" ]; then
	convert -thumbnail "\$1" "\$2/logo.jpg" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/logo.png" ]; then
	convert -thumbnail "\$1" "\$2/logo.png" "\$3" 1>/dev/null 2>&1
elif [ -f "\$2/.cover.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/.cover.svg" -o "\$2/.cover.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/.cover.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/.cover.png"
elif [ -f "\$2/cover.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/cover.svg" -o "\$2/cover.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/cover.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/cover.png"
elif [ -f "\$2/.folder.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/.folder.svg" -o "\$2/.folder.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/.folder.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/.folder.png"
elif [ -f "\$2/folder.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/folder.svg" -o "\$2/folder.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/folder.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/folder.png"
elif [ -f "\$2/.logo.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/.logo.svg" -o "\$2/.logo.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/.logo.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/.logo.png"
elif [ -f "\$2/logo.svg" ]; then
	rsvg-convert -w 256 -h 256 "\$2/logo.svg" -o "\$2/logo.png" 1>/dev/null 2>&1
	convert -thumbnail "\$1" "\$2/logo.png" "\$3" 1>/dev/null 2>&1
	rm "\$2/logo.png"
else
	rm -f "\$HOME/.cache/thumbnails/normal/\$(echo -n "\$4" | md5sum | cut -d " " -f1).png" || \
	rm -f "\$HOME/.thumbnails/normal/\$(echo -n "\$4" | md5sum | cut -d " " -f1).png" || \
	rm -f "\$HOME/.cache/thumbnails/large/\$(echo -n "\$4" | md5sum | cut -d " " -f1).png" || \
	rm -f "\$HOME/.thumbnails/large/\$(echo -n "\$4" | md5sum | cut -d " " -f1).png"
fi
EOF
sudo chmod +x /usr/bin/folder-thumbnailer
mkdir -p "$HOME"/.local/share/thumbnailers
cat <<EOF |tee "$HOME"/.local/share/thumbnailers/folder.thumbnailer>/dev/null
[Thumbnailer Entry]
Version=1.0
Encoding=UTF-8
Type=X-Thumbnailer
Name=Folder Thumbnailer
MimeType=inode/directory;
Exec=folder-thumbnailer %s %i %o %u
EOF
thunar -q
