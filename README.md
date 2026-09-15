# Boltz2

Codebase for SHOC2 containerised version of Boltz2. Files:

- boltz2.def:	Apptainer definition file to build a container for boltz2
- build_boltz2.sh:Bash script to build boltz2 container
- boltz2.ipynb:	Jupyter notebook to use boltz2 interactively
- run_boltz2.sl:	SLURM script to run boltz2.ipynb non-interactively

Suggested usage:

1. Run ./build_boltz2.sh and make sure boltz2.sif is built
2. Goto https://ondemand.nesi.org.nz/public/ and select Jupyter Lab
    - Cluster: SLURM HPC
    - Project Code: uoa04517
    - JupyterLab Module: 2026.7.0-foss-2026-4.6.0
    - Number of Hours: 2
    - Number of Cores: 4
    - Memory per Job: 20 GB
    - GPU: L4
3. When Open Ondemand starts, choose the select the file 'boltz2.ipynb' from the chooser
4. Modify file to run your workflow
5. If you need to run for longer, or a GPU is not available, save changes in boltz2.ipynb, open a terminal kernel in Open Ondemand, and type:
6. sbatch run_boltz2.sl
