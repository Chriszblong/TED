#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_interval.cpp -o e_interval

nodeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Nodes.txt")

edgeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Edges.txt")

geoFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_EdgeGeometry.txt")

entryTable=("/home/yangkai/plt/index/beijing_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_15.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_31.txt")

formatedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" "beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" "beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" "singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" "singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" "singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" "beijing_threshold" "singapore_threshold")

entryNum=("3" "4" "5")
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
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			else
				for i in {5..9}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
				for i in {20..24}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			else
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
				for i in {15..19}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[30]}"
				formatFile+=".txt"
				intervalFile="/home/yangkai/plt/interval/"
				intervalFile+="${formatedFile[30]}"
				intervalFile+=".txt"
				echo $intervalFile
				./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
			elif [[ $select == *singapore* ]]
			then
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[31]}"
				formatFile+=".txt"
				intervalFile="/home/yangkai/plt/interval/"
				intervalFile+="${formatedFile[31]}"
				intervalFile+=".txt"
				echo $intervalFile
				./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
			else
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[30]}"
				formatFile+=".txt"
				intervalFile="/home/yangkai/plt/interval/"
				intervalFile+="${formatedFile[30]}"
				intervalFile+=".txt"
				echo $intervalFile
				./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile

				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[31]}"
				formatFile+=".txt"
				intervalFile="/home/yangkai/plt/interval/"
				intervalFile+="${formatedFile[31]}"
				intervalFile+=".txt"
				echo $intervalFile
				./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			else
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $formatFile $intervalFile
				done
				for i in {25..29}
				do
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					echo $intervalFile
					./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[31]}"
				formatFile+=".txt"
				intervalFile="/home/yangkai/plt/interval/"
				intervalFile+="${formatedFile[31]}"
				intervalFile+=".txt"
				echo $intervalFile
				./e_interval ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $formatFile $intervalFile
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_interval
