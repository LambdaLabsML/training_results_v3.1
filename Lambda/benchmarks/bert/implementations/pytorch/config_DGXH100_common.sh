## System config params
export DGXNGPU=8
export DGXSOCKETCORES=64
export DGXNSOCKET=2
export DGXHT=2         # HT is on is 2, HT off is 1
export SLURM_NTASKS=${DGXNGPU}
export CONT="172.26.134.239:5000#local/mlperf-nvidia-24.05:language_model"
export NEXP=1