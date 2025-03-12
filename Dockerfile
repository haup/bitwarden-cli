FROM alpine:latest

ARG BW_CLI_VERSION

RUN apk add --no-cache wget unzip && \
    wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-sha256-${BW_CLI_VERSION}.txt -O bw.zip.sha256 && \
    wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-${BW_CLI_VERSION}.zip -O bw.zip && \
    echo "$(cat bw.zip.sha256)  bw.zip" | sha256sum -c - && \
    unzip bw.zip && \
    chmod +x bw && \
    mv bw /usr/local/bin/bw && \
    rm -rf bw.zip*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]