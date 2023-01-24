#!/bin/sh 

ALIAS="v"

checkNumber () {
	NUMBER=$1
	re='^[0-9]+$'
	if ! [[ $NUMBER =~ $re ]] ; then
		return 0; return $NUMBER;
	fi
}

# Get the latest tag 
VERSION=`git describe --abbrev=0 --tags` 
# remove the v in the beginning. 
VERSION="${VERSION/v/}"

IFS='.' read -a vers <<< "$VERSION"

checkNumber ${vers[0]}
MAJOR=$?
checkNumber ${vers[1]}
MINOR=$?
checkNumber ${vers[2]}
PATCH=$?

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
