echo "Copy to /..."
sudo cp -r ./etc/ /
echo "Start rebuild"
sudo nixos-rebuild switch --flake /etc/nixos
