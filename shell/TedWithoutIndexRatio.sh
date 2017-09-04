#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_ted_ratio.cpp -o e_ted_ratio

formatFiles=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" 
"beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" 
"beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" 
"singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" 
"singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" 
"singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" 
"beijing_threshold" "singapore_threshold")

thresholdValue=("1" "3" "5" "7" "9")
entryBitNum=("3" "4" "4" "5" "5" "5" "5" "5" "5")
entryNum=("7" "10" "13" "16" "19" "22" "25" "28" "31")
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
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			else
				for i in {5..9}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
				for i in {20..24}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			else
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
				for i in {15..19}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[30]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[30]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[30]}"
					ratioFile+=".txt"
					ratioFile=${ratioFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[31]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[31]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[31]}"
					ratioFile+=".txt"
					ratioFile=${ratioFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			else
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[30]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[30]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[30]}"
					ratioFile+=".txt"
					ratioFile=${ratioFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done

				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[31]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[31]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[31]}"
					ratioFile+=".txt"
					ratioFile=${ratioFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			elif [[ $select == *beijing* ]]
			then
				for i in {25..29}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			else
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
				for i in {25..29}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[$i]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[$i]}"
					tcodingFile+=".txt"
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[$i]}"
					ratioFile+=".txt"
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatFiles[31]}"
					formatFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatFiles[31]}"
					pcodingFile+=".txt"
					pcodingFile=${pcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatFiles[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatFiles[31]}"
					tcodingFile+=".txt"
					tcodingFile=${tcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					ratioFile="/home/yangkai/plt/ratio/ted_no_index/"
					ratioFile+="${formatFiles[31]}"
					ratioFile+=".txt"
					ratioFile=${ratioFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $ratioFile
					./e_ted_ratio $formatFile $pcodingFile $lcodingFile $tcodingFile $ratioFile 0

				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_ted_ratio
