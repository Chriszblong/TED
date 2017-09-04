#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_huffman_index.cpp -o e_huffman_index

formatedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" 
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
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			else
				for i in {5..9}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
				for i in {20..24}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			else
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
				for i in {15..19}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[30]}"
					huffmancountFile+=".txt"
					huffmancountFile=${huffmancountFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[31]}"
					huffmancountFile+=".txt"
					huffmancountFile=${huffmancountFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			else
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[30]}"
					huffmancountFile+=".txt"
					huffmancountFile=${huffmancountFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
				for i in {0..4}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[31]}"
					huffmancountFile+=".txt"
					huffmancountFile=${huffmancountFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			else
				for i in {10..14}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
				for i in {25..29}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[$i]}"
					huffmancountFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					huffmancountFile="/home/yangkai/plt/result/huffman_count/"
					huffmancountFile+="${formatedFile[31]}"
					huffmancountFile+=".txt"
					huffmancountFile=${huffmancountFile/"threshold"/"entry_${entryNum[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/huffman_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $pddpindexFile
					./e_huffman_index $huffmancountFile $pddpindexFile
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_huffman_index
