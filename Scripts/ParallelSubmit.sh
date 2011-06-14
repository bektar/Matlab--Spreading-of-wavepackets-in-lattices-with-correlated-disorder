#!/bin/bash
#######################################################################


# The last option is important when running more than one instance of 
# Matlab on a node. Performance is severely decreased otherwise. 
MATLAB='matlab -nodisplay -singleCompThread -r'

# Start Matlab and run the job file which will produce a $job_*.out 
# and $job_*.log file for each of the 16 independent runs. 
# Note the explicit "exit" to exit Matlab.
for i in $(seq 1 $NumberOfIterations);do
  srun -N1 -n1 --exclusive $MATLAB "BTKappa('$BatchName',$i);exit" >> Logs/Kappa.log &
done

wait
rm BTKappa.m
rm settings.mat
mv ~/jobs/$BatchName ~/finished/$BatchName

#mail -s "Kappa: $BatchName" -u x_jakro jacro@ifm.liu.se <~/finished/$BatchName/Logs/$BatchName.log

#
# End of script
#