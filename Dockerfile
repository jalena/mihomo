FROM alpine:latest

ENV CLASH_HOME=/etc/mihomo

# 创建目录
RUN mkdir -p $CLASH_HOME/ui

# 安装工具
RUN apk add --no-cache curl unzip

# 下载最新 Clash.Meta (mihomo)
RUN curl -L -o /usr/bin/mihomo \
    https://github.com/MetaCubeX/mihomo/releases/latest/download/mihomo-linux-amd64 && \
    chmod +x /usr/bin/mihomo

# 下载 MetaCubeX Dashboard（yacd-meta）
RUN curl -L -o /tmp/dashboard.zip \
    https://github.com/MetaCubeX/Yacd-meta/releases/latest/download/yacd-meta.zip && \
    unzip /tmp/dashboard.zip -d $CLASH_HOME/ui && \
    rm /tmp/dashboard.zip

# 暴露端口
EXPOSE 7890 7891 9090

WORKDIR $CLASH_HOME

ENTRYPOINT ["/usr/bin/mihomo", "-d", "/etc/mihomo"]
