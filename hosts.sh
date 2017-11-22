#!/bin/bash

# This script is used to write alias and also add entries to /etc/hosts file
# It uses a bash's getops to take flags from user.
# Look for function: usage() for usage
############################################################################
## VARIABLES:

# Set variables to blank
PEM=
CSV_FILE=
WORD=
HOST=0
DEL=
TEST=

# Flag for fail message.
msg=0
error="Errors: "
check=

############################################################################
## FUNCTIONS:

# Function to return command usage
usage()
{
  printf "For usage run: %s: -h \n" $0
}

# Help flag
help()
{
  printf "NAME: hosts.sh - Script to create alias for quick ssh session\n\n"
  printf "SYSNOPSIS:\n"
  echo -e "         \033[91m ./hosts.sh \033[96m[ -f file ] [ -p key ] \033[0m \n"
  printf "DESCRIPTION: A Script written to allows create ssh alias for multiple clients.  This script requires the 'etsops.pem' and 'client.csv' file from github.  This script also allows the user to have various other features such as: Remove alias, write to /etc/hosts file for easy mapping, and delete backups of hosts files.\n\n"
  printf "OPTIONS: \n"
  echo -e "        \033[91m[ -f <Location to Client CSV File> ] \033[0m Client CSV file from Appliance-mapping repo."
  echo -e "        \033[91m[ -p <Location to pem file> ]\033[0m etsops.pem file for client from gps-vault"
  echo -e "        \033[91m{ -e } \033[0m Write to /etc/hosts file"
  echo -e "        \033[91m{ -w <First 5 of hostname> } \033[0m Erase alias and entries from /etc/hosts file"
  echo -e "        \033[91m{ -d } \033[0m Delete backups of hosts files\n"

  echo "--------------------------------------------------------------------------------------------------------------------"
  echo "|     Flags         |       Outcome          |                  Example"
  echo "--------------------------------------------------------------------------------------------------------------------"
  echo "|-f, -p             | alias                  | -f ../muns_mi.report.csv -p \$keys/muns_mi/etsops.pem"
  echo "|-f, -p, -e         | hosts and alias        | -f ../muns_mi.report.csv -p ../etsops.pem -e"
  echo "|-w                 | delete alias           | -w muns_mi"
  echo "|-w, -e             | delete alias and hosts | -w muns_mi -e"
  echo "|-d                 | delete hosts backup    | -d"
  echo "|-f, -p, -w, -d. -e | Loop                   | -f ../muns_mi.report.csv -p \$keys/muns_mi/etsops.pem -w muns_mi -d -e"
  echo "--------------------------------------------------------------------------------------------------------------------"

}

# Read the csv file and get each column into an array.
# service host_name domain millennium_env FD_1 FD_2 FD_3 ip_address is_virtual_ip vpn_ip_address
function readcsv {
  i=0
  heading="_ host_name domain _ _ _ _ ip_address _ vpn_ip_address"

  if [[ $1 == "cern_ac"* ]] || [[ $1 == *"dev1_mo"* ]]; then
    heading="_ host_name domain _ _ _ ip_address _ vpn_ip_address"
  fi

  while IFS=, read -r $heading
  do
    vpn_ip_addresses[$i]=$vpn_ip_address
    host_names[$i]=$host_name
    domains[$i]=$domain
    ip_addresses[$i]=$ip_address
    ((i++))
  done < $1
}

# Function to save vpn_ip_address and hostname to /etc/hosts
function hosts {
  fqdn="$2.$3"
  HOSTS_LINE="$1 $2 $fqdn"
  DATE=`date +%Y%m%d%H:%M:%S`
  file="$HOME/.clients"

  #filename=$(basename $PEM)
  #username="${filename%.*}"

  if [ ! -f $file ]; then
    touch $file
  fi
  profile

  if [[ $HOST == 1 ]]; then
    if [[ $a != 1 ]]; then
      ask
      sudo -- sh -c -e "cp /etc/hosts /etc/hosts-$DATE"
      a=1
    fi

    if grep -Fxq "$HOSTS_LINE" /etc/hosts ; then
      echo "$HOSTS_LINE - Exists"
    else
      echo "$HOSTS_LINE - Added"
      sudo -- sh -c -e "echo '$HOSTS_LINE' >> /etc/hosts";
    fi
  fi

  if grep -q $2 $file ; then
    echo "Alias $2 already exists"
  else
    if [[ -e "$file" ]] && [[ -e "$PEM" ]]; then
      echo "Writing alias $2"
      user=$(whoami)
      jump="$user@choaplmgmt101.cernerasp.com"
      username="etsops"
      if [[ $CSV_FILE == *"dev"* ]]; then
        jump="$user@10.190.189.127"
        username="cloud-user"
      fi
      if [[ $CSV_FILE == *"dev"* ]]; then
        jump="$user@10.190.189.127"
        username="cloud-user"
      fi
      echo "alias $2=\"ssh -o ProxyCommand='ssh -W %h:%p -q -o StrictHostKeyChecking=no $jump' -i $PEM $username@$1\"" >> $file
      sourcealias=1
    fi
  fi
}

