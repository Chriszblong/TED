#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_matrix_coding.cpp -o e_matrix_coding

formatedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" 
"beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" 
"beijing_1300_1300" "beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" 
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
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			else
				for i in {5..9}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
				for i in {20..24}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			else
				for i in {0..4}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
				for i in {15..19}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${formatedFile[30]}"
				tcodingFile+=".txt"

				multitcodingFile="/home/yangkai/plt/result/multit_coding/"
				multitcodingFile+="${formatedFile[30]}"
				multitcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/multitcoding/"
				timeFile+="${formatedFile[30]}"
				timeFile+=".txt"
				echo $multitcodingFile
				./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
			elif [[ $select == *singapore* ]]
			then
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${formatedFile[31]}"
				tcodingFile+=".txt"

				multitcodingFile="/home/yangkai/plt/result/multit_coding/"
				multitcodingFile+="${formatedFile[31]}"
				multitcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/multitcoding/"
				timeFile+="${formatedFile[31]}"
				timeFile+=".txt"
				echo $multitcodingFile
				./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
			else
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${formatedFile[30]}"
				tcodingFile+=".txt"

				multitcodingFile="/home/yangkai/plt/result/multit_coding/"
				multitcodingFile+="${formatedFile[30]}"
				multitcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/multitcoding/"
				timeFile+="${formatedFile[30]}"
				timeFile+=".txt"
				echo $multitcodingFile
				./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5

				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${formatedFile[31]}"
				tcodingFile+=".txt"

				multitcodingFile="/home/yangkai/plt/result/multit_coding/"
				multitcodingFile+="${formatedFile[31]}"
				multitcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/multitcoding/"
				timeFile+="${formatedFile[31]}"
				timeFile+=".txt"
				echo $multitcodingFile
				./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			else
				for i in {10..14}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
				for i in {25..29}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[$i]}"
					multitcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[31]}"
					tcodingFile+=".txt"
					tcodingFile=${tcodingFile/"threshold"/"entry_${entryNum[$i]}"}

					multitcodingFile="/home/yangkai/plt/result/multit_coding/"
					multitcodingFile+="${formatedFile[31]}"
					multitcodingFile+=".txt"
					multitcodingFile=${multitcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					timeFile="/home/yangkai/plt/recording/multitcoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $multitcodingFile
					./e_matrix_coding $tcodingFile $multitcodingFile $timeFile 1 5
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_matrix_coding
