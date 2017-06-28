#!/bin/sh

echo Hello World

usage() {
	echo "Usage: $0 [-c int] [-w int]" 1>&2; exit 1;
}

while getopts ":c:w:e:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
            ((s == 45 || s == 90)) || usage
			echo c
            ;;
        w)
            w=${OPTARG}
			echo $w
            ;;
		e)	e=${OPTARG}
			mail -s "Test" seth_12619@yahoo.com.ph
			;;
        *)
            usage
            ;;
    esac
done