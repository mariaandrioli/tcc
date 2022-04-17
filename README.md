# TCC

drive - https://drive.google.com/drive/u/0/folders/1FVNWz-JQEOrmAIplUb8TGjK4HyXyoinc

imagem usada - https://github.com/big-data-europe/docker-hadoop

sai do safe mode - hdfs dfsadmin -safemode leave

remover pasta output - hadoop fs -rm -r /user/root/output

tutoriais - 

https://shortcut.com/developer-how-to/how-to-set-up-a-hadoop-cluster-in-docker

https://www.section.io/engineering-education/set-up-containerize-and-test-a-single-hadoop-cluster-using-docker-and-docker-compose/

problema de conexão - https://stackoverflow.com/questions/61206599/connection-refused-error-when-registering-a-hdfs-based-snapshot-repository-for-e

RODANDO DOCKER E TESTES
- clonar repo da imagem
- na pasta do repo clonado, executar:  
`docker-compose up -d`
- depois, para verificar se os container estão rodando:  
`docker ps`
- http://localhost:9870 mostra o status do sistema
- para entrar no namenode:  
`docker exec -it namenode bash`
- pegar exemplo de map reduce do apache de https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapreduce-examples/3.3.2/
- executar `docker cp hadoop-mapreduce-examples-3.2.1-sources.jar namenode:/tmp/` para copiar o arquivo .jar para a pasta tmp
- `hadoop fs -rm -r /user/root/output` para remover pasta de saida
- `hadoop jar hadoop-mapreduce-examples-3.2.1-sources.jar org.apache.hadoop.examples.WordCount input output` na pasta tmp para executar o word count com os arquivos na pasta input
- `hdfs dfs -cat output/part-r-00000` para ver resultados
- `/tmp# hdfs dfs -ls output` ls na pasta output
- `docker-compose down` para matar o cluster

COMPUTADOR SPECS
 - Processador Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz   2.40 GHz
 - RAM GB
 - SSD Kingston A400, 480GB, SATA, Leitura 500MB/s, Gravação 450MB/s - SA400S37/480G
 - Windows 10 Home Single Language
 - WSL 2 - Ubuntu 20.04.4 LTS
 - Docker version 20.10.13
 - Hadoop version 3.2.1

Usando a imagem do hadoop para docker disponibilizada pelo BigDataEurope (REF), foi configurado um contêiner Docker de um cluster Hadoop com 3 datanodes (workers), um namenode HDFS (master), um gerenciador de recursos YARN, um servidor com histórico de operações e um gerenciador de nodos.

time hadoop jar hadoop-mapreduce-client-jobclient-3.2.1-tests.jar TestDFSIO -write -nrFiles 10 -fileSize 1000