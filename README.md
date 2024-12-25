# 打包成容器

`docker build -t diff-schema-tool .`

# 使用方法

1. 在工具目录创建一个包含要数据库全量列表 [[mariadb_list]]

2. 执行比对脚本

#创建数据目录

`mkdir data`

#执行脚本

```
docker run --rm -it -v $(pwd)/data:/app/data -v $(pwd)/mariadb_list:/app/mariadb_list registry.digiwincloud.com.cn/bitnami/diff-schema-tool:1.01
```
