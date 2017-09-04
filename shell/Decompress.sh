#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_decompress.cpp -o e_decompress

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
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			else
				for i in {5..9}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
				for i in {20..24}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			else
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
				for i in {15..19}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[30]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[30]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[30]}"
					resultFile+=".txt"
					resultFile=${resultFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[31]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[31]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[31]}"
					resultFile+=".txt"
					resultFile=${resultFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			else
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[30]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[30]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[30]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[30]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[30]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[30]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[30]}"
					resultFile+=".txt"
					resultFile=${resultFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
				for i in {0..4}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[31]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[31]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[31]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[31]}"
					resultFile+=".txt"
					resultFile=${resultFile/"threshold"/"threshold_${thresholdValue[$i]}"}
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			else
				for i in {10..14}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
				for i in {25..29}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[$i]}"
					pddpindexFile+=".txt"
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[$i]}"
					pcodingFile+=".txt"
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[$i]}"
					lcodingFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[$i]}"
					tcodingFile+=".txt"
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[$i]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[$i]}"
					timeFile+=".txt"
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[$i]}"
					resultFile+=".txt"
					echo $resultFile
					./e_decompress ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[0]}
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..2}
				do
					pddpindexFile="/home/yangkai/plt/index/pddp_index/"
					pddpindexFile+="${formatedFile[31]}"
					pddpindexFile+=".txt"
					pddpindexFile=${pddpindexFile/"threshold"/"entry_${entryNum[$i]}"}
					pcodingFile="/home/yangkai/plt/result/p_coding/"
					pcodingFile+="${formatedFile[31]}"
					pcodingFile+=".txt"
					pcodingFile=${pcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					lcodingFile="/home/yangkai/plt/result/pddp_coding/"
					lcodingFile+="${formatedFile[31]}"
					lcodingFile+=".txt"
					lcodingFile=${lcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${formatedFile[31]}"
					tcodingFile+=".txt"
					tcodingFile=${tcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					intervalFile="/home/yangkai/plt/interval/"
					intervalFile+="${formatedFile[31]}"
					intervalFile+=".txt"
					timeFile="/home/yangkai/plt/recording/decompress/"
					timeFile+="${formatedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"entry_${entryNum[$i]}"}
					resultFile="/home/yangkai/plt/decompress/"
					resultFile+="${formatedFile[31]}"
					resultFile+=".txt"
					resultFile=${resultFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $resultFile
					./e_decompress ${nodeFile[1+$i]} ${edgeFile[1+$i]} ${geoFile[1+$i]} $pddpindexFile $pcodingFile $lcodingFile $tcodingFile $intervalFile $timeFile $resultFile ${entryNum[$i]}
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_decompress
