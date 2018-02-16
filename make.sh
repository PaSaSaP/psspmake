#!/bin/sh

function usage(){
	echo "Usage: ${0} [-h] path/to/file.cpp [args...]" 1>&2
	exit 1
}

# Get Makefile for specific file based on file extension.
function proper_makefile(){
	if [[ ${1} =~ ^.*\.cpp$ ]] || [[ ${1} =~ ^.*\.cxx$ ]] || [[ ${1} =~ ^.*\.cc$ ]]
	then
		echo "Makefile.cpp"
	elif [[ ${1} =~ ^.*\.c$ ]]
	then
		echo "Makefile.c"
	else
		echo "Inknown file extension!" 1>&2
	fi
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
	make --no-print-directory -f "$(proper_makefile ${p})" -C "${SCRIPTPATH}" FILE="${p}" ${args}
fi

