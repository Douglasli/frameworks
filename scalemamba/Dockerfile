FROM ubuntu:20.04

WORKDIR /root

# Install required packages
RUN apt-get update && apt-get install -y \
  build-essential \
  bzip2 \
  curl \
  doxygen \
  g++-8 \
  gcc-8 \
  git \
  libgmp3-dev \
  m4 \
  make \
  patch \
  python \
  vim \
  wget \
  yasm \
  zip

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8

ADD local/ /root/local
ADD install_dependencies.sh .
ADD bashrc .
RUN ["bash", "install_dependencies.sh"]
RUN cat bashrc >> /root/.bashrc
ADD config /root/.cargo/config

ADD source/ /root/source
ADD install.sh .
ADD SCALE-MAMBA/ /root/SCALE-MAMBA
RUN ["bash", "install.sh"]

# tmp for install rust
ADD install_rustup.sh .
RUN ["bash", "install_rustup.sh"]

ADD README.md .

ENV PATH ~/.cargo/bin/:${PATH}

CMD ["/bin/bash"]
