FROM ghcr.io/chenyme/grok2api:latest

# 1. 切换到 root 获取最高权限
USER root

# 2. 创建脚本强制要求检查的目录
RUN mkdir -p /run/grok2api

# 3. 将你的配置文件复制到脚本期望的路径下（满足第一步检查）
COPY config.yaml /run/grok2api/config.yaml

# 4. 核心修复：把 /app 目录和配置目录的权限全部放开（满足第二步 cp 复制和后续运行）
RUN chown -R 1000:1000 /app /run/grok2api && chmod -R 777 /app /run/grok2api

# 5. 切换回非 root 用户 (符合 Render 的安全策略)
USER 1000
