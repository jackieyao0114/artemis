# ARTEMIS
ARTEMIS (Adaptive mesh Refinement Time-domain ElectrodynaMIcs Solver) is a high-performance coupled electrodynamics–micromagnetics solver for full physical modeling of signals in microelectronic circuitry. The overall strategy couples a finite-difference time-domain (FDTD) approach for Maxwell’s equations to a magnetization model described by the Landau–Lifshitz–Gilbert (LLG) equation. The algorithm is implemented in the Exascale Computing Project (ECP) software framework, AMReX, which provides effective scalability on manycore and GPU-based supercomputing architectures. Furthermore, the code leverages ongoing developments of the Exascale Application Code, WarpX, which is primarily being developed for plasma wakefield accelerator modeling. Our temporal coupling scheme provides second-order accuracy in space and time by combining the integration steps for the magnetic field and magnetization into an iterative sub-step that includes a trapezoidal temporal discretization for the magnetization. The performance of the algorithm is demonstrated by the excellent scaling results on NERSC multicore and GPU systems, with a significant (59×) speedup on the GPU using a node-by-node comparison. The utility of our code is validated by performing simulations of transmission lines, rectangle electromagnetic waveguides, magnetically tunable filters, on-chip coplanar waveguides and resonators, magnon-photon coupling circuits, and so on.

# Installation
## Download AMReX Repository
``` git clone git@github.com:AMReX-Codes/amrex.git ```
## Download Artemis Repository
``` git clone git@github.com:AMReX-Microelectronics/artemis.git ```
## Build
Make sure that the AMReX and Artemis are cloned in the same location in their filesystem. Navigate to the Exec folder of Artemis and execute
```make -j 4```. <br />
You can turn on and off the LLG equation by specifying ```USE_LLG``` during compilation. <br />
The following command compiles Artemis without LLG
```make -j 4 USE_LLG=FALSE``` <br />
The following command compiles Artemis with LLG
```make -j 4 USE_LLG=TRUE``` <br />
The default value of ```USE_LLG``` is ```TRUE```.

# Running Artemis
Example input scripts are located in `Examples` directory. 
## Simple Testcase
You can run the following to simulate :
## For MPI+OMP build
```mpirun -n 4 ./main3d.gnu.MPI.OMP.ex Examples/inputs_mfim_Noeb```
## For MPI+CUDA build
```mpirun -n 4 ./main3d.gnu.MPI.CUDA.ex Examples/inputs_mfim_Noeb```
# Visualization and Data Analysis
Refer to the following link for several visualization tools that can be used for AMReX plotfiles. 

[Visualization](https://amrex-codes.github.io/amrex/docs_html/Visualization_Chapter.html)

### Data Analysis in Python using yt 
You can extract the data in numpy array format using yt (you can refer to this for installation and usage of [yt](https://yt-project.org/). After you have installed yt, you can do something as follows, for example, to get variable 'Pz' (z-component of polarization)
```
import yt
ds = yt.load('./plt00001000/') # for data at time step 1000
ad0 = ds.covering_grid(level=0, left_edge=ds.domain_left_edge, dims=ds.domain_dimensions)
P_array = ad0['Pz'].to_ndarray()
```
# Publications
1. P. Kumar, M. Hoffmann, A. Nonaka, S. Salahuddin, and Z. Yao, 3D ferroelectric phase field simulations of polycrystalline multi-phase hafnia and zirconia based ultra-thin films, submitted for publication. [arxiv](https://arxiv.org/abs/2402.05331)
2. P. Kumar, A. Nonaka, R. Jambunathan, G. Pahwa, S. Salahuddin, and Z. Yao, Artemis: A GPU-accelerated, 3D Phase-Field Simulation Framework for Modeling Ferroelectric Devices, Computer Physics Communications, 108757, 2023. [link](https://www.sciencedirect.com/science/article/pii/S0010465523001029)