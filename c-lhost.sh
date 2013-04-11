#!/bin/bash
# Author:
#      jnaO

USERARG=$1
BASE=`pwd`
WEBROOT=''
LOCALHOST=~/Sites/localhost
LOCALHOST_LOGS=~/Sites/localhost_logs

# Start processing options at index 1.
OPTIND=1
# OPTERR=1
while getopts ":l" opt ; do
  case $opt in
    l)
      CLH=`ls -laGf ~/Sites/localhost`
      echo ""
      echo ""
      echo $(tput bold)$(tput setaf 32)"~---=== Current web root: "${CLH#*'-> '}" ===---~"
      echo ""
      echo ""
      exit 1
    ;;
    # The getopt routine returns a colon when it encounters
    # a flag that should have an argument but doesn't.  It
    # returns the errant flag in the OPTARG variable.
    :)
      echo ""
      echo ""
      echo $(tput bold)$(tput setaf 1)"Flag -$OPTARG requires an argument."
      echo $(tput bold)$(tput setaf 6)"Usage: $0 [-l] [-o outputfile] [path ...]"
      echo ""
      echo ""
      exit 1
    ;;
    # The getopt routine returns a question mark when it
    # encounters an unknown flag.  It returns the unknown
    # flag in the OPTARG variable.
    \?)
      echo ""
      echo ""
      echo $(tput bold)$(tput setaf 1)"Unknown flag -$OPTARG detected."
      echo $(tput bold)$(tput setaf 6)"Usage: $0 [-l] [-o outputfile] [path ...]"
      echo ""
      echo ""
      exit 1
    ;;
  esac
done


traverse() {
  # Recursive function, make initial check to see if we
  # need to substring the paths
  if [[ "${USERARG}" == ../* ]]
  then
    # Split the current working directory (or what's
    # left of it), into an array
    IFS='/' read -ra SOFTPATH <<< "${BASE}"
    # For readability, store the string to be trimmed in a variable
    REMOVE_FROM_BASE='/'${SOFTPATH[${#SOFTPATH[@]}-1]}

    # Remove the first (#) '../' from the soft path passed in
    USERARG=${USERARG#'../'}
    # Remove the last (%) folder from the current working directory
    BASE=${BASE%${REMOVE_FROM_BASE}}
    # se if user want to go higher in the file tree
    traverse $BASE $USERARG
  else
    WEBROOT=$BASE'/'$USERARG
  fi
}

# Absolute path
if [[ "$USERARG" == /* ]]
then
  WEBROOT=$USERARG

# Soft path
elif [[ "$USERARG" == ../* ]]
then
  traverse $BASE $USERARG

# Relative path
else
  WEBROOT=`pwd`'/'$USERARG
fi



# Check if argument passed is a folder, and if not, exit script
if [ -d "${WEBROOT}" ]
then
  # Remove old symlink if exists
  if [ -e $LOCALHOST ];
  then
    rm $LOCALHOST
  fi
  # Create folder for log storing, if not exist
  if [ ! -d $LOCALHOST_LOGS ];
  then
    mkdir $LOCALHOST_LOGS
  fi
  ln -s $WEBROOT ~/Sites/localhost

  echo $(tput bold)$(tput setaf 32)"

~---=== New webroot: $WEBROOT ===---~

"
else
  echo $(tput bold)$(tput setaf 1)"

$WEBROOT is not a folder.
You need to pass in the path to a folder that you wan't to use as your webroot.
-------------------------------------------------------------------------------

"
  exit
fi

