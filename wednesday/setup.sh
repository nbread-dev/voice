#!/bin/zsh

# Function to install Homebrew if it's not already installed
install_brew() {
    echo "Homebrew's absence is noted. Summoning it..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew is now lurking in our system."
}

# Function to install Ruby using Homebrew
install_ruby() {
    echo "Ruby is elusive. Acquiring it via Homebrew..."
    brew install ruby
    echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zprofile
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    echo "Ruby has joined our dark rituals."
}

# Function to install CocoaPods using Ruby gem
install_pods() {
    echo "CocoaPods is absent. Procuring it..."
    brew install cocoapods
    echo "CocoaPods is now one with our coven."
}

# Function to install wed tool
install_wed() {
    local target_dir="/usr/local/bin"
    local script_name="wed"
    
    echo "Incorporating wed tool into our domain..."

    if [[ ! -d "$target_dir" ]]; then
        echo "The directory $target_dir does not exist. Creating it now..."
        sudo mkdir -p "$target_dir"
    fi

    # Copy the wed script to the target directory
    sudo cp -R "bin/wed.sh" "$target_dir/$script_name"

    # Make the script executable
    sudo chmod +x "$target_dir/$script_name"

    echo "wed tool has taken its place in $target_dir/$script_name."
}

# Verifying command existence
check_cmd() {
    local command=$1
    local confirmation=$2
    if ! command -v "$command" &>/dev/null; then
        echo -e "'$command' is not in our realm. Rectify this."
        return 1
    else
        echo -e "${confirmation:-$command is among us}"
        return 0
    fi
}

echo "Welcome to the Wed setup script. Let's begin our dark journey."
# Execute the functions based on command check
check_cmd brew "Homebrew is already with us. Proceeding..." || install_brew
check_cmd ruby "Ruby is present. Good." || install_ruby
check_cmd pod "CocoaPods is already in our fold. Excellent." || install_pods
install_wed
