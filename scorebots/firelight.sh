#!/bin/bash
echo " "
echo "Kinesis Scorebot v2"
echo "NOTE: Please allow up to 5 minutes for scorebot updates & injects."
echo "Injects: NO" # Modify this if you run an inject

# Function to check if text exists in a file
check_text_exists() {
    local file="$1"
    local text="$2"
    local vuln_name="$3"
    
    if grep -q "$text" "$file"; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

# Function to check if text does not exist in a file
check_text_not_exists() {
    local file="$1"
    local text="$2"
    local vuln_name="$3"
    
    if ! grep -q "$text" "$file"; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

# Function to check if a file exists
check_file_exists() {
    local file="$1"
    local vuln_name="$2"
    
    if [ -e "$file" ]; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

# Function to check if a file has been deleted
check_file_deleted() {
    local file="$1"
    local vuln_name="$2"
    
    if [ ! -e "$file" ]; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

check_file_permissions() {
    local file="$1"
    local expected_permissions="$2"
    local vuln_name="$3"
    
    # Get the actual permissions of the file in numeric form (e.g., 644)
    actual_permissions=$(stat -c "%a" "$file")
    
    if [ "$actual_permissions" == "$expected_permissions" ]; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

check_file_ownership() { # Thanks Coyne <3
    local file="$1"
    local expected_owner="$2"
    local vuln_name="$3"
     if getfacl "$file" 2>/dev/null | grep -q "owner: $expected_owner"; then
        echo "Vulnerability fixed: '$vuln_name'"
    else
        echo "Unsolved Vuln"
    fi
}

echo " "
echo ">> Firelight LAMPSS Round 4 <<"
echo " "

# scoring
check_text_exists "/home/ekko/Desktop/Forensics_1.txt" "caitlynk@arcane.com" "Forensics 1 Correct"

# Apache
check_text_exists "/etc/apache2/apache2.conf" " -Indexes " "Fixed insecure Apache2 configuration."
check_text_exists "/etc/apache2/conf-enabled/security.conf" "ServerTokens Prod" "Fixed insecure Apache2 configuration."
check_text_exists "/etc/apache2/conf-enabled/security.conf" "TraceEnable Off" "Fixed insecure Apache2 configuration."
check_text_exists "/etc/apache2/ports.conf" "443" "Fixed insecure Apache2 configuration."
check_file_permissions "/var/www/html" "755" "Fixed permissions on /var/www/html"

# MySQL
check_text_exists "/etc/mysql/mysql.conf.d/mysqld.cnf" "3306" "Fixed insecure MySQL configuration."
check_text_exists "/etc/mysql/mysql.conf.d/mysqld.cnf" "100M" "Fixed insecure MySQL configuration."
check_text_not_exists "/etc/mysql/mysql.conf.d/mysqld.cnf" "1M" "Fixed insecure MySQL configuration."

# PHP
check_text_exists "/etc/php/8.1/apache2/php.ini" "expose_php = Off" "Fixed insecure PHP configuration."
check_text_exists "/etc/php/8.1/apache2/php.ini" "display_errors = Off" "Fixed insecure PHP configuration."
check_text_exists "/etc/php/8.1/apache2/php.ini" "allow_url_include = Off" "Fixed insecure PHP configuration."
check_text_exists "/etc/php/8.1/apache2/php.ini" "upload_max_filesize = 2M" "Fixed insecure PHP configuration."

# Squid
check_text_not_exists "/etc/squid/squid/conf" "http_access allow all" "Removed insecure SquidProxy configuration"
check_text_not_exists "/etc/squid/squid/conf" "icap_enable off" "Removed insecure SquidProxy configuration"
check_text_exists "/usr/lib/systemd/system/squid.service" "User=squid" "Fixed insecure SquidProxy configuration"
check_text_exists "/usr/lib/systemd/system/squid.service" "Group=squid" "Fixed insecure SquidProxy configuration"
check_text_exists "/etc/squid/squid.conf" "httpd_suppress_version_string on" "Fixed insecure SquidProxy configuration"

# SSH

# Unwanted shtuff
check_file_deleted "/bin/proxychains" "Removed unauthorized software." #proxychains
check_file_deleted "/usr/sbin/hunt" "Removed unauthorized software."
check_file_deleted "/etc/p0f" "Removed unauthorized software." # P0f




