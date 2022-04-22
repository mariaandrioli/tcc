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


LOGDIR=logs

if [ ! -d "$LOGDIR" ]
then
    mkdir ./$LOGDIR
fi

DATE=`date +%Y-%m-%d:%H:%M:%S`

RESULTSFILE="./$LOGDIR/teravalidate_results_$DATE"


OUTPUT=/user/root/terasort/${SIZE}-terasort-output
REPORT=/user/root/terasort/${SIZE}-terasort-report


# teravalidate.sh
# Kill any running MapReduce jobs
mapred job -list | grep job_ | awk ' { system("mapred job -kill " $1) } '
# Delete the output directory
hadoop fs -rm -r -f -skipTrash ${REPORT}
# Run teravalidate
/usr/bin/time -v hadoop jar $EXAMPLES_JAR teravalidate \
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
-D mapred.child.java.opts=-Xmx200m \
${OUTPUT} ${REPORT} #  >> $RESULTSFILE 2>&1

# -Ddfs.blocksize=256M \
# -Dio.file.buffer.size=131072 \
# -Dmapreduce.map.memory.mb=2048 \
# -Dmapreduce.map.java.opts=-Xmx1536m \
# -Dmapreduce.reduce.memory.mb=2048 \
# -Dmapreduce.reduce.java.opts=-Xmx1536m \
# -Dyarn.app.mapreduce.am.resource.mb=1024 \
# -Dyarn.app.mapreduce.am.command-opts=-Xmx768m \
# -Dmapreduce.task.io.sort.mb=1 \
# -Dmapred.map.tasks=185 \
# -Dmapred.reduce.tasks=185 \
