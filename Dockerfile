FROM phusion/baseimage:latest
MAINTAINER skysider <skysider@163.com>

RUN apt-get -y update && \
    apt-get install -y wget && \
    echo 'deb http://download.opensuse.org/repositories/home:/pansenmann:/woboq/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/home:pansenmann:woboq.list && \
    wget -nv https://download.opensuse.org/repositories/home:pansenmann:woboq/xUbuntu_16.04/Release.key -O Release.key && \
    apt-key add - < Release.key && rm Release.key && \
    apt-get -y update && \
    apt-get install -y \
    gcc \
    make \
    texinfo \
    gettext \
    woboq-codebrowser \
    gawk \
    bison \
    git \
    apache2 && \
    rm -rf /var/lib/apt/list/*

COPY codebrowser.sh /root/

WORKDIR /root/

ENV GLIBC_VERSION 2.24

RUN git clone https://github.com/woboq/woboq_codebrowser.git && \
    chmod +x codebrowser.sh && \
    chmod +x woboq_codebrowser/scripts/fake_compiler.sh && \
    wget http://mirrors.ustc.edu.cn/gnu/libc/glibc-${GLIBC_VERSION}.tar.gz && \
    tar xf glibc-${GLIBC_VERSION}.tar.gz && \
    rm glibc-${GLIBC_VERSION}.tar.gz && \
    cd glibc-${GLIBC_VERSION} && \
    mv /root/codebrowser.sh . && \
    mkdir build && \
    cd build && \
    export COMPILATION_COMMANDS=/root/glibc-${GLIBC_VERSION}/compile_commands.json && \
    export FORWARD_COMPILER=gcc && \
    CC=/root/woboq_codebrowser/scripts/fake_compiler.sh CXX=/root/woboq_codebrowser/scripts/fake_compiler.sh ../configure --prefix=/glibc && \
    echo "[" > $COMPILATION_COMMANDS && \
    make -j1 && \
    echo " { \"directory\": \".\", \"command\": \"true\", \"file\": \"/dev/null\" } ]" >> $COMPILATION_COMMANDS && \
    cd ../ && ./codebrowser.sh && cd ../ && rm -rf glibc-${GLIBC_VERSION} && \
    mv /root/public_html /var/www/html/ && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
