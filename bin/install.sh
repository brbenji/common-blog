#!/bin/bash
# ==============================================================================
#
# install - Install desk files in a ship's pier.
#
# ==============================================================================

# Stop on error
set -e

# --------------------------------------
# Functions
# --------------------------------------

# 
# Print script usage
# 
usage() {
  if [[ $1 -ne 0 ]]; then
    exec 1>&2
  fi

  echo -e ""
  echo -e "Usage:\t$SCRIPT_NAME [-h] [-p PATH_TO_PIER] [-s SHIP_NAME]"
  echo -e ""
  echo -e "Install app files to a desk in an Urbit pier"
  echo -e ""
  echo -e "Options:"
  echo -e "  -h\tPrint script usage info"
  echo -e "  -p\tPath to directory containing the pier"
  echo -e "  -s\tName of pier to install to"
  echo -e ""
  exit $1
}

# --------------------------------------
# Variables
# --------------------------------------

SCRIPT_NAME=$(basename $0 | cut -d '.' -f 1)
SCRIPT_DIR=$(dirname $0)
ROOT_DIR=$(dirname $SCRIPT_DIR)
DESK_DIR="$ROOT_DIR/build/desk"

# --------------------------------------
# MAIN
# --------------------------------------

# Parse arguments
OPTS=":hp:s:"
while getopts ${OPTS} opt; do
  case ${opt} in
    h)
      usage 0
      ;;
    p)
      PIER_PATH=$OPTARG
      ;;
    s)
      PIER=$OPTARG
      ;;
    :)
      echo "$SCRIPT_NAME: Missing argument for '-${OPTARG}'" >&2
      usage 2
      ;;
    ?)
      echo "$SCRIPT_NAME: Invalid option '-${OPTARG}'" >&2
      usage 2
      ;;
  esac
done

# Copy files
INSTALL_DIR="$PIER_PATH/$PIER/blog"

echo "Attempting to install in $INSTALL_DIR"
cp -r ${DESK_DIR}/* ${INSTALL_DIR}/
echo "Successfully installed in $INSTALL_DIR"
