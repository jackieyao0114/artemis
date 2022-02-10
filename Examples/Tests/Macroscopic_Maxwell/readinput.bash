#!/bin/bash  
  
# Read the user input   
  
for alpha in $(seq 0.0001 0.0001 0.5); do
    echo -en "macroscopic.mag_alpha = $alpha" >> inputs_3d_LLG_ML
    ./main3d.gnu.TPROF.MTMPI.CUDA.LLG.GPUCLOCK.ex inputs_3d_LLG_ML 
    # tac inputs_3d_LLG_ML  | sed -i '2d' | tac  
    sed -i '$d' inputs_3d_LLG_ML 
    mkdir raw_data${alpha}
    for timestep in $(seq 0 10 5000 ); do
        newnumber='000000000'${timestep}      # get number, pack with zeros
        newnumber=${newnumber:(-5)}       # the last seven characters
        ./WritePlotfileToASCII3d.gnu.ex infile=diags/plt${newnumber} | tee raw_data${alpha}/${newnumber}.txt
        bash getLine.bash raw_data${alpha}/${newnumber}.txt 7 | tee -a Mz_zface_${alpha}.txt
        bash getLine.bash raw_data${alpha}/${newnumber}.txt 6 | tee -a My_yface_${alpha}.txt
        bash getLine.bash raw_data${alpha}/${newnumber}.txt 5 | tee -a Mx_xface_${alpha}.txt
    done
    rm -r ./diags
done