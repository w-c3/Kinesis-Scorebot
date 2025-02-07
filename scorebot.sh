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
echo "Ubuntu 22 Finals Prep Image 1"
echo " "

# example usage
#check_text_exists "/etc/passwd" "administrator" "Added administrator user" # DELETE THIS

#cole shannigans
check_text_not_exists "/etc/passwd" "cole" "unauthorized user removed"
check_file_deleted "/usr/share/icons/badscript.sh" "bad script removed"
check_text_not_exists "/etc/systemd/system/syslog.service" "/usr/share/icons/badscript.sh" "syslog service no longer hijacked"

#user stuff
check_file_deleted "/etc/sudoers.d/.README" "bad file deleted"

#sysctl you figure out from forensic
check_text_not_exists "/etc/sysctl.conf" "net.ipv4.ip_forward = 1" "Hardening point"


#forensics
check_text_exists "/home/lia/Desktop/Forensics1" "/etc/sgml/docbook-xml/4.0/dbgenent.ent" "forensics 1" 
#root@finalsprep1:/etc# ls -Ralt | grep 2000
#-rw-r--r-- 1 root root 1595 May 18  2000 dbgenent.ent
# ls -Ralt

check_text_exists "/home/lia/Desktop/Forensics2" "/proc/sys/net/ipv4/ip_forward" "forensics dos"

#penny things
check_text_not_exists "/etc/sudo.conf" "Plugin sudoers_policy /home/stevejr/cheese/custom.so" "sudo no longer bad"


#NO GUI WE HATE IT
#sudo systemctl set-default multi-user

#https://github.com/milabs/awesome-linux-rootkits
#https://security.stackexchange.com/questions/273216/kernel-level-attack
