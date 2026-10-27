#!/bin/bash -le

# -l makes this a login shell so the NeSI arch module (NeSI/zen3) is
# initialised before `module load` runs. Without it this script only works
# when submitted from a session that already has modules loaded, such as an
# Open OnDemand terminal; submitted over plain ssh or from cron it fails with
# "JupyterLab ... cannot be loaded as requested" and papermill: command not found.

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
