#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_prefix_coding.cpp -o e_prefix_coding

formatFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" 
"beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" 
"beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" 
"singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" 
"singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" 
"singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" 
"beijing_threshold" "singapore_threshold")

entryBitNum=("3" "4" "4" "5" "5" "5" "5" "5" "5")
entryNum=("7" "10" "13" "16" "19" "22" "25" "28" "31")
thresholdValue=("1" "3" "5" "7" "9")
select="all"

# four selections can be selected: length, number, threshold, insert, entry

for args in $@
do
	case "$args" in
		"length")
			if [[ $select == *beijing* ]]
			then
				for i in {5..9}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			else
				for i in {5..9}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
				for i in {20..24}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			else
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
				for i in {15..19}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[30]}"
					prefixcodingFile+=".txt"
					prefixcodingFile=${prefixcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[31]}"
					prefixcodingFile+=".txt"
					prefixcodingFile=${prefixcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			else
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[30]}"
					prefixcodingFile+=".txt"
					prefixcodingFile=${prefixcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[31]}"
					prefixcodingFile+=".txt"
					prefixcodingFile=${prefixcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			else
				for i in {10..14}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
				for i in {25..29}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[$i]}"
					lcodingFile+=".txt"
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[$i]}"
					prefixcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[$i]}"
					timeFile+=".txt"
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					prefixcodingFile="/home/yangkai/plt/result/addfixbits_coding/"
					prefixcodingFile+="${formatFile[31]}"
					prefixcodingFile+=".txt"
					prefixcodingFile=${prefixcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					timeFile="/home/yangkai/plt/recording/addfixbitscoding/"
					timeFile+="${formatFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $prefixcodingFile
					./e_prefix_coding $lcodingFile $prefixcodingFile $timeFile
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_prefix_coding
