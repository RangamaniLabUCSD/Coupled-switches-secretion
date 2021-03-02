#!/bin/bash
#SBATCH -J main2
#SBATCH -p cpu
#SBATCH -N 1
#SBATCH --cpus-per-task=48
#SBATCH -t 1-00:00:00
#SBATCH --qos=normal
#SBATCH -o slurm-%A.out




module add matlab/r2019b
cd .
matlab -nodesktop -nodisplay -nosplash -r 'main2'
