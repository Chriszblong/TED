#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_distance_query_without_index.cpp -o e_distance_query_without_index

nodeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Nodes.txt")

edgeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Edges.txt")

geoFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_15/WA_EdgeGeometry.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_EdgeGeometry.txt")

entryTable=("/home/yangkai/plt/index/beijing_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_15.txt" "/home/yangkai/plt/index/singapore_edge2entry_table_31.txt")

connectedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" "beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" "beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" "singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" "singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" "singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" "beijing_threshold" "singapore_threshold")

entryNum=("3" "4" "5")
thresholdValue=("1" "3" "5" "7" "9")
deepValue=("2" "4" "6" "8" "10")
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
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile

					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile

					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			else
				for i in {5..9}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
				for i in {20..24}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			else
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
				for i in {15..19}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[30]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[30]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[30]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[30]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}

				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[31]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[31]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[31]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			else
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[30]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[30]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[30]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[30]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile

					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}

				done
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[31]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[31]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[31]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			else
				for i in {10..14}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
				for i in {25..29}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[$i]}"
					pddpindexFile+=".txt"
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[$i]}"
					partitionindexFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[$i]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[$i]}"
					e_distance_query_without_indexFile+=".txt"
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[0]}
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..2}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[31]}"
					pcodingFile+=".txt"
					pcodingFile=${pcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					tcodingFile=${tcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"entry_${entryNum[$i]}"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[31]}"
					partitionindexFile+=".txt"
					partitionindexFile=${partitionindexFile/"threshold"/"entry_${entryNum[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[31]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[31]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"entry_${entryNum[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile

					./e_distance_query_without_index ${nodeFile[1+$i]} ${edgeFile[1+$i]} ${geoFile[1+$i]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile -1 $queryset ${entryNum[$i]}
				done
			fi
			;;
		"deep")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"100"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[30]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"100"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[30]}"
					partitionindexFile+=".txt"
					partitionindexFile=${partitionindexFile/"threshold"/"deep_${deepValue[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[30]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[30]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"deep_${deepValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile ${deepValue[$i]} $queryset ${entryNum[0]}

				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"100"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"100"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[31]}"
					partitionindexFile+=".txt"
					partitionindexFile=${partitionindexFile/"threshold"/"deep_${deepValue[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[31]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[31]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"deep_${deepValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile ${deepValue[$i]} $queryset ${entryNum[0]}
				done
			else
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"100"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[30]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"100"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[30]}"
					partitionindexFile+=".txt"
					partitionindexFile=${partitionindexFile/"threshold"/"deep_${deepValue[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[30]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[30]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"deep_${deepValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/beijing_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile ${deepValue[$i]} $queryset ${entryNum[0]}

				done
				for i in {0..4}
				do
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${connectedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${connectedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"100"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${connectedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"100"}
					partitionindexFile="/home/yangkai/plt/index/partion_index/"
					partitionindexFile+="${connectedFile[31]}"
					partitionindexFile+=".txt"
					partitionindexFile=${partitionindexFile/"threshold"/"deep_${deepValue[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${connectedFile[31]}"
					intervalFile+=".txt"
					e_distance_query_without_indexFile="/home/yangkai/plt/query/distance_without_index/"
					e_distance_query_without_indexFile+="${connectedFile[31]}"
					e_distance_query_without_indexFile+=".txt"
					e_distance_query_without_indexFile=${e_distance_query_without_indexFile/"threshold"/"deep_${deepValue[$i]}"}
					queryset="/home/yangkai/plt/query/queryset/singapore_distance.txt"

					echo $e_distance_query_without_indexFile
					./e_distance_query_without_index ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $partitionindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $e_distance_query_without_indexFile ${deepValue[$i]} $queryset ${entryNum[0]}
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_distance_query_without_index
