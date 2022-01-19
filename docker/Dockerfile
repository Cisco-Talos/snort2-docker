FROM debian:buster-slim
ENV VERSION 2.9.19

RUN mkdir -p /root/pcaps/
COPY labs /root/
COPY tools /root/
WORKDIR /root/src/

RUN  apt-get update && \
  apt-get -y install \
  build-essential \
  vim \
  curl \
  gcc \
  flex \
  bison \
  pkg-config \
  libpcap0.8 \
  libpcap0.8-dev \
  libpcre3 \
  libpcre3-dev \
  libdumbnet1 \
  libdumbnet-dev \
  libdaq2 \
  libdaq-dev \
  zlib1g \
  zlib1g-dev \
  liblzma5 \
  liblzma-dev \
  luajit \
  libluajit-5.1-dev \
  libssl1.1 \
  libssl-dev \
  tcpreplay && \
  apt-get clean && \
  curl -L -O https://snort.org/downloads/snort/snort-$VERSION.tar.gz && \
  tar xf ./snort-$VERSION.tar.gz && \
  cd ./snort-$VERSION && \
  ./configure --enable-sourcefire --enable-open-appid && \
  make -j$(nproc) && \
  make install && \
  ldconfig && \
  cd /root && \
  rm -rf /root/src && \
  touch /root/pcaps/local.rules && \
  echo 'export TERM=xterm-256color' >> ~/.bashrc

# rule syntax file
COPY include/hog.vim /root/.vim/syntax/hog.vim
# colorscheme
COPY include/ir_black.vim /root/.vim/colors/ir_black.vim
# vimrc
COPY include/vimrc /root/.vimrc

CMD /bin/bash
