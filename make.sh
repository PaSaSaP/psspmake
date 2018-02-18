#!/bin/sh

function usage(){
	echo "Usage: ${0} [-h] path/to/file.cpp [args...]" 1>&2
	exit 1
}

while getopts ":h" o; do
	case "${o}" in
		h)
			usage
			;;
		*)
			usage
			;;
	esac
done
shift $((OPTIND-1))

# Must be at least one argument.
if [ -z "${1}" ]
then
	usage
fi

# Get absolute path to file.
p="`realpath ${1}`"
shift 1
# Check that specified file exists.
if [ ! -f "${p}" ]
then
	echo "File '${p}' does not exist!" 1>&2
	exit 1
fi

args="${@}"
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

# If we are in the directory where is Makefile (eg. some project) then use that Makefile,
# in any other case use Makefile based on file extension.
if [ -f "Makefile" ] && [ "`realpath .`" != "${SCRIPTPATH}" ]
then
	make ${args}
else
	make --no-print-directory -C "${SCRIPTPATH}" SRCS="${p}" ${args}
fi

