#!/bin/bash -e

#SBATCH --time          00:10:00
#SBATCH --mem           20GB
#SBATCH --cpus-per-task 8
#SBATCH --account       uoa04517
#SBATCH --gres		gpu:pro_6000:1
#SBATCH --job-name      boltz2
#SBATCH --output        boltz2.log

module load JupyterLab/2026.7.0-foss-2026-4.6.0

#Check for a key at ~/.ngc/ngc_api_key.boltz2
#Exit if no key
./check_boltz2_api_key.sh

papermill boltz2.ipynb output_boltz2.ipynb -p API_KEY $(cat ~/.ngc/ngc_api_key.boltz2)
