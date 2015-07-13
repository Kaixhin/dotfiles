# Source the user's bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set up directory colors
eval `dircolors .dircolors`
