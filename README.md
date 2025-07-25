# Parallel Image Filtering

A comparative study of parallel computing approaches for image filtering applications, implementing and benchmarking multiple parallelism models across different architectures.

## Overview

This project aims to speed up image filtering operations through various parallelization techniques and determine which approach is most suitable for specific image processing tasks. The implementation compares performance across CPU and GPU architectures using different parallel programming models.

## Parallelism Models Implemented

### 🖥️ CPU-based Approaches
- **OpenMP**: Shared-memory parallelization for multi-core CPU systems
- **MPI**: Message Passing Interface for distributed computing across multiple processes

### 🚀 GPU-based Approach
- **CUDA**: GPU acceleration using NVIDIA's parallel computing platform

## Features

- Multiple image filtering algorithms implemented in parallel
- Performance benchmarking and comparison tools
- Cross-architecture optimization analysis
- Scalability testing across different system configurations
- Comprehensive performance metrics and timing analysis

## Project Structure

```
Parallel-Image-Filtering/
├── src/
│   ├── openmp/          # OpenMP implementations
│   ├── mpi/             # MPI implementations
│   ├── cuda/            # CUDA implementations
│   └── sequential/      # Sequential baseline implementations
├── benchmarks/          # Performance testing scripts
├── results/            # Performance analysis results
├── images/             # Test images for filtering
└── docs/               # Documentation and reports
```

## Prerequisites

### For OpenMP
- GCC compiler with OpenMP support (`gcc` with `-fopenmp` flag)
- Multi-core CPU system

### For MPI
- MPI implementation (OpenMPI or MPICH)
- Multiple CPU cores or distributed computing environment

### For CUDA
- NVIDIA GPU with CUDA capability
- CUDA Toolkit (version X.X or higher)
- Compatible NVIDIA drivers

## Installation

1. Clone the repository:
```bash
git clone https://github.com/NEGU93/Parallel-Image-FIltering.git
cd Parallel-Image-FIltering
```

2. Install dependencies based on your target parallelization model:

**For OpenMP:**
```bash
# Ubuntu/Debian
sudo apt-get install gcc libomp-dev

# CentOS/RHEL
sudo yum install gcc-c++ libgomp-devel
```

**For MPI:**
```bash
# Ubuntu/Debian
sudo apt-get install openmpi-bin openmpi-dev

# CentOS/RHEL
sudo yum install openmpi openmpi-devel
```

**For CUDA:**
- Install CUDA Toolkit from [NVIDIA Developer](https://developer.nvidia.com/cuda-toolkit)
- Ensure compatible GPU drivers are installed

## Compilation

### OpenMP Version
```bash
cd src/openmp
make
```

### MPI Version
```bash
cd src/mpi
make
```

### CUDA Version
```bash
cd src/cuda
make
```

## Usage

### Running Sequential Baseline
```bash
./sequential_filter input_image.jpg output_image.jpg [filter_type]
```

### Running OpenMP Version
```bash
export OMP_NUM_THREADS=4
./openmp_filter input_image.jpg output_image.jpg [filter_type]
```

### Running MPI Version
```bash
mpirun -np 4 ./mpi_filter input_image.jpg output_image.jpg [filter_type]
```

### Running CUDA Version
```bash
./cuda_filter input_image.jpg output_image.jpg [filter_type]
```

## Supported Filter Types

- Gaussian Blur
- Edge Detection (Sobel, Laplacian)
- Median Filter
- Convolution filters
- Custom kernel filters

## Benchmarking

Run comprehensive performance tests:

```bash
cd benchmarks
./run_all_benchmarks.sh
```

This will execute all implementations with various image sizes and generate performance comparison reports.

## Performance Analysis

The project includes tools for analyzing:

- **Execution time** across different parallelization approaches
- **Speedup calculations** compared to sequential implementation
- **Scalability analysis** with varying number of threads/processes
- **Memory usage** and efficiency metrics
- **GPU utilization** statistics for CUDA implementation

## Results and Findings

Performance results and analysis can be found in the `results/` directory, including:

- Comparative performance charts
- Scalability analysis graphs
- Architecture-specific optimization recommendations
- Best practices for each parallelization model

## Key Insights

*(Results will vary based on hardware configuration)*

- **CPU-bound tasks**: OpenMP typically shows good performance for shared-memory systems
- **Distributed computing**: MPI excels in multi-node environments
- **Highly parallel operations**: CUDA demonstrates significant speedup for suitable algorithms
- **Memory-intensive filters**: GPU implementations may be limited by memory bandwidth

---

*This project serves as both a practical implementation study and educational resource for understanding parallel computing approaches in image processing applications.*
