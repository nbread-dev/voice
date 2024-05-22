#!/bin/zsh

# Simplified method to set color variables.
set_colors() {
    COLOR_INFO='\033[38;5;250m' COLOR_LOG='\033[38;5;240m'
    COLOR_SUCCESS='\033[38;5;22m' COLOR_WARNING='\033[38;5;55m'
    COLOR_ERROR='\033[38;5;88m' NC='\033[38;5;248m'
}

# Define the main function
wed() {
    set_colors

    local action=$1
    shift
    
    case $action in
        install-pods)
            install_pods
            ;;
        install-templates)
            install_templates "$@"
            ;;
        update-tool)
            update_tool "$@"
            ;;
        help|*)
            display_help
            ;;
    esac
}

# Function to display messages with colors
say() {
  local type=$1
  shift
  local message=$@

  case $type in
    info)
      echo -e "${COLOR_INFO}[Wed] 👩🏻‍💻 $message${NC}"
      ;;
    log)
      echo -e "${COLOR_LOG}[Wed] $message${NC}"
      ;;
    success)
      echo -e "${COLOR_SUCCESS}[Wed] 🖤 $message${NC}"
      ;;
    warning)
      echo -e "${COLOR_WARNING}[Wed] ⚰️ $message${NC}"
      ;;
    error)
      echo -e "${COLOR_ERROR}[Wed] 🔪 $message${NC}"
      ;;
    *)
      echo -e "${NC}[Wed] 🤷🏻‍♀️ $message${NC}"
      ;;
  esac
}

# Function to install CocoaPods if there's a Podfile in the current directory
install_pods() {
    if [[ -f "Podfile" ]]; then
        say info "Podfile detected. Let's summon the pods."
        if ! bundle check; then
            say info "Running bundle install to ensure all gems are installed."
            bundle install
        fi
        pod install
        say success "Pods have been successfully installed. Embrace the darkness."
    else
        say warning "No Podfile found in this bleak directory."
    fi
}

# Function to install templates from the specified folder
install_templates() {
    local template_folder=$1

    if [[ -d $template_folder ]]; then
        say info "Extracting templates from $template_folder..."
        cp -R "$template_folder"/* .
        say success "Templates have been installed. Perfection achieved."
    else
        say error "The specified folder does not exist: $template_folder. A tragic mistake."
    fi
}

# Function to update the wed tool
update_tool() {
    local tool_folder=$1

    if [[ -d $tool_folder ]]; then
        say info "Updating the wed tool from $tool_folder..."
        sudo cp -R "$tool_folder/bin/wed.sh" /usr/local/bin/wed
        chmod +x /usr/local/bin/wed
        say success "Wed tool has been updated. All is right with the world."
    else
        say error "The specified folder does not exist: $tool_folder. An unforgivable error."
    fi
}

# Function to display help information
display_help() {
    say info "Usage: wed <action> [arguments]"
    say log "Actions:"
    say log "  install-pods             Summon CocoaPods if there's a Podfile in the current directory"
    say log "  install-templates <dir>  Extract templates from the specified directory"
    say log "  update-tool <dir>        Update the wed tool from the specified directory"
    say log "  help                     Display this help message"
}

wed "$@"
