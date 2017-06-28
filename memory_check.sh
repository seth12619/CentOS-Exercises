#!/bin/sh

echo "Hello World";

mem=$(free -m | grep Mem: | awk'{ print $2}')
echo $mem

usage() {
	echo "Usage: $0 [-c int] [-w int] [-e email]" 1>&2; exit 1;
}

while getopts ":c:w:e:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
			echo $c
            ;;
        w)
            w=${OPTARG}
			echo $w
            ;;
		e)	e=${OPTARG}
			mail -s "Test" $e
			;;
        *)
            usage
            ;;
    esac
done