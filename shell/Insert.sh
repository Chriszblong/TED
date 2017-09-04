#!/bin/bash
cd /home/yangkai/plt/code
g++ -O3 e_create_new_trajectory_with_inserting_points.cpp -o e_create_new_trajectory_with_inserting_points

initfile=("/home/yangkai/plt/connected/singapore_20.txt" "/home/yangkai/plt/connected/beijing_20.txt")

insertpointnum=(1 2 3 4 5)

for i in {0..4}
do
	for j in {0..1}
	do
		writefile=${initfile[$j]}
		tmpInsert="insert_"
		tmpInsert+="${insertpointnum[$i]}"
		writefile=${writefile/"20"/"$tmpInsert"}
		tmpstring="beijing"

		formatfile=$writefile
		formatfile=${formatfile/"connected"/"format"}

		if [[ $writefile == *$tmpstring* ]]
		then
			echo $writefile
			./e_create_new_trajectory_with_inserting_points ${insertpointnum[$i]} /home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt /home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt /home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt ${initfile[$j]} $writefile $formatfile
		else
			echo $writefile
			./e_create_new_trajectory_with_inserting_points ${insertpointnum[$i]} /home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt /home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt /home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt ${initfile[$j]} $writefile $formatfile
		fi
	done
done

rm e_create_new_trajectory_with_inserting_points
