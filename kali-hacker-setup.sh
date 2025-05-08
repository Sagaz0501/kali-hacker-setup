#!/bin/bash
#!/bin/bash

echo "\n🔥 Configurando tu gabinete hacker en Kali Linux...\n"

# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar herramientas visuales estilo hacker
sudo apt install -y neofetch lolcat figlet bat exa lsd zsh git curl fonts-firacode arc-theme papirus-icon-theme xfce4-terminal unzip wget ruby ruby-full xdotool wmctrl rofi dmenu

# Instalar oh-my-zsh + powerlevel10k
echo "\n⚙️ Instalando oh-my-zsh y powerlevel10k...\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \ 
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's|ZSH_THEME=.*|ZSH_THEME=\"powerlevel10k/powerlevel10k\"|' ~/.zshrc

# Agregar neofetch con lolcat al inicio del zshrc
grep -qxF "neofetch | lolcat" ~/.zshrc || echo "neofetch | lolcat" >> ~/.zshrc

# Instalar lolcat si no existe
if ! command -v lolcat &> /dev/null; then
  sudo gem install lolcat
fi

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
mkdir -p ~/Pictures
wget -q -O ~/Pictures/hacker-wallpaper.jpg https://i.imgur.com/1aYw7hR.jpg
bg_path="$(xfconf-query -c xfce4-desktop -l | grep image-path | head -n 1)"
if [ -n "$bg_path" ]; then
  xfconf-query -c xfce4-desktop -p "$bg_path" -s ~/Pictures/hacker-wallpaper.jpg
fi

# Minimalismo XFCE: quitar íconos y paneles extras
echo "\n🧹 Aplicando minimalismo visual...\n"
xfconf-query -c xfce4-desktop -p /desktop-icons/style -s 0
xfconf-query -c xfce4-panel -p /panels -n -t int -s 1
xfconf-query -c xfce4-panel -p /panels/panel-0/autohide -s 1
xfconf-query -c xfce4-panel -p /panels/panel-0/size -s 24
xfce4-panel --restart &

# Asignar atajos para controlar todo con teclado
xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p "/commands/custom/<Super>Return" -s "xfce4-terminal"
xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p "/commands/custom/<Super>d" -s "rofi -show drun"
xfconf-query -c xfce4-keyboard-shortcuts -n -t string -p "/commands/custom/<Super>r" -s "dmenu_run"

# Mensaje final
echo -e "\n✅ ¡Gabinete hacker listo! Reinicia tu sesión gráfica o ejecuta 'source ~/.zshrc' para aplicar los cambios.\n"
