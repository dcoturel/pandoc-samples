#!/bin/bash
#
# Create an odt file with all the *.md files in the directory. It prepends a table of contents
#
# Motivation:
# Create odt file with table of contents, in order to compile a list of documented decisions or
# meeting's notes and send them to someone
#
# Requires:
#   1) A folder with n *.md file
#   2) Pandoc installed
#
# Ensures
#   1) an ODT file with a TOC at the beggining

pandoc -o document.odt -s *.md --toc
