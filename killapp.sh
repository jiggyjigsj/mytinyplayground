#!/bin/bash

# This script is used to kill common work applications.

############################################################################
## FUNCTIONS:

# Function to return application is running or not,
function output {
    out="$(ps -ax | grep Application | grep "$1" | awk '{print $1;}')"
}

function killing {
unset REPLY stat
echo -e "\nAre you sure you want to continue quiting $1 Y/n"
    read -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cat <<EOF
       . 
   O  .  .
  <\==-   -   - -   -  -  - ---
 ./ \.                           _/\_\O
EOF
        stat=1;
    else
        stat=0;
    fi
}

# Function to close all application
function all {
    if [[ $stat == 1 ]] ; then
        onenote
        lync
        citrixreceiver
        terminal

    else
        echo -e "\nAborting Killing! "
    fi
}

# Function to kill OneNote
function onenote {
    output OneNote
    
    if [[ ! -z $out ]] && [[ $stat == 1 ]] ; then
        kill -9 $out
        echo "Microsoft OneNote closed succesfully!"
    elif [[ $stat == 0 ]]; then
        echo -e "\nAborting Killing! "
    else    
        echo "Microsoft OneNote not running or might have been closed out manually!"
    fi
    sleep 1
}

# Function to kill Lync
function lync {
    output Lync
    
    if [[ ! -z $out ]] && [[ $stat == 1 ]] ; then
        kill -15 $out
        echo "Microsoft Lync closed succesfully!"
    elif [[ $stat == 0 ]]; then
        echo -e "\nAborting Killing! "
    else    
        echo "Microsoft Lync not running or might have been closed out manually!"
    fi
    sleep 1
}

# Function to kill Citrix Reciever
function citrixreceiver {
    output "Citrix Receiver"
    if [[ ! -z $out ]] && [[ $stat == 1 ]] ; then
        kill -15 $out
        echo "Citrix Receiver closed succesfully!"
    elif [[ $stat == 0 ]]; then
        echo -e "\nAborting Killing! "
    else    
        echo "Citrix Reciever not running or might have been closed out manually!"
    fi
    sleep 1
}

# Function to kill iTerm 2
function terminal {
    output iTerm2
    
    if [[ ! -z $out ]] && [[ $stat == 1 ]] ; then
        kill -15 $out
        echo "iTerm2 closed succesfully!"
    elif [[ $stat == 0 ]]; then
        echo -e "\nAborting Killing! "
    else    
        echo "iTerm2 not running or might have been closed out manually!"
    fi
    sleep 1
}

# Function to kill Microsoft Teams
function teams {
    output "Microsoft Teams"
    
    if [[ ! -z $out ]] && [[ $stat == 1 ]] ; then
        kill -9 $out
        echo "Microsoft OneNote closed succesfully!"
    elif [[ $stat == 0 ]]; then
        echo -e "\nAborting Killing! "
    else    
        echo "Microsoft Teams not running or might have been closed out manually!"
    fi
    sleep 1
}

############################################################################
## SCRIPT:

# #Teams
# Sublime
# Slack
# Spotify
# Outlook
# 

while :
do
    unset out
    clear

    echo "==================================="
    echo "The Killing Machine - Choose Wisely"
    echo "Choose one of the options below"
    echo "-----------------------------------"
    echo "(Q) Quit"
    echo "(R) Refresh list"
	echo "(A) All Application"

    i=1
    output "Citrix Receiver"
    if [[ ! -z $out ]]; then
        echo "($i) Citrix Reciever"
        a=$i
        unset out
        ((i++))
    fi
    
    output "OneNote"
    if [[ ! -z $out ]]; then
        echo "($i) Microsoft OneNote"
        b=$i
        unset out
        ((i++))
    fi 
    
    output "Microsoft Lync"
    if [[ ! -z $out ]]; then
        echo "($i) Microsoft Lync"
        c=$i
        unset out
        ((i++))
    fi

    output "Microsoft Teams"
    if [[ ! -z $out ]]; then
        echo "($i) Microsoft Teams"
        d=$i
        unset out
        ((i++))
    fi

    output "iTerm2"
    if [[ ! -z $out ]]; then
        echo "($i) iTerm"
        e=$i
        unset out
        ((i++))
    fi

    unset out
    read -r -p "Select an application to close:"
    case "$REPLY" in
    [aA])   killing "All Applications"
            all ;;
    $a)   killing "Citrix Reciever"
            citrixreceiver ;;
    $b)   killing "Microsoft OneNote"
            onenote ;;
    $c)   killing "Microsoft Lync"
            lync ;;
    $d)   killing "Microsoft Teams"
            teams ;;
    $e)   killing "iTerm2"
            terminal ;;
    [rR])   echo -e "\nRefreshing" ;;
    [qQ])   echo -e "\n Thank you for using the killing machine!"
            exit 1;;
      * )   echo -e "\nYou bad person! Wrong choice!"
            sleep 1 ;;
    esac
    sleep 1
done