#!/bin/bash
#
# Create a docx file with --toc from the contents of every file in a directory that contains
# a given string, and then publishes it in a folder in Dropbox
#
# Motivation:
# Compile a single file with all approved or requesting for approval files, and place it in the
# project's shared Dropbox folder
#
# Requires:
#   1) A folder with n *.md file
#   2) Pandoc installed
#	3) CURL installed
#	4) A config file with an ACCESS_TOKEN key containing the access token
#
# Ensures
#   1) A *.docx files with a TOC at the beggining and a table with changes history at the end

source $HOME/config
find . -name "*.md" -type f -print0 | sort -z | xargs -0 grep -l "status: elaborada" | xargs -t pandoc -o file-name.docx -s --toc --reference-doc "template.docx"
curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $ACCESS_TOKEN" --header "Dropbox-API-Arg: {\"path\": \"/folder/file-name.docx\", \"mode\": \"overwrite\"}" --header "Content-Type: application/octet-stream" --data-binary @file-name.docx

