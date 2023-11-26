#!/bin/bash -l
#SBATCH --ntasks 16 --mem 8G -p short --error logs/orthofinder.%j.err -o logs/orthofinder.%j.log --time 48:00

module load ncbi-blast
module load orthofinder

which orthofinder

CPU=8

fasta_dir=../download_assemblies/download
input_dir=download
output_dir=output

# Check if input is already ready
if [ -d "$input_dir" ] && [ "$(ls -A $input_dir)" ]; then
    echo "Input is already processed. Skipping uncompression and processing."
else
    ln -s $fasta_dir/* $input_dir/
fi

if [ -d "$output_dir" ] && [ "$(ls -A $output_dir)" ]; then
    echo "Orthofinder has run. Skipping OF."
else
    orthofinder -a $CPU -f $input_dir -o $output_dir -d
fi

