# TCC

drive - https://drive.google.com/drive/u/0/folders/1FVNWz-JQEOrmAIplUb8TGjK4HyXyoinc

imagem usada - https://github.com/big-data-europe/docker-hadoop

tutoriais -

https://shortcut.com/developer-how-to/how-to-set-up-a-hadoop-cluster-in-docker

https://www.section.io/engineering-education/set-up-containerize-and-test-a-single-hadoop-cluster-using-docker-and-docker-compose/

problema de conexão - https://stackoverflow.com/questions/61206599/connection-refused-error-when-registering-a-hdfs-based-snapshot-repository-for-e

RODANDO DOCKER E TESTES

```
cd docker-hadoop
docker-compose up -d
docker ps
docker cp hadoop-mapreduce-examples-3.2.1.jar namenode:/tmp/ \
| docker cp scripts/teragen.sh namenode:/tmp/ \
| docker cp scripts/terasort.sh namenode:/tmp/ \
| docker cp scripts/teravalidate.sh namenode:/tmp/ \
| docker cp scripts/start.sh namenode:/tmp/ \
| docker cp scripts/clean.sh namenode:/tmp/ \
| docker cp scripts/terasort_tuned.sh namenode:/tmp/

docker exec -it namenode bash
cd tmp
hdfs dfsadmin -safemode leave
apt-get update
apt-get install time
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-output/*
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-report/*

./teragen.sh
./terasort.sh
./teravalidate.sh

exit

docker-compose down
```

- http://localhost:9870 mostra o status do sistema
- http://localhost:8089 interface das aplicações

COMPUTADOR SPECS

- Processador 2,6 GHz 6-Core Intel Core i7
- 16 GB 2667 MHz DDR4
- Graphics:
  - AMD Radeon Pro 5300M 4 GB
  - Intel UHD Graphics 630 1536 MB
- macOS Monterey version 12.3.1
- Docker version 20.10.11
- Hadoop version 3.2.1

Hardware Overview:

Model Name: MacBook Pro
Model Identifier: MacBookPro16,1
Processor Name: 6-Core Intel Core i7
Processor Speed: 2,6 GHz
Number of Processors: 1
Total Number of Cores: 6
L2 Cache (per Core): 256 KB
L3 Cache: 12 MB
Hyper-Threading Technology: Enabled
Memory: 16 GB
System Firmware Version: 1731.100.130.0.0 (iBridge: 19.16.14243.0.0,0)
OS Loader Version: 540.100.7~23
Serial Number (system): C02G81NMMD6P
Hardware UUID: 77D05567-A77B-5AC4-9A41-0A81D8780197
Provisioning UDID: 77D05567-A77B-5AC4-9A41-0A81D8780197
Activation Lock Status: Disabled
