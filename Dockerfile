# 这里使用 Go 1.23.0 版本的 Alpine Linux 镜像
FROM golang:1.23.0-alpine AS builder

# 设置工作目录为 /app, 所有后续操作都会在这个目录下进行
WORKDIR /app

# 将当前项目目录的所有文件拷贝到容器的 /app 目录中
COPY . .

# 编译 Go 项目，生成可执行文件hello-gin
RUN export GIN_MODE=release && go build -o hello-gin

# 使用一个更小的基础镜像（Alpine）来运行应用程序
# Alpine 是一个极简的 Linux 发行版，适合部署阶段
FROM alpine:latest

# 安装 tzdata 包，确保支持时区的配置
RUN apk add --no-cache tzdata

# 设置工作目录为 /app
WORKDIR /app

# 从编译阶段的镜像中拷贝编译后的二进制文件到运行镜像中
COPY --from=builder /app/hello-gin /app/hello-gin

# 暴露容器的8888 端口，用于外部访问
EXPOSE 8888

# 设置容器启动时运行的命令
# 这里是运行编译好的可执行文件 hello-gin
CMD ["/app/hello-gin"]