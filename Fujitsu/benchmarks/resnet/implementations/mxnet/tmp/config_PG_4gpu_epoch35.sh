export OMPI_MCA_btl="^openib" #To prevent deadlock between Horovd and NCCL at 96 nodes
export DALI_DONT_USE_MMAP=0 # 0 for /raid and 1 for lustre
export MXNET_EXTENDED_NORMCONV_SUPPORT=1 # supports Arch 80 NormConv fusion

## System config params
export DGXNGPU=4
export DGXNSOCKET=2
export DGXSOCKETCORES=64
export DGXHT=2  # HT is on is 2, HT off is 1
export HOROVOD_NUM_NCCL_STREAMS=1
export MXNET_HOROVOD_NUM_GROUPS=1
export HOROVOD_CYCLE_TIME=0.1
export MXNET_OPTIMIZER_AGGREGATION_SIZE=54
export MXNET_ENABLE_CUDA_GRAPHS=1

# MxNet PP BN Heuristic
export MXNET_CUDNN_NHWC_BN_HEURISTIC_FWD=1
export MXNET_CUDNN_NHWC_BN_HEURISTIC_BWD=1
export MXNET_CUDNN_NHWC_BN_ADD_HEURISTIC_BWD=1
export MXNET_CUDNN_NHWC_BN_ADD_HEURISTIC_FWD=1
## DL params
export OPTIMIZER="sgdwfastlars"
export BATCHSIZE="408"
export KVSTORE="horovod"
export LR="7.5"
export WARMUP_EPOCHS="2"
export EVAL_OFFSET="2" # Targeting epoch no. 35
export EVAL_PERIOD="4"
export WD="5.0e-05"
export MOM="0.9"
export LARSETA="0.001"
export LABELSMOOTHING="0.1"
export LRSCHED="pow2"
export NUMEPOCHS=${NUMEPOCHS:-"37"}

export NETWORK="resnet-v1b-stats-fl"
export MXNET_CUDNN_NHWC_BN_ADD_HEURISTIC_BWD=0
export MXNET_CUDNN_NHWC_BN_ADD_HEURISTIC_FWD=0

export DALI_THREADS="6"
export DALI_PREFETCH_QUEUE="5"
export DALI_NVJPEG_MEMPADDING="256"
export DALI_HW_DECODER_LOAD="0"
export DALI_CACHE_SIZE="0"
export DALI_ROI_DECODE="1"

#DALI buffer presizing hints
export DALI_PREALLOCATE_WIDTH="5980"
export DALI_PREALLOCATE_HEIGHT="6430"
export DALI_DECODER_BUFFER_HINT="1315942" #1196311*1.1
export DALI_CROP_BUFFER_HINT="165581" #150528*1.1
export DALI_TMP_BUFFER_HINT="355568328" #871491*batch_size
export DALI_NORMALIZE_BUFFER_HINT="441549" #401408*1.1

export HOROVOD_CYCLE_TIME=0.1
export HOROVOD_FUSION_THRESHOLD=67108864
export HOROVOD_NUM_NCCL_STREAMS=2
export MXNET_HOROVOD_NUM_GROUPS=1
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_FWD=999
export MXNET_EXEC_BULK_EXEC_MAX_NODE_TRAIN_BWD=999

## System run parms
export DGXNNODES=1
export DGXSYSTEM=$(basename $(readlink -f ${BASH_SOURCE[0]}) | sed 's/^config_//' | sed 's/\.sh$//' )
WALLTIME_MINUTES=40
export WALLTIME=$(( 5 + (${NEXP:-1} * ${WALLTIME_MINUTES}) ))
