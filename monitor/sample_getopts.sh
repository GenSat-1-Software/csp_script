#!/bin/bash

while getopts ":a:b:c:" opt; do
  case $opt in
    a)
      arg_a="$OPTARG"
      ;;
    b)
      arg_b="$OPTARG"
      ;;
    c)
      arg_c="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo "Option -a: $arg_a"
echo "Option -b: $arg_b"
echo "Option -c: $arg_c"

# Shift the positional parameters to exclude the parsed options
shift $((OPTIND-1))

# Any remaining arguments (not options) can be accessed using $@
echo "Remaining arguments: $@"

# Your script logic goes here using the parsed options and arguments
