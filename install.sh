# Create workspace
echo "==========CREATING DIRECTORY=========="
WS_DIR=~/CS_503_ws
mkdir -p ${WS_DIR}

# Find conda
echo "==========FINDING INSTALLED CONDA=========="
eval "$(conda shell.bash hook)"

# Install environment
echo "==========CREATING ENVIRONMENT=========="
ENV_NAME=habitat
conda create -y -n ${ENV_NAME} python=3.8 cmake=3.19.6
conda activate ${ENV_NAME}
conda install -y pandas seaborn

# Change to ws folder
cd ${WS_DIR}

# Install Habitat-Sim
echo "==========INSTALLING HABITAT-SIM=========="
git clone --branch v0.2.3 https://github.com/facebookresearch/habitat-sim.git --depth 1  ${WS_DIR}/habitat-sim
cd ${WS_DIR}/habitat-sim
pip install -r requirements.txt
python setup.py install --headless  # or pip install . -v

# Install Habitat-Lab
echo "==========INSTALLING HABITAT-LAB=========="
git clone --branch v0.2.3 https://github.com/facebookresearch/habitat-lab.git --depth 1 ${WS_DIR}/habitat-lab
cd ${WS_DIR}/habitat-lab
pip install -e habitat-lab  # install habitat_lab

# Install Habitat-Baselines
echo "==========INSTALLING HABITAT-BASELINES=========="
pip install -e habitat-baselines  # install habitat_baselines

# Register kernel
echo "==========CREATING KERNEL=========="
conda install -y pip
pip install notebook ipykernel
python -m ipykernel install --user --name ${ENV_NAME} --display-name ${ENV_NAME}