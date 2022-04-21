#!/bin/bash

trap "" HUP

#if [ $EUID -eq 0 ]; then
#   echo "this script must not be run as root. su to hdfs user to run"
#   exit 1
#fi

EXAMPLES_JAR=hadoop-mapreduce-examples-3.2.1.jar


#SIZE=500G
#ROWS=5000000000

#SIZE=100G
#ROWS=1000000000

# SIZE=1T
# ROWS=10000000000

SIZE=10G
ROWS=100000000

# SIZE=1G
# ROWS=10000000


LOGDIR=logs

if [ ! -d "$LOGDIR" ]
then
    mkdir ./$LOGDIR
fi

DATE=`date +%Y-%m-%d:%H:%M:%S`

RESULTSFILE="./$LOGDIR/teragen_results_$DATE"

OUTPUT=/user/root/terasort/${SIZE}-terasort-input

# teragen.sh
# Kill any running MapReduce jobs
mapred job -list | grep job_ | awk ' { system("mapred job -kill " $1) } '
# Delete the output directory
hadoop fs -rm -r -f -skipTrash ${OUTPUT}

# Run teragen
/usr/bin/time -v hadoop jar $EXAMPLES_JAR teragen \
-Dmapreduce.map.log.level=INFO \
-Dmapreduce.reduce.log.level=INFO \
-Dyarn.app.mapreduce.am.log.level=INFO \
-Dmapreduce.task.io.sort.mb=100 \
-Dmapreduce.task.io.sort.factor=10 \
-Dmapreduce.map.sort.spill.percent=0.80 \
-Dmapreduce.map.combine.minspills=3 \
-Dmapreduce.map.output.compress=false \
-Dmapreduce.map.output.compress=org.apache.hadoop.io.compress.DefaultCodec \
-Dmapreduce.shuffle.max.threads=0 \
-Dmapreduce.reduce.shuffle.parallelcopies=5 \
-Dmapreduce.reduce.shuffle.maxfetchfailures=10 \
-Dmapreduce.reduce.shuffle.input.buffer.percent=0.70 \
-Dmapreduce.reduce.shuffle.merge.percent=0.66 \
-Dmapreduce.reduce.merge.inmem.threshold=1000 \
-Dmapreduce.reduce.input.buffer.percent=0.0 \
${ROWS} ${OUTPUT} # >> $RESULTSFILE 2>&1

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
# -Dyarn.app.mapreduce.am.command.opts=-Xmx768m \
# -Dyarn.app.mapreduce.am.resource.mb=1024 \
# -Dmapred.map.tasks=92 \


#-Dmapreduce.map.log.level=TRACE \
#-Dmapreduce.reduce.log.level=TRACE \
#-Dyarn.app.mapreqduce.am.log.level=TRACE \