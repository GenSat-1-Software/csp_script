#!/bin/bash

# Default values
input_file="default_input.txt"
output_file="default_output.txt"
verbose=false

# Function to display usage
function display_usage {
    echo "Usage: $0 [-i input_file] [-o output_file] [-v]"
    exit 1
}

# Parse command line options
while getopts ":i:o:v" opt; do
    case $opt in
        i)
            input_file="$OPTARG"
            ;;
        o)
            output_file="$OPTARG"
            ;;
        v)
            verbose=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            display_usage
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            display_usage
            ;;
    esac
done

# Shift the command line arguments to skip processed options
shift $((OPTIND - 1))

# Additional positional arguments (if any)
if [ $# -gt 0 ]; then
    echo "Additional arguments: $@"
fi

# Display the updated values
echo "Input file: $input_file"
echo "Output file: $output_file"
echo "Verbose mode: $verbose"
