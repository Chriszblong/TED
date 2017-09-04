#!/bin/bash
cd /home/yangkai/plt/shell

program=("LRatio" "PRatio" "TRatio" "DDPRatio" "PDDPRatio" "HuffmanRatio" "TedWithoutIndexRatio" "TedWithDDPIndexRatio" "TedWithPDDPIndexRatio" "TedWithHuffmanIndexRatio" "TedWithAddingfixedbitsIndexRatio")

select="all"

for args in $@
do
	case "$args" in
		"length")
			if [[ $select == *beijing* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram beijing length
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram singapore length
				done
			else
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram all length
				done
			fi
			;;
		"number")
			if [[ $select == *beijing* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram beijing number
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram singapore number
				done
			else
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram all number
				done
			fi
			;;
		"threshold")
			if [[ $select == *beijing* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram beijing threshold
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram singapore threshold
				done
			else
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram all threshold
				done
			fi
			;;
		"insert")
			if [[ $select == *beijing* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram beijing insert
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram singapore insert
				done
			else
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram all insert
				done
			fi
			;;
		"entry")
			if [[ $select == *beijing* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram beijing entry
				done
			elif [[ $select == *singapore* ]]
			then
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram singapore entry
				done
			else
				for i in {0..10}
				do
					tmpProgram=${program[$i]}
					tmpProgram+=".sh"
					./$tmpProgram all entry
				done
			fi
			;;
		"all" | "singapore" | "beijing")
			select="$args"
			;;
	esac
done