# Function to add paths to profile
function profile {
  shell=`echo $SHELL`
  if [[ $shell == "/bin/zsh" ]]; then
    location="$HOME/.zshrc"
  else
    location="$HOME/.bashrc"
  fi
  text="source $HOME/.clients"

  if grep -q "$text" $location ; then
    :
  else
    echo "" >> $location
    echo "if [[ -e $file ]]; then" >> $location
    echo "    source $HOME/.clients" >> $location
    echo "fi" >> $location
    echo "" >> $location
  fi
}

# Remove client related lines from /etc/hosts
function delete {

  DATE=`date +%Y%m%d%H:%M:%S`

  if [[ $HOST == 1 ]]; then
    echo "Deleting the following from /etc/hosts:"
    sudo cat /etc/hosts | grep $1
    ask
    sudo sed -i-$DATE "/$1/d" /etc/hosts 2>&1

    if grep -Fxq "$1" /etc/hosts ; then
      error="$error Unable to delete from /etc/hosts"
      msg=1
    fi
  fi

  if [[ -e $HOME/.clients ]]; then
    echo "Deleteing the following alias"
    cat $HOME/.clients | grep $1 | cut -d ' ' -f 2 | cut -d '=' -f 1
    ask
    sed -i '' -e "/$1/d" $HOME/.clients 2>&1
    if grep -Fxq "$1" $HOME/.clients ; then
      error="$error Unable to delete from $HOME/.clients"
      msg=1
    fi
  fi
}

# Simple function to delete all backup hosts file.
function deletehost {
  sudo rm /etc/hosts-*
}

function ask {
  echo "Are you sure you want to continue? Y/n"
  read -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    return 0;
  else
    echo -e "\nExiting."
    exit
  fi
}
############################################################################
## Menu:

# Using getops capabilities to integrate flags
while getopts :f:p:w:edhrt name
do
  case $name in
    f)  CSV_FILE="$OPTARG";;
    p)  PEM="$OPTARG";;
    w)  WORD="$OPTARG";;
    d)  DEL=1;;
    e)  HOST=1;;
    t)  TEST=1;;
    h)  help
    exit 2;;
    ?)  usage
    exit 2;;
  esac
done

# Check if no flags were passed and exit if none.
if [ $OPTIND -eq 1 ]; then
  usage
  exit 2
fi
shift $((OPTIND-1))


############################################################################
## SCRIPT:

# Pass the csv file after check and to function readcsv
if [[ -e "$CSV_FILE" ]] && [[ -e "$PEM" ]]; then
  chk=0
  readcsv $CSV_FILE
  a=0
  for ((i = 0; i < ${#vpn_ip_addresses[@]}; i++));
  do
    ip=$(echo ${vpn_ip_addresses[$a]})
    if [[ $CSV_FILE == *"_au"* ]] || [[ $CSV_FILE == *"dev"* ]]; then
      ip=$(echo ${ip_addresses[$a]})
    fi
    host_name=$(echo ${host_names[$a]})
    domain=$(echo ${domains[$a]})
    ((a++))
    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
      sourcealias=0
      hosts $ip $host_name $domain
      chk=1
    fi
  done
  if [[ $sourcealias == 1 ]] && [[ -f $HOME/.clients ]]; then
      echo "Run the following to update profile: source $HOME/.clients"
  fi
  check=1
  if [[ $chk == 0 ]]; then
    echo "No valid IP's Found."
  fi
fi

if [[ ! -z "${WORD// }" ]]; then
  if [[ ${#WORD} -lt 5 ]] || [[ ${WORD} != *"_"* ]]; then
    echo "Please use client mnemonic. i.e cern_ac"
    exit
  fi
  WORD=$(echo ${WORD} | tr '[:upper:]' '[:lower:]')
  WORD=$(echo ${WORD//_})

  if [[ ${WORD} == "dev1mo" ]]; then
    WORD="devmo1"
  fi

  delete $WORD
  check=1
fi

if [[ ! -z "${DEL// }" ]]; then
  deletehost
  check=1
fi

if [[ ! -z "${TEST// }" ]]; then
  # To test my codes.
  exit
  check=1
fi

if [[ $msg == 1 ]]; then
  echo $error
  check=1
fi

if [[ $check != 1 ]]; then
  usage
fi
