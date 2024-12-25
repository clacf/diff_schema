# 使用官方的 Python 2 基础镜像
FROM python:2.7-slim

# 设置工作目录
WORKDIR /app

# 安装必要工具（包括 git 和 curl）
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# 克隆 diff_schema 仓库
RUN git clone https://github.com/zeonto/diff_schema.git

RUN mkdir -p /app/data

# 切换到 diff_schema 目录
WORKDIR /app/diff_schema

# 复制启动脚本到 diff_schema 目录
COPY batch_script.sh .

# 安装 pip 和所需的 Python 包
RUN pip install mysql-connector==2.2.9

# 确保脚本有执行权限
RUN chmod +x batch_script.sh

# 暴露必要的端口（如果需要）
# EXPOSE 3306

# 运行启动脚本
CMD ["./batch_script.sh"]

