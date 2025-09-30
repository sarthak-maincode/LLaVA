git config --global safe.directory '*'
git config --global core.editor "code --wait"
git config --global pager.branch false

# Set AZCOPY concurrency to auto
echo "export AZCOPY_CONCURRENCY_VALUE=AUTO" >> ~/.zshrc
echo "export AZCOPY_CONCURRENCY_VALUE=AUTO" >> ~/.bashrc

# Activate conda by default
echo ". /home/vscode/miniconda3/bin/activate" >> ~/.zshrc
echo ". /home/vscode/miniconda3/bin/activate" >> ~/.bashrc

# Use llava environment by default
echo "conda activate llava" >> ~/.zshrc
echo "conda activate llava" >> ~/.bashrc

# Add dotnet to PATH
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.bashrc
echo 'export PATH="$PATH:$HOME/.dotnet"' >> ~/.zshrc

# Create and activate llava environment
source /home/vscode/miniconda3/bin/activate
conda create -y -q -n llava python=3.10
conda activate llava

# Install Nvidia CUDA Toolkit 12.8 (includes nvcc for DeepSpeed)
conda install -y -c nvidia/label/cuda-12.8.0 cuda-toolkit

# Set CUDA environment variables for DeepSpeed and flash-attn compilation
export CUDA_HOME=$CONDA_PREFIX
export PATH=$CUDA_HOME/bin:$PATH

# Install PyTorch with CUDA 12.8 support for B200 GPU
pip install --pre torch torchvision --index-url https://download.pytorch.org/whl/nightly/cu128

pip install pre-commit==3.0.2

# Install package locally
pip install --upgrade pip  # enable PEP 660 support
pip install -e .

# Install additional packages for training
pip install -e ".[train]"
pip install flash-attn --no-build-isolation

# Add CUDA environment variables to shell profiles for persistence
echo "export CUDA_HOME=\$CONDA_PREFIX" >> ~/.zshrc
echo "export PATH=\$CUDA_HOME/bin:\$PATH" >> ~/.zshrc
echo "export CUDA_HOME=\$CONDA_PREFIX" >> ~/.bashrc
echo "export PATH=\$CUDA_HOME/bin:\$PATH" >> ~/.bashrc

# Download checkpoints to location outside of the repo
git clone https://huggingface.co/liuhaotian/llava-v1.5-7b ~/llava-v1.5-7b

# Commented because it is unlikely for users to have enough local GPU memory to load the model
# git clone https://huggingface.co/liuhaotian/llava-v1.5-13b ~/llava-v1.5-13b

echo "postCreateCommand.sh COMPLETE!"
