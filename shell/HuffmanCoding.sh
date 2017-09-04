#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_huffman_coding.cpp -o e_huffman_coding

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
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			else
				for i in {5..9}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
				for i in {20..24}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			else
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
				for i in {15..19}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[30]}"
					huffmanindexFile+=".txt"
					huffmanindexFile=${huffmanindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[30]}"
					huffmancodingFile+=".txt"
					huffmancodingFile=${huffmancodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[31]}"
					huffmanindexFile+=".txt"
					huffmanindexFile=${huffmanindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[31]}"
					huffmancodingFile+=".txt"
					huffmancodingFile=${huffmancodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			else
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[30]}"
					huffmanindexFile+=".txt"
					huffmanindexFile=${huffmanindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[30]}"
					huffmancodingFile+=".txt"
					huffmancodingFile=${huffmancodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
				for i in {0..4}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[31]}"
					huffmanindexFile+=".txt"
					huffmanindexFile=${huffmanindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[31]}"
					huffmancodingFile+=".txt"
					huffmancodingFile=${huffmancodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			else
				for i in {10..14}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
				for i in {25..29}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[$i]}"
					huffmanindexFile+=".txt"
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[$i]}"
					huffmancodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					lcodingFile="/home/yangkai/plt/result/l_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					huffmanindexFile="/home/yangkai/plt/index/huffman_index/"
					huffmanindexFile+="${formatedFile[31]}"
					huffmanindexFile+=".txt"
					huffmanindexFile=${huffmanindexFile/"threshold"/"entry_${entryNum[$i]}"}
					huffmancodingFile="/home/yangkai/plt/result/huffman_coding/"
					huffmancodingFile+="${formatedFile[31]}"
					huffmancodingFile+=".txt"
					huffmancodingFile=${huffmancodingFile/"threshold"/"entry_${entryNum[$i]}"}
					timeFile="/home/yangkai/plt/recording/huffmancoding/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $huffmancodingFile
					./e_huffman_coding $huffmanindexFile $lcodingFile $huffmancodingFile $timeFile
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_huffman_coding
