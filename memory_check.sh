#!/bin/sh

calc(){ 
	awk "BEGIN{ print $* }" ;
	}

total_mem=$(free -m | grep Mem: | awk '{ print $2}') #Total Memory

used_mem=$(free -m | grep Mem: | awk '{ print $3}')
perc_used=$(echo "scale=2 ; $used_mem / $total_mem" | bc)
perc_used=$(echo "scale=2 ; $perc_used * 100" | bc)


usage() {
	echo "Usage: $0 [-c int] [-w int] [-e email]" 1>&2; exit 1;
}

datet() {
	date "+%Y%m%d %H-%S"
}

while :; do
while getopts ":c:w:e:" o; do
    case "${o}" in
        c)
            c=${OPTARG}
            ;;
        w)
            w=${OPTARG}
            ;;
		e)	
			e=${OPTARG}	
			;;
        *)
            usage
			exit 1
            ;;
    esac
done
((OPTIND++))
[ $OPTIND -gt 3 ] && break

done

percRound=${perc_used%%.*} 
if($OPTIND -lt 3]
then
	usage
	exit 1
elif [ "$c" -lt "$w" ]
then
	echo "Invalid Inputs - c must be greater than w"
	exit 1
elif [  "$percRound" -ge "$c" ]
then
	#echo "Critical Error - Sending Mail"
	MESSAGE="$MESSAGE $(ps aux --sort -rss | head -n 11 | awk '{ print $2}') \n"

	date="$(datet) memory check - critical"
	#echo $date

	echo -e $MESSAGE | mail -s "$date" -r $e

	exit 2
elif [ "$percRound" -ge "$w" ]
then
	#echo "Warning"
	exit 1
else
	#echo "Good"
	exit 0
fi
