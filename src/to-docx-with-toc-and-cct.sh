#!/bin/bash
#
# Traverse a directory. Create a file named cdc.md with each file's commit log. Then create a *.docx file with
# the contents of the original file and the cdc.md file appended at the end of it.
#
# Motivation:
# Create doc files with revision history, for compliance with ISO procedures
#
# Requires:
#   1) A folder with at n *.md file
#   2) Pandoc installed
#   3) Git installed and keeping track of the files in the folder
#
# Ensures
#   1) n *.docx files with a TOC at the beggining and a table with changes history at the end

for i in *.md
do
    if test -f "$i" 
    then
		touch cdc.md
		echo "## Change control" >> cdc.md
		echo "|Date|User|Comment|" >> cdc.md
		echo "|---|---|---|" >> cdc.md
		git log --pretty=format:"|%aI|%an|%s|" "$i" >> cdc.md
		pandoc -o "$i.docx" -s --toc "$i" cdc.md
		rm cdc.md
       
    fi
done
