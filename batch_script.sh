#!/bin/bash

# 提示输入目标数据库连接信息
echo "把原始数据库更新成目标数据库的结构"
read -p "请输入原始数据库的连接串(root:password@127.0.0.1:3306):" db_dest_uri

read -p "请输入目标数据库的连接串(root:password@127.0.0.1:3306):" db_src_uri
echo

# 读取数据库列表
db_list_file="/app/mariadb_list"

# 检查数据库列表文件是否存在
if [ ! -f "$db_list_file" ]; then
  echo "数据库列表文件 $db_list_file 不存在"
  exit 1
fi

# 循环处理数据库列表中的每个数据库
while read db_name; do
  if [ -z "$db_name" ]; then
    continue
  fi
  
  # 比对数据库
  echo "正在导出数据库: $db_name"
  python2 diff_schema.py -d db -s $db_src_uri~$db_name -o /app/data/diff_$db_name.sql -t $db_dest_uri~$db_name
  if [ $? -ne 0 ]; then
    echo "导出数据库 $db_name 失败"
    continue
  fi

done < "$db_list_file"

echo "比对完成"

