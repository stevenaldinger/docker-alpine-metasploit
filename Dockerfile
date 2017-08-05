FROM alpine:3.6

ENV \
 RUBY_VERSION=3.4.1 \
 HOME=/metasploit-framework \
 NPROC=4

COPY entrypoint.sh /usr/bin/container_entrypoint

RUN chmod a+x /usr/bin/container_entrypoint \
 && adduser -h /metasploit-framework -g sudo -D metasploit -u 1001 \
 && apk upgrade --update && apk add --update --no-cache \
            # general tools
            bash \
            curl \
            git \
            libcurl \
            libpcap \
            # ruby
            ruby \
            ruby-bundler \
            ruby-dev \
 && echo 'gem: --no-ri --no-rdoc' > /etc/gemrc \
 && apk upgrade --update && apk add --update --no-cache --virtual build-deps \
            alpine-sdk \
            autoconf \
            bison \
            bzip2 \
            bzip2-dev \
            ca-certificates \
            coreutils \
            dpkg-dev dpkg \
            gcc \
            gdbm-dev \
            glib-dev \
            libc-dev \
            libffi-dev \
            libpcap-dev \
            libpq \
            libxml2-dev \
            libxslt-dev \
            linux-headers \
            make \
            ncurses-dev \
            openssl \
            postgresql-dev \
            procps \
            readline-dev \
            ruby \
            sqlite-dev \
            tar \
            xz \
            yaml-dev \
            zlib-dev \
 && git clone https://github.com/rapid7/metasploit-framework.git \
 && chown -R metasploit:metasploit /metasploit-framework \
 && ln -sf /metasploit-framework/msfconsole /usr/bin/msfconsole \
 && ln -sf /metasploit-framework/msfd /usr/bin/msfd \
 && ln -sf /metasploit-framework/msfrpc /usr/bin/msfrpc \
 && ln -sf /metasploit-framework/msfrpcd /usr/bin/msfrpcd \
 && ln -sf /metasploit-framework/msfupdate /usr/bin/msfupdate \
 && ln -sf /metasploit-framework/msfvenom /usr/bin/msfvenom \
 && cd /metasploit-framework && bundle install \
 && chown -R metasploit:metasploit /metasploit-framework/.bundle/ \
 && apk del build-deps && rm -rf /var/cache/apk/*

WORKDIR /metasploit-framework

USER metasploit

ENTRYPOINT container_entrypoint
