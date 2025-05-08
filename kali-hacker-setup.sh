#!/bin/bash

echo "\n🔥 Configurando tu gabinete hacker en Kali Linux...\n"

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar herramientas visuales estilo hacker
sudo apt install -y neofetch lolcat figlet bat exa lsd zsh git curl fonts-firacode arc-theme papirus-icon-theme xfce4-terminal unzip wget

# Instalar oh-my-zsh + powerlevel10k
echo "\n⚙️ Instalando oh-my-zsh y powerlevel10k...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \ 
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's|ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc

# Agregar neofetch con lolcat al inicio del zshrc
grep -qxF "neofetch | lolcat" ~/.zshrc || echo "neofetch | lolcat" >> ~/.zshrc

# Instalar Nerd Font (MesloLGS)
echo "\n📥 Instalando fuente hacker (MesloLGS NF)...\n"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
unzip -o Meslo.zip > /dev/null
fc-cache -fv
cd ~

# Aplicar tema oscuro e iconos (solo para XFCE)
echo "\n🎨 Aplicando tema oscuro e iconos...\n"
xfconf-query -c xsettings -p /Net/ThemeName -s "Arc-Dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"

# Cambiar fondo de pantalla estilo hacker
echo "\n🖼️ Estableciendo fondo hacker...\n"
wget -q -O ~/Pictures/hacker-wallpaper.jpg https://i.imgur.com/1aYw7hR.jpg
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s ~/Pictures/hacker-wallpaper.jpg

# Mensaje final
echo -e "\n✅ ¡Gabinete hacker listo! Reinicia tu terminal o haz 'source ~/.zshrc' para aplicar los cambios.\n"
