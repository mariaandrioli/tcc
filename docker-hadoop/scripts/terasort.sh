#!/bin/bash

trap "" HUP

#if [ $EUID -eq 0 ]; then
#   echo "this script must not be run as root. su to hdfs user to run"
#   exit 1
#fi

EXAMPLES_JAR=hadoop-mapreduce-examples-3.2.1.jar


#SIZE=500G
#SIZE=100G
# SIZE=1T
# SIZE=1G
SIZE=10G
#INPUT=/${SIZE}-terasort-input
#OUTPUT=/${SIZE}-terasort-output


LOGDIR=logs

if [ ! -d "$LOGDIR" ]
then
    mkdir ./$LOGDIR
fi

DATE=`date +%Y-%m-%d:%H:%M:%S`

RESULTSFILE="./$LOGDIR/terasort_results_$DATE"


OUTPUT=/user/root/terasort/${SIZE}-terasort-output
INPUT=/user/root/terasort/${SIZE}-terasort-input

# terasort.sh
# Kill any running MapReduce jobs
mapred job -list | grep job_ | awk ' { system("mapred job -kill " $1) } '
# Delete the output directory
hadoop fs -rm -r -f -skipTrash ${OUTPUT}

# Run terasort
/usr/bin/time -v hadoop jar $EXAMPLES_JAR terasort \
-D mapreduce.map.log.level=INFO \
-D mapreduce.reduce.log.level=INFO \
-D yarn.app.mapreduce.am.log.level=INFO \
-D yarn.nodemanager.resource.detect-hardware-capabilities=true \
-D yarn.nodemanager.resource.memory-mb=-1 \
-D mapreduce.task.io.sort.mb=100 \
-D mapreduce.task.io.sort.factor=10 \
-D mapreduce.map.sort.spill.percent=0.80 \
-D mapreduce.map.combine.minspills=3 \
-D mapreduce.map.output.compress=false \
-D mapreduce.map.output.compress=org.apache.hadoop.io.compress.DefaultCodec \
-D mapreduce.shuffle.max.threads=0 \
-D mapreduce.reduce.shuffle.parallelcopies=5 \
-D mapreduce.reduce.shuffle.maxfetchfailures=10 \
-D mapreduce.reduce.shuffle.input.buffer.percent=0.70 \
-D mapreduce.reduce.shuffle.merge.percent=0.66 \
-D mapreduce.reduce.merge.inmem.threshold=1000 \
-D mapreduce.reduce.input.buffer.percent=0.0 \
-D dfs.blocksize=67108864 \
-D mapreduce.map.memory.mb=2048 \
-D mapreduce.reduce.memory.mb=4096 \
${INPUT} ${OUTPUT} #  >> $RESULTSFILE 2>&1

# -Dmapreduce.map.log.level=INFO \
# -Dmapreduce.reduce.log.level=INFO \
# -Dyarn.app.mapreduce.am.log.level=INFO \
# -Dio.file.buffer.size=131072 \
# -Dmapreduce.map.cpu.vcores=1 \
# -Dmapreduce.map.java.opts=-Xmx1536m \
# -Dmapreduce.map.maxattempts=1 \
# -Dmapreduce.map.memory.mb=2048 \
# -Dmapreduce.map.output.compress=true \
# -Dmapreduce.map.output.compress.codec=org.apache.hadoop.io.compress.Lz4Codec \
# -Dmapreduce.reduce.cpu.vcores=1 \
# -Dmapreduce.reduce.java.opts=-Xmx1536m \
# -Dmapreduce.reduce.maxattempts=1 \
# -Dmapreduce.reduce.memory.mb=2048 \
# -Dmapreduce.task.io.sort.factor=300 \
# -Dmapreduce.task.io.sort.mb=384 \
# -Dyarn.app.mapreduce.am.command.opts=-Xmx768m \
# -Dyarn.app.mapreduce.am.resource.mb=1024 \
# -Dmapred.reduce.tasks=92 \
# -Dmapreduce.terasort.output.replication=1 \
