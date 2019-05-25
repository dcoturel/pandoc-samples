#!/bin/bash
#
# Create an epub file with all the *.md files in the directory. It prepends a table of contents
#
# Motivation:
# Create EPUB file for publishing
#
# Requires:
#   1) A folder with n *.md file
#   2) Pandoc installed
#
# Ensures
#   1) EPUB file with a TOC at the beggining

pandoc -o book.epub -s *.md --toc
