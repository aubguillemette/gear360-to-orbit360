#!/bin/bash

# Function to print usage
usage() {
  echo "Usage: $0 -i <input_file> [-o <output_file>] [-m <metadata_dir_path>] [-f <ffmpeg_path>] [-p <mp4edit_path>]"
  exit 1
}

# Default values
metadata_dir_path="metadata"
ffmpeg_path="$(command -v ffmpeg)"
mp4edit_path="$(command -v mp4edit)"

# Parse options
while getopts "i:o:m:f:p:" opt; do
  case $opt in
    i) input_file="$OPTARG" ;;
    o) output_file="$OPTARG" ;;
    m) metadata_dir_path="$OPTARG" ;;
    f) ffmpeg_path="$OPTARG" ;;
    p) mp4edit_path="$OPTARG" ;;
    *) usage ;;
  esac
done

# Validation
if [ -z "$input_file" ]; then
  usage
fi

if [ ! -d "$metadata_dir_path" ]; then
  echo "Metadata directory does not exist: $metadata_dir_path"
  exit 1
fi

if [ -z "$ffmpeg_path" ]; then
  echo "ffmpeg not found. (You can set the -f option to specify the path to ffmpeg)"
  exit 1
fi

if [ -z "$mp4edit_path" ]; then
  echo "mp4edit not found. (You can set the -p option to specify the path to mp4edit)"
  exit 1
fi

if [ -z "$output_file" ]; then
  output_file="${input_file%.*}_processed.mp4"
fi

if [ ! -f "$input_file" ]; then
  echo "Input file does not exist: $input_file"
  exit 1
fi

# Remove trailing slashes
metadata_dir_path="${metadata_dir_path%/}"

# Do the thing
"$ffmpeg_path" -i "$input_file" -s 3840x1920 -c:a copy remuxed.mp4

"$mp4edit_path" \
  --insert "moov/udta/:${metadata_dir_path}/fmt.udta:0" \
  --insert "moov/udta/:${metadata_dir_path}/inf.udta:1" \
  --insert "moov/udta/:${metadata_dir_path}/SNumSham.udta:2" \
  --insert "moov/udta/:${metadata_dir_path}/mcm.udta:3" \
  --insert "moov/udta/:${metadata_dir_path}/mvr.udta:4" \
  --insert "moov/udta/:${metadata_dir_path}/rads.udta" \
  remuxed.mp4 "$output_file"

rm -f remuxed.mp4
