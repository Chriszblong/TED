#!/bin/bash
cd /home/yangkai/plt/code

g++ -O3 e_query_set.cpp -o e_query_set

roadfiles=("/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt")


setnames=("knn" "when" "count" "where" "window" "howlong" "distance" "distance_single")
numb=${#setnames[@]}


for (( k=0; k<$numb ; k++ ))
do
	knum=$k
	let "knum+=1"
	writefile="/home/yangkai/plt/query/queryset/"
	writefile+="singapore_"
	writefile+="${setnames[$k]}"
	writefile+=".txt"
	./e_query_set ${roadfiles[0]} ${roadfiles[1]} ${roadfiles[2]} $writefile $knum 10000
	echo $writefile
done


roadfiles=("/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt" "/home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt" "/home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt")


setnames=("knn" "when" "count" "where" "window" "howlong" "distance" "distance_single")
numb=${#setnames[@]}


for (( k=0; k<$numb ; k++ ))
do
	knum=$k
	let "knum+=1"
	writefile="/home/yangkai/plt/query/queryset/"
	writefile+="beijing_"
	writefile+="${setnames[$k]}"
	writefile+=".txt"
	./e_query_set ${roadfiles[0]} ${roadfiles[1]} ${roadfiles[2]} $writefile $knum 10000
	echo $writefile
done

rm e_query_set
