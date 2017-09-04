#!/bin/bash
cd /home/yangkai/plt/code

g++ -O3 e_show.cpp -o e_show

files=`ls /home/yangkai/plt/recording`
arr=(${files//,/})
numb=${#arr[@]}

for (( k=0; k<$numb ; k++ ))
do
	writefile="/home/yangkai/plt/summery/time_"
	writefile+="${arr[$k]}"
	writefile+=".txt"

	dirfile="/home/yangkai/plt/recording/"
	dirfile+="${arr[$k]}"

	echo $writefile

	./e_show $writefile $dirfile
done



files=`ls /home/yangkai/plt/ratio`
arr=(${files//,/})
numb=${#arr[@]}

for (( k=0; k<$numb ; k++ ))
do
	writefile="/home/yangkai/plt/summery/ratio_"
	writefile+="${arr[$k]}"
	writefile+=".txt"

	dirfile="/home/yangkai/plt/ratio/"
	dirfile+="${arr[$k]}"

	echo $writefile

	./e_show $writefile $dirfile
done


arr=("count" "window" "when" "where" "howlong" "distance" "distance_single" "knn"
	"count_without_index" "window_without_index" "when_without_index" "where_without_index"
	"howlong_without_index" "distance_without_index" "distance_single_without_index" "knn_without_index")
numb=${#arr[@]}

for (( k=0; k<$numb ; k++ ))
do
	writefile="/home/yangkai/plt/summery/query_"
	writefile+="${arr[$k]}"
	writefile+=".txt"

	dirfile="/home/yangkai/plt/query/"
	dirfile+="${arr[$k]}"

	echo $writefile

	./e_show $writefile $dirfile
done

rm e_show
