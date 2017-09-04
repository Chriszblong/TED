#!/bin/bash

cd /home/yangkai/plt/code
g++ -O3 e_ltot.cpp -o e_ltot

files=`find /home/yangkai/plt/result/p_coding -name "*.txt"`

arr=(${files//,/})
numb=${#arr[@]}
for (( k=0; k<$numb ; k++ ))
do
	tstring="beijing"
	lcodingfile=${arr[$k]}
	lcodingfile=${lcodingfile/"p_coding"/"l_coding"}
	tcodingfile=${arr[$k]}
	tcodingfile=${lcodingfile/"p_coding"/"t_coding"}
	interval=${arr[$k]}
	interval=${interval/"result/p_coding"/"interval"}
	writefile=${arr[$k]}
	writefile=${writefile/"result/p_coding"/"query/e_ltot"}

	if [[ ${arr[$k]} == *$tstring* ]]
	then
		./e_ltot /home/yangkai/plt/dataset/beijing/roadnetwork/WA_Nodes.txt /home/yangkai/plt/dataset/beijing/roadnetwork/WA_Edges.txt /home/yangkai/plt/dataset/beijing/roadnetwork/WA_EdgeGeometry.txt ${arr[$k]} $lcodingfile $tcodingfile $interval $writefile
	else
		./e_ltot /home/yangkai/plt/dataset/singapore/roadnetwork/WA_Nodes.txt /home/yangkai/plt/dataset/singapore/roadnetwork/WA_Edges.txt /home/yangkai/plt/dataset/singapore/roadnetwork/WA_EdgeGeometry.txt ${arr[$k]} $lcodingfile $tcodingfile $interval $writefile
	fi
done

rm e_ltot
