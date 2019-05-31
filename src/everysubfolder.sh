#!/bin/bash
#
# Create a docx file with --toc from the contents of every file in every subdirectory
# of the current working directory. Then, it uploads all the files to Dropbox
#
# Motivation:
# Handle the publication of a collection of how-to files, each with a subfolder of images
#
# Requires:
#   1) A folder with n subfolders
#   2) Pandoc installed
#	3) CURL installed
#	4) A config file with an ACCESS_TOKEN key containing the access token
#
# Ensures
#   1) N *.docx files with a TOC at the beggining

source $HOME/config


for D in */; do
        cd "$D"
        
        curl -X POST https://content.dropboxapi.com/2/files/download --header "Authorization: Bearer $ACCESS_TOKEN" --header "Dropbox-API-Arg: {\"path\": \"/TEMPLATES/instructivo.docx\"}" -o "./instructivo.docx"

        filename=${D%*/}

        pandoc -o temporal.docx -s --toc --reference-doc "instructivo.docx" *.md

        curl -X POST https://content.dropboxapi.com/2/files/upload --header "Authorization: Bearer $ACCESS_TOKEN" --header "Dropbox-API-Arg: {\"path\": \"/PUBLICADOS/tngroup-$filename.docx\", \"mode\": \"overwrite\"}" --header "Content-Type: application/octet-stream" --data-binary @temporal.docx
        
        cd ..        


done
