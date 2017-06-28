#!/bin/sh

echo "Hello World";

total_mem=$(free -m | grep Mem: | awk '{ print $2}') #Total Memory
echo $total_mem
used_mem=$(free -m | grep Mem: | awk '{ print $3}')
perc_used="scale=2 ; $used_mem/$total_mem" | bc
echo $perc_used

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