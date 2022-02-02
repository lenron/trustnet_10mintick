#!/bin/bash

echo "Starting 10 minute tick script."


while [ true ]
do
	# Search main directory for html files
	for f in ../trustnet/*.html		# Loop through the files
	do
		if [ -f "${f##*/}" ]			# If the file exsists in this dir
		then						# Check for difference
			echo "file found! Is it different?"
			DIFF=$(diff $f ${f##*/})
			if [ "$DIFF" != "" ]				
			then								
				echo "Updating file $f"
				cp -f $f .		# If it's different, force copy it over
				`git commit -m '10 minute timer update' ${f##*/}`
				`git push`						# commit, and upload the changes to github
			else
				echo "no changes to ${f##*/}"
			fi
		else									# If the file doesn't exist copy it over
			cp $f .							# add, commit, and upload it to github
			echo "copying ${f##*/}"
			`git add ${f##*/}`
			`git commit -m 'initial upload - 10 minute timer' ${f##*/}`
			`git push`
		fi
	done
	echo ""
	sleep 10m		#10m
done
