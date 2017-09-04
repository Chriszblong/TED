#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_connected_trajectories.cpp -o e_connected_trajectories

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

nextTable=("/home/yangkai/plt/index/beijing_next" 
"/home/yangkai/plt/index/singapore_next" 
"/home/yangkai/plt/index/singapore_next_10" 
"/home/yangkai/plt/index/singapore_next_13"
"/home/yangkai/plt/index/singapore_next_16"
"/home/yangkai/plt/index/singapore_next_19"
"/home/yangkai/plt/index/singapore_next_22"
"/home/yangkai/plt/index/singapore_next_25"
"/home/yangkai/plt/index/singapore_next_28"
"/home/yangkai/plt/index/singapore_next_31")

formatedFile=("beijing_20" "beijing_40" "beijing_60" "beijing_80" "beijing_100" "beijing_1300_100" 
"beijing_1300_400" "beijing_1300_700" "beijing_1300_1000" "beijing_1300_1300" 
"singapore_20" "singapore_40" "singapore_60" "singapore_80" "singapore_100" 
"singapore_900_100" "singapore_900_300" "singapore_900_500" "singapore_900_700" "singapore_900_900" 
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
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
				done
			else
				for i in {5..9}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile
				done
				for i in {15..19}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
				done
			else
				for i in {0..4}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile
				done
				for i in {10..14}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[$i]}"
					connFile+=".txt"
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${formatedFile[20]}"
				connFile+=".txt"
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[20]}"
				formatFile+=".txt"
				echo $connFile
				./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile
			elif [[ $select == *singapore* ]]
			then
				connFile="/home/yangkai/plt/connected/"
				connFile+="${formatedFile[21]}"
				connFile+=".txt"
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[21]}"
				formatFile+=".txt"
				echo $connFile
				./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
			else
				connFile="/home/yangkai/plt/connected/"
				connFile+="${formatedFile[20]}"
				connFile+=".txt"
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[20]}"
				formatFile+=".txt"
				echo $connFile
				./e_connected_trajectories ${nodeFile[0]} ${edgeFile[0]} ${geoFile[0]} ${nextTable[0]} $formatFile $connFile

				connFile="/home/yangkai/plt/connected/"
				connFile+="${formatedFile[21]}"
				connFile+=".txt"
				formatFile="/home/yangkai/plt/format/"
				formatFile+="${formatedFile[21]}"
				formatFile+=".txt"
				echo $connFile
				./e_connected_trajectories ${nodeFile[1]} ${edgeFile[1]} ${geoFile[1]} ${nextTable[1]} $formatFile $connFile
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				for i in {0..8}
				do
					connFile="/home/yangkai/plt/connected/"
					connFile+="${formatedFile[21]}"
					connFile+=".txt"
					connFile=${connFile/"threshold"/"entry_${entryNum[$i]}"}
					formatFile="/home/yangkai/plt/format/"
					formatFile+="${formatedFile[21]}"
					formatFile+=".txt"
					echo $connFile
					./e_connected_trajectories ${nodeFile[1+$i]} ${edgeFile[1+$i]} ${geoFile[1+$i]} ${nextTable[1+$i]} $formatFile $connFile

				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_connected_trajectories
