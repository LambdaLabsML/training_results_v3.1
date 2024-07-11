## DL params                                                                                                                                                                                                          
export BATCHSIZE=48
export GRADIENT_STEPS=1
export PACKING_FACTOR=1
export LR=0.002
export MAX_SAMPLES_TERMINATION=450000000
export MAX_STEPS=6000
export OPT_LAMB_BETA_1=0.66
export OPT_LAMB_BETA_2=0.996
export START_WARMUP_STEP=0
export WARMUP_PROPORTION=0.0
export WEIGHT_DECAY_RATE=0.01
export INIT_LOSS_SCALE=4096.0

export SBATCH_NETWORK=sharp
export EXTRA_PARAMS="--dense_seq_output --pad_fmha --fused_bias_fc --fused_bias_mha --fused_dropout_add --fused_gemm_gelu --packed_samples --use_transformer_engine2 --cuda_graph_mode 'segmented' --use_cuda_graph "
export PHASE=2
export EVAL_ITER_START_SAMPLES=175000
export EVAL_ITER_SAMPLES=175000

## System run parms                                                                                                                                                                                                   
export DGXNNODES=2
export DGXSYSTEM="1CC"
export WALLTIME_MINUTES=4
if [[ "${MLPERF_POWER_TRAIN_AFTER_RUN_STOP:-0}" == "1" ]]; then
  export WALLTIME_MINUTES=$((${WALLTIME_MINUTES} + 15))  
  export SUSTAINED_TRAINING_TIME=11
fi
if [[ "${SET_MAXQ_CLK:-0}" == "1" ]] || [[ "${SET_MINEDP_CLK:-0}" == "1" ]]; then
  export WALLTIME_MINUTES=$((${WALLTIME_MINUTES} + 5))
  ## gpc frequency at maxQ and minEDP point
  export MAXQ_CLK=1515
  export MINEDP_CLK=1650
fi
export WALLTIME=$(( ${NEXP:-1} * ${WALLTIME_MINUTES} + 5 ))

## System config params                                                                                                                                                                                               
source $(dirname ${BASH_SOURCE[0]})/config_DGXH100_common.sh

export CONTAINER_PRELOAD_LUSTRE=0
export DATADIR_PHASE2=${DATADIR_PHASE2_PACKED}
