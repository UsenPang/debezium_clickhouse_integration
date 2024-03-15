# debezium_clickhouse_integration
这个项目创建了一个实时数据流通道，使用了debezium连接器，并且新增了一个[clickhouse-sink-connect](https://github.com/Altinity/clickhouse-sink-connector) 连接器，实习数据实时同步到clickhouse中。其中使用redpanda-console作为kafka的UI，可以在console中查看kafka的topic信息、schemaregistry信息，以及查看connect的状态并创建connect实例。


# Getting Started
本项目只提供了sql server、postgres、clickhouse连接器的案例，如果想使用其他连接器需自行配置。
## Start Containers
```
cd debezium_clickhouse_integration
docker compose up
```
## Registry Connect Instance
```
cd script
```
### Create Postgres Connect Instance
你需要创建一个配置文件或者修改现有的xxx-config.sh文件,一个sql server的配置文件如下:
```
# Postgres config
SOURCE_CONNECTOR_NAME="postgres-source-connector"
POSTGRES_HOST="192.168.25.134"
POSTGRES_PORT=5432
POSTGRES_USER="odoo"
POSTGRES_PASSWORD="root"
DATABASE_DBNAME="odoo"
TOPIC_PREFIX="postgres"
TABLE_INCLUDE_LIST=""
```
这个配置很简单，就不过多讲解了。
使用postgres-source-register.sh注册连接器实例
```
./postgres-source-register.sh postgres-config-odoo.sh
```
注意：postgres-config-odoo.sh是上面提到的配置文件
如需注册Sql Server 连接器实例同理。
### Use Console Create Connect Instance
更简便的方法是在redpanda-console界面注册连接器。
![image](https://github.com/UsenPang/debezium_clickhouse_integration/assets/87891272/4fbfeebf-2156-418e-9d08-0cb30d7bd5fe)


