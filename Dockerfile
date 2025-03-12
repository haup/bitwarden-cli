FROM alpine:latest

ARG BW_CLI_VERSION
ARG TARGETPLATFORM

# Install based on architecture
RUN ARCH=$(echo $TARGETPLATFORM | cut -d '/' -f2) && \
    if [ "$ARCH" = "amd64" ]; then \
        apk add --no-cache wget unzip && \
        wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-sha256-${BW_CLI_VERSION}.txt --no-verbose -O bw.zip.sha256 && \
        wget https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}/bw-oss-linux-${BW_CLI_VERSION}.zip --no-verbose -O bw.zip && \
        echo "$(cat bw.zip.sha256) bw.zip" | sha256sum --check - && \
        unzip bw.zip && \
        chmod +x bw && \
        mv bw /usr/local/bin/bw && \
        rm -rfv bw.zip*; \
    else \
        apk add --no-cache nodejs npm && \
        npm install -g @bitwarden/cli && \
        ln -s /usr/local/bin/bw /usr/bin/bw; \
    fi

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]