#!/bin/ash

# Colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

# Function to print messages with colors
log_success() {
    echo -e "${GREEN}[Lets Gooo Online 💚🚀] $1${RESET}"
}

log_warning() {
    echo -e "${YELLOW}[WARNING] $1${RESET}"
}

log_error() {
    echo -e "${RED}[ERROR] $1${RESET}"
}

# Clean up temp directory
echo "⏳ Cleaning up temporary files..."
if rm -rf /home/container/tmp/*; then
    log_success "Temporary files removed successfully."
else
    log_error "Failed to remove temporary files."
    exit 1
fi

# Start PHP-FPM
echo "⏳ Starting PHP-FPM..."
if /usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize; then
    log_success "PHP-FPM started successfully."
else
    log_error "Failed to start PHP-FPM."
    exit 1
fi

# NGINX if else WIP
echo "⏳ Starting Nginx..."
# Final message
clear
log_success " 
_____   __      _____             ______________            _________
___  | / /___  ___  /_______________  ____/__  /_________  _______  /
__   |/ /_  / / /  __/_  ___/  __ \  /    __  /_  __ \  / / /  __  / 
_  /|  / / /_/ // /_ _  /   / /_/ / /___  _  / / /_/ / /_/ // /_/ /  
/_/ |_/  \__,_/ \__/ /_/    \____/\____/  /_/  \____/\__,_/ \__,_/   
                                                                     webfree v2.1 | 7T team©
"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/

# Keep the container running (optional, depending on your container setup)
tail -f /dev/null
