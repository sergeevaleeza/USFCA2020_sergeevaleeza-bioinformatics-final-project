#!/bin/bash

set -euo pipefail

# Edited on December 1, 2020 to take an additional argument.
# A bash script to drive the rendering of an Rmarkdown file
# it requires 5 arguments, as described below

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 1, 2020

# Leeza Sergeeva
# esergeeva@usfca.edu
# December 2, 2020

if [ $# -ne 5 ]
then
  echo "To run this script, supply four arguments:"
  echo "The first should be the name of the Rmd file to be rendered"
  echo "The second should be the path to the gff annotation file"
  echo "The third should be the path to the directory of processed vcf files"
  echo "The fourth should be the path to the SRA run table containing sample metadata"
  echo "The fifth should be the date in format YYYYMMDD"
  exit 1
fi

# Set input params for the render command
RMD_FILE="$1"
RMD_PARAMS="params = list(gff_file_path = '$2', vcf_dir_path = '$3', sra_runtable_path = '$4', chosen_date = '$5')"
RMD_OUTPUT="output_dir = 'output'"

# the single quotes around $RMD_FILE are key otherwise R thinks it's an object instead of a file
Rscript -e "rmarkdown::render('$RMD_FILE', $RMD_PARAMS, $RMD_OUTPUT)"
