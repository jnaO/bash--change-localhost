#!/bin/bash
# Author:
#      jnaO

USERARG=$1
BASE=`pwd`
WEBROOT=''

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

if [[ "$USERARG" == /* ]]
then
  WEBROOT=$USERARG
elif [[ "$USERARG" == ../* ]]
then
  traverse $BASE $USERARG
else
  WEBROOT=`pwd`'/'$USERARG
fi

# Check if argument passed is a folder, and if not, exit script
if [ -d "${WEBROOT}" ]
then
  echo ""
  echo "Changing your web root to:"
  echo ""
  echo " ~---=== $WEBROOT ===---~ "
  echo ""
  echo ""
else
  echo ""
  echo "$WEBROOT is not a folder."
  echo "You need to pass in the path to a folder that you wan't to use as your webroot."
  echo "-------------------------------------------------------------------------------"
  echo ""
  exit
fi

rm ~/Sites/localhost
ln -s $WEBROOT ~/Sites/localhost