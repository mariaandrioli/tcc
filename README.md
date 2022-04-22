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
docker cp hadoop-mapreduce-examples-3.2.1-sources.jar namenode:/tmp/
docker cp scripts/teragen.sh namenode:/tmp/
docker cp scripts/terasort.sh namenode:/tmp/
docker cp scripts/teravalidate.sh namenode:/tmp/

docker exec -it namenode bash
hdfs dfsadmin -safemode leave
apt-get update
apt-get install time
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-output/*
hdfs dfs -rm -r -f /user/root/terasort/10G-terasort-report/*
exit

docker-compose down
```

- http://localhost:9870 mostra o status do sistema
- http://localhost:8089 interface das aplicações

COMPUTADOR SPECS
 - Processador Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz   2.40 GHz
 - RAM GB
 - SSD Kingston A400, 480GB, SATA, Leitura 500MB/s, Gravação 450MB/s - SA400S37/480G
 - Windows 10 Home Single Language
 - WSL 2 - Ubuntu 20.04.4 LTS
 - Docker version 20.10.13
 - Hadoop version 3.2.1