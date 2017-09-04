#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_partion_index.cpp -o e_partion_index

nodeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Nodes.txt")

edgeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Edges.txt")

geoFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_EdgeGeometry.txt")

entryTable=("/home/yangkai/plt/index/beijing_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_15.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_31.txt")

connectedFiles=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" "beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" "beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" "singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" "singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" "singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" "beijing_threshold" "singapore_threshold")

entryNum=("3" "4" "5")
thresholdValue=("1" "3" "5" "7" "9" "0.1")
partitionDeep=("2" "4" "6" "8" "10")
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
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			else
				for i in {5..9}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
				for i in {20..24}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			else
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFiles[30]}"
				connFile+=".txt"
				partitionFile="/home/yangkai/plt/index/partion_index/"
				partitionFile+="${connectedFiles[30]}"
				partitionFile+=".txt"
				echo $partitionFile
				./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
			elif [[ $select == *singapore* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFiles[31]}"
				connFile+=".txt"
				partitionFile="/home/yangkai/plt/index/partion_index/"
				partitionFile+="${connectedFiles[31]}"
				partitionFile+=".txt"
				echo $partitionFile
				./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
			else
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFiles[30]}"
				connFile+=".txt"
				partitionFile="/home/yangkai/plt/index/partion_index/"
				partitionFile+="${connectedFiles[30]}"
				partitionFile+=".txt"
				echo $partitionFile
				./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1

				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFiles[31]}"
				connFile+=".txt"
				partitionFile="/home/yangkai/plt/index/partion_index/"
				partitionFile+="${connectedFiles[31]}"
				partitionFile+=".txt"
				echo $partitionFile
				./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			else
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile -1
				done
				for i in {25..29}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[$i]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[$i]}"
					partitionFile+=".txt"
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile -1
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..2}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[31]}"
					connFile+=".txt"
					connFile=${connFile/"threshold"/"entry_${entryNum[$i]}"}
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[31]}"
					partitionFile+=".txt"
					partitionFile=${partitionFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $partitionFile
					./get_partion_index ${nodeFile[1+$i]} ${edgeFile[1+$i]} ${geoFile[1+$i]} $connFile $partitionFile -1
				done
			fi
			;;
		"deep")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[30]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[30]}"
					partitionFile+=".txt"
					partitionFile=${partitionFile/"threshold"/"deep_${partitionDeep[$i]}"}
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile ${partitionDeep[$i]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[31]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[31]}"
					partitionFile+=".txt"
					partitionFile=${partitionFile/"threshold"/"deep_${partitionDeep[$i]}"}
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile ${partitionDeep[$i]}
				done
			else
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[30]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[30]}"
					partitionFile+=".txt"
					partitionFile=${partitionFile/"threshold"/"deep_${partitionDeep[$i]}"}
					echo $partitionFile
					./get_partion_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $connFile $partitionFile ${partitionDeep[$i]}
				done
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFiles[31]}"
					connFile+=".txt"
					partitionFile="/home/yangkai/plt/index/partion_index/"
					partitionFile+="${connectedFiles[31]}"
					partitionFile+=".txt"
					partitionFile=${partitionFile/"threshold"/"deep_${partitionDeep[$i]}"}
					echo $partitionFile
					./get_partion_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $connFile $partitionFile ${partitionDeep[$i]}
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_partion_index
