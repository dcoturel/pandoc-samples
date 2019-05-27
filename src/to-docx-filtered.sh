#!/bin/bash
#
# Create a docx file with --toc from the contents of every file in a directory that contains
# a given string
#
# Motivation:
# Compile a single file with all approved or requesting for approval files
#
# Requires:
#   1) A folder with n *.md file
#   2) Pandoc installed
#
# Ensures
#   1) A *.docx files with a TOC at the beggining and a table with changes history at the end

find . -name "*.md" -type f -print0 | sort -z | xargs -0 grep -l "status: elaborada" | xargs -t pandoc -o elaboradas.docx -s --toc
