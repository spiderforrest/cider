#!/usr/bin/bash

# i should really be using gitignore but honestly i'm paranoid about either the size limit or pushing copyrighted shit cos yikes
# so here's my janky whitelisting

# search for new files in dirs/subdirs
targets=('survival' 'creative' 'mindustry')
subtargets=('world' 'logs' 'crash-reports' 'carpet' 'config' 'luke')

echo "/// fuck it, trying everything... ///"
for target in "${targets[@]}" ; do
	for sub in "${subtargets[@]}" ; do
		yadm add "$target/$sub"
	done
done

# hit everything modified
yadm add -u

# use args as commit message if present
if [[ -n "$1" ]] ; then
	yadm status
	echo "/// cool with everything? using args as commit message ///"
	read -r
	yadm commit -m "$*"
	yadm push
else
	# otherwise generate it based off of changed files
	echo "/// autogenerating commit message... ///"
	list=$(yadm status)
	msg="Updated"
	for target in "${targets[@]}"; do
		if $(echo "$list" | grep -qm 1 "$target") ; then
			# add to the commit message if the target's been updated
			msg+=", $target"
		fi
	done
	echo "/// $msg ///"
	echo "/// and auto commiting and pushing... ///"
	yadm commit -m "$msg"
	yadm push
fi

echo "/// done. i mean, i have no idea if it worked, but i'm done."
