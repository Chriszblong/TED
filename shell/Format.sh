#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_format_trajectories.cpp -o e_format_trajectories

formatedFile=("20" "40" "60" "80" "100" "1300_100" "1300_400" "1300_700" "1300_1000" "1300_1300" "900_100" "900_300" "900_500" "900_700" "900_900")

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
					formatFile="/home/yangkai/plt/format/beijing_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/beijing/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/singapore_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/singapore/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			else
				for i in {5..9}
				do
					formatFile="/home/yangkai/plt/format/beijing_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/beijing/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
				for i in {10..14}
				do
					formatFile="/home/yangkai/plt/format/singapore_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/singapore/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/beijing_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/beijing/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/singapore_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/singapore/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			else
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/beijing_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/beijing/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
				for i in {0..4}
				do
					formatFile="/home/yangkai/plt/format/singapore_"
					formatFile+="${formatedFile[$i]}"
					formatFile+=".txt"
					initFile="/home/yangkai/plt/dataset/singapore/"
					initFile+="${formatedFile[$i]}"
					mapmatchedFile="mapmatched_"
					mapmatchedFile+="${formatedFile[$i]}"
					echo $formatFile
					./e_format_trajectories $formatFile $initFile ${formatedFile[$i]} $mapmatchedFile
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				formatFile="/home/yangkai/plt/format/beijing_"
				formatFile+="${formatedFile[4]}"
				formatFile+=".txt"
				formatFile=${formatFile/"${formatedFile[4]}"/"threshold"}
				initFile="/home/yangkai/plt/dataset/beijing/"
				initFile+="${formatedFile[4]}"
				mapmatchedFile="mapmatched_"
				mapmatchedFile+="${formatedFile[4]}"
				echo $formatFile
				./e_format_trajectories $formatFile $initFile ${formatedFile[4]} $mapmatchedFile
			elif [[ $select == *singapore* ]]
			then
				formatFile="/home/yangkai/plt/format/singapore_"
				formatFile+="${formatedFile[4]}"
				formatFile+=".txt"
				formatFile=${formatFile/"${formatedFile[4]}"/"threshold"}
				initFile="/home/yangkai/plt/dataset/singapore/"
				initFile+="${formatedFile[4]}"
				mapmatchedFile="mapmatched_"
				mapmatchedFile+="${formatedFile[4]}"
				echo $formatFile
				./e_format_trajectories $formatFile $initFile ${formatedFile[4]} $mapmatchedFile
			else
				formatFile="/home/yangkai/plt/format/beijing_"
				formatFile+="${formatedFile[4]}"
				formatFile+=".txt"
				formatFile=${formatFile/"${formatedFile[4]}"/"threshold"}
				initFile="/home/yangkai/plt/dataset/beijing/"
				initFile+="${formatedFile[4]}"
				mapmatchedFile="mapmatched_"
				mapmatchedFile+="${formatedFile[4]}"
				echo $formatFile
				./e_format_trajectories $formatFile $initFile ${formatedFile[4]} $mapmatchedFile

				formatFile="/home/yangkai/plt/format/singapore_"
				formatFile+="${formatedFile[4]}"
				formatFile+=".txt"
				formatFile=${formatFile/"${formatedFile[4]}"/"threshold"}
				initFile="/home/yangkai/plt/dataset/singapore/"
				initFile+="${formatedFile[4]}"
				mapmatchedFile="mapmatched_"
				mapmatchedFile+="${formatedFile[4]}"
				echo $formatFile
				./e_format_trajectories $formatFile $initFile ${formatedFile[4]} $mapmatchedFile
			fi
			;;
		"entry")
			if [[ $select != *beijing* ]]
			then
				formatFile="/home/yangkai/plt/format/singapore_"
				formatFile+="${formatedFile[4]}"
				formatFile+=".txt"
				formatFile=${formatFile/"${formatedFile[4]}"/"threshold"}
				initFile="/home/yangkai/plt/dataset/singapore/"
				initFile+="${formatedFile[4]}"
				mapmatchedFile="mapmatched_"
				mapmatchedFile+="${formatedFile[4]}"
				echo $formatFile
				./e_format_trajectories $formatFile $initFile ${formatedFile[4]} $mapmatchedFile
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done

rm e_format_trajectories
