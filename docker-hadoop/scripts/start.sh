#!/bin/bash

hdfs dfsadmin -safemode leave &&
apt-get update &&
apt-get install time &&
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-output/* &&
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-report/*