## DL params
: "${ENABLE_DALI:=False}"
: "${USE_CUDA_GRAPH:=True}"
: "${CACHE_EVAL_IMAGES:=True}"
: "${EVAL_SEGM_NUMPROCS:=10}"
: "${EVAL_MASK_VIRTUAL_PASTE:=True}"
: "${INCLUDE_RPN_HEAD:=True}"
: "${PRECOMPUTE_RPN_CONSTANT_TENSORS:=True}"
: "${DATALOADER_NUM_WORKERS:=1}"
: "${HYBRID_LOADER:=True}"
: "${SOLVER_MAX_ITER:=40000}"
: "${BOTTLENECK:=SpatialBottleneckWithFixedBatchNorm}"
: "${CACHE_SCALE_BIAS:=True}"
: "${MLPERF_POWER_TRAIN_AFTER_RUN_STOP:=0}"

export BATCHSIZE=12
export EXTRA_PARAMS=""
export EXTRA_CONFIG='SOLVER.BASE_LR 0.08 SOLVER.WARMUP_FACTOR 0.000064 SOLVER.WARMUP_ITERS 1250 SOLVER.WARMUP_METHOD mlperf_linear SOLVER.STEPS (24000,32000) SOLVER.IMS_PER_BATCH 48 TEST.IMS_PER_BATCH 48 MODEL.RPN.FPN_POST_NMS_TOP_N_TRAIN 12000 MODEL.RPN.FPN_POST_NMS_TOP_N_PER_IMAGE False NHWC True'
export EXTRA_CONFIG="${EXTRA_CONFIG} SOLVER.MAX_ITER ${SOLVER_MAX_ITER} DATALOADER.DALI $ENABLE_DALI DATALOADER.DALI_ON_GPU $ENABLE_DALI DATALOADER.CACHE_EVAL_IMAGES $CACHE_EVAL_IMAGES EVAL_SEGM_NUMPROCS $EVAL_SEGM_NUMPROCS USE_CUDA_GRAPH $USE_CUDA_GRAPH EVAL_MASK_VIRTUAL_PASTE $EVAL_MASK_VIRTUAL_PASTE MODEL.BACKBONE.INCLUDE_RPN_HEAD $INCLUDE_RPN_HEAD DATALOADER.NUM_WORKERS $DATALOADER_NUM_WORKERS PRECOMPUTE_RPN_CONSTANT_TENSORS $PRECOMPUTE_RPN_CONSTANT_TENSORS DATALOADER.HYBRID $HYBRID_LOADER MODEL.RESNETS.FIRST_TRANS_FUNC $BOTTLENECK MODEL.RESNETS.TRANS_FUNC $BOTTLENECK MODEL.BACKBONE.DONT_RECOMPUTE_SCALE_AND_BIAS $CACHE_SCALE_BIAS"

## System run parms
export DGXNNODES=1
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME_MINUTES=45
 
#if [[ ${MLPERF_POWER_TRAIN_AFTER_RUN_STOP} -gt 0 ]]; then
#  export WALLTIME_MINUTES=$((${WALLTIME_MINUTES} + 15))  
#  export EXTRA_CONFIG="${EXTRA_CONFIG} SUSTAINED_TRAINING_TIME=10"
#fi
if [[ "${SET_MAXQ_CLK:-0}" == "1" ]] || [[ "${SET_MINEDP_CLK:-0}" == "1" ]]; then
  export WALLTIME_MINUTES=$((${WALLTIME_MINUTES} + 5))
  ## gpc frequency at maxQ and minEDP point
  export MAXQ_CLK=1275
  export MINEDP_CLK=1635
fi
#export WALLTIME=$(( ${NEXP:-1} * ${WALLTIME_MINUTES} + 5 ))



## System config params
export DGXNGPU=4
export DGXSOCKETCORES=96
export DGXNSOCKET=2
export DGXHT=2         # HT is on is 2, HT off is 1