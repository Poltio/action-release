#!/bin/bash

ALIAS="v"

checkNumber () {
	NUMBER=$1
	re='^[0-9]+$'
	if ! [[ $NUMBER =~ $re ]] ; then
		NUMBER=0;
	fi
	echo "$NUMBER";
}

# Get the latest tag 
VERSION=`git describe --abbrev=0 --tags` 
# remove the v in the beginning. 
VERSION="${VERSION/v/}"

IFS='.' read -a vers <<< "$VERSION"

MAJOR=$(checkNumber ${vers[0]})
MINOR=$(checkNumber ${vers[1]})
PATCH=$(checkNumber ${vers[2]})

while getopts mipa: flag
do
	case "${flag}" in
		m) ((MAJOR+=1));MINOR=0;PATCH=0;;
		i) ((MINOR+=1));PATCH=0;;
		p) ((PATCH+=1));;
		a) ALIAS=${OPTARG};;
		*) ((PATCH+=1));;
	esac
done

NEWVERSION="${ALIAS}${MAJOR}.${MINOR}.${PATCH}";

echo $NEWVERSION
