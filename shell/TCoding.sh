#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_t_coding.cpp -o e_t_coding

nodeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_10/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_13/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_16/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_19/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_22/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_25/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_28/WA_Nodes.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Nodes.txt")

edgeFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_10/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_13/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_16/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_19/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_22/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_25/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_28/WA_Edges.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_Edges.txt")

geoFile=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_10/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_13/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_16/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_19/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_22/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_25/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_28/WA_EdgeGeometry.txt"
"/home/yangkai/plt/dataset/singapore/roadnetwork_31/WA_EdgeGeometry.txt")

entryTable=("/home/yangkai/plt/index/beijing_edge2entry_table.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_10.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_13.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_16.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_19.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_22.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_25.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_28.txt"
"/home/yangkai/plt/index/singapore_edge2entry_table_31.txt")

connectedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" 
"beijing_1300_100" "beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" 
"beijing_insert_1" "beijing_insert_2" "beijing_insert_3" "beijing_insert_4" "beijing_insert_5" 
"singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" 
"singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" 
"singapore_insert_1" "singapore_insert_2" "singapore_insert_3" "singapore_insert_4" "singapore_insert_5" 
"beijing_threshold" "singapore_threshold")

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
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {20..24}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			else
				for i in {5..9}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
				for i in {20..24}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			else
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFile[30]}"
				connFile+=".txt"
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${connectedFile[30]}"
				tcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/tcoding/"
				timeFile+="${connectedFile[30]}"
				timeFile+=".txt"
				echo $tcodingFile
				./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
			elif [[ $select == *singapore* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFile[31]}"
				connFile+=".txt"
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${connectedFile[31]}"
				tcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/tcoding/"
				timeFile+="${connectedFile[31]}"
				timeFile+=".txt"
				echo $tcodingFile
				./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
			else
				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFile[30]}"
				connFile+=".txt"
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${connectedFile[30]}"
				tcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/tcoding/"
				timeFile+="${connectedFile[30]}"
				timeFile+=".txt"
				echo $tcodingFile
				./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile

				connFile="/home/yangkai/plt/connected/"
				connFile+="${connectedFile[31]}"
				connFile+=".txt"
				tcodingFile="/home/yangkai/plt/result/t_coding/"
				tcodingFile+="${connectedFile[31]}"
				tcodingFile+=".txt"
				timeFile="/home/yangkai/plt/recording/tcoding/"
				timeFile+="${connectedFile[31]}"
				timeFile+=".txt"
				echo $tcodingFile
				./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {25..29}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			else
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${entryTable[0]} $connFile $tcodingFile $timeFile
				done
				for i in {25..29}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[$i]}"
					connFile+=".txt"
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[$i]}"
					tcodingFile+=".txt"
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[$i]}"
					timeFile+=".txt"
					echo $tcodingFile
					./e_t_coding ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${entryTable[1]} $connFile $tcodingFile $timeFile
				done
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${connectedFile[31]}"
					connFile+=".txt"
					connFile=${connFile/"threshold"/"entry_${entryNum[$i]}"}
					tcodingFile="/home/yangkai/plt/result/t_coding/"
					tcodingFile+="${connectedFile[31]}"
					tcodingFile+=".txt"
					tcodingFile=${tcodingFile/"threshold"/"entry_${entryNum[$i]}"}
					timeFile="/home/yangkai/plt/recording/tcoding/"
					timeFile+="${connectedFile[31]}"
					timeFile+=".txt"
					timeFile=${timeFile/"threshold"/"entry_${entryNum[$i]}"}
					echo $tcodingFile
					./e_t_coding ${nodeFile[1+$i]} ${edgeFile[1+$i]} ${geoFile[1+$i]} ${entryTable[1+$i]} $connFile $tcodingFile $timeFile
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_t_coding
