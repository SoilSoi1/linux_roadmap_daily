# Setting Up 3D Gaussian Splatting (3DGS) on Windows 11

*Initial commit: 2025-05-20*

---

## Table of Contents

- [Preparation](#preparation)
  - [Clone the Repository](#clone-the-repository)
  - [Install Visual Studio](#install-visual-studio)
  - [Install COLMAP](#install-colmap)
  - [Install FFmpeg](#install-ffmpeg)
  - [Set Up Conda Environment](#set-up-conda-environment)
- [Start](#start)

---

## Preparation

This section outlines the necessary steps for setting up 3DGS on Windows 11. Detailed usage of Git and Conda is not covered here.

### Clone the Repository

Choose a suitable disk location to store the raw 3DGS code repository. Then run:

```bash
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive
```

> **Note**: The `--recursive` flag is essential to ensure that all required submodules are properly initialized.

### Install Visual Studio

Download Visual Studio 2022 from [https://visualstudio.microsoft.com/zh-hans/vs/](https://visualstudio.microsoft.com/zh-hans/vs/), and make sure to include the C++ development tools during installation.

After installation, add the following directory to your system's PATH environment variable:

```
<Your VS Path>/VC/Tools/MSVC/<version>/bin/Hostx64/x64/
```

Restart your terminal and run `cl` to verify that the compiler is correctly configured.

### Install COLMAP

COLMAP is used to generate sparse point clouds via SfM and MVS, and is a prerequisite for 3DGS as well as other models like NeRF.

There is ongoing discussion about version compatibility—some users report that newer versions (e.g., 3.11) may produce incorrect reconstructions (e.g., output includes only two images regardless of input). Although it's unclear if the version is the sole cause, this guide uses COLMAP 3.8 to ensure consistency.

Download COLMAP 3.8 from:
```
https://github.com/colmap/colmap/releases/download/3.8/COLMAP-3.8-windows-cuda.zip
```

Extract the archive and add the extracted `bin` directory to your system's PATH environment variable.

To verify the installation, run:
```bash
colmap --version
colmap gui
```

> *Note: I initially attempted to compile COLMAP under WSL2 but encountered various CMake errors. Due to these complications, I decided to switch to Windows for this setup.*

### Install FFmpeg

[FFmpeg](https://ffmpeg.org/) is a versatile tool for processing video and audio. In the 3DGS project, it is primarily used to extract frames from videos for reconstruction.

Download the latest essentials build:
```
https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-essentials.7z
```

Extract it and add the `bin` folder to your PATH.

Verify the installation by running:
```bash
ffmpeg
```

### Set Up Conda Environment

Create a Conda environment named `3dgs` with Python ≥3.9, but I use python=3.10 here:

```bash
conda create -n 3dgs python=3.10
conda activate 3dgs
```

Install PyTorch with CUDA 12.4:

```bash
pip install torch==2.6.0 torchvision==0.21.0 torchaudio==2.6.0 --index-url https://download.pytorch.org/whl/cu124
```

Download and install the CUDA Toolkit 12.4:
```
https://developer.download.nvidia.com/compute/cuda/12.4.0/local_installers/cuda_12.4.0_551.61_windows.exe
```

Verify CUDA installation:

```bash
nvcc --version
nvidia-smi
```

Install additional dependencies based on `gaussian-splatting/environment.yml`:

```bash
pip install tqdm plyfile
pip install opencv-python joblib
```

Install the submodules:

```bash
pip install .\submodules\diff-gaussian-rasterization
pip install .\submodules\simple-knn
pip install .\submodules\fused-ssim
```

---

## Start

### FFmpeg: Extract Frames

This step should be straightforward, but there is a critical issue that many users have reported: the format of the input images extracted from the video must be **png**. Initially, I followed this recommendation, but as mentioned earlier, the output folder always contained only two images, regardless of the input. After some troubleshooting, I discovered that replacing **png** with **jpg** resolved the issue. The problem was fixed just like that—what a relief!

To extract frames from a video, run the following command:

```bash
ffmpeg -i <video path> -vf "fps=5, setpts=0.2*PTS" <folder_path>\input_%04d.jpg
```

- The `-vf` flag specifies a video filter. In this case:
    - `fps=5` sets the frame rate to 5 frames per second.
    - `setpts=0.2*PTS` adjusts the presentation timestamp (PTS) to speed up the video by a factor of 5 (i.e., 1/0.2).
- `%04d` is a placeholder for numbering the output files. It ensures that the extracted frames are saved with zero-padded, four-digit filenames (e.g., `input_0001.jpg`, `input_0002.jpg`, etc.).

This should resolve any issues with frame extraction and ensure compatibility with the 3DGS pipeline.

### 
