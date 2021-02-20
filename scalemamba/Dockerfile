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

ADD install_dependencies.sh .
RUN ["bash", "install_dependencies.sh"]

ADD bashrc .
RUN cat bashrc >> /root/.bashrc

ADD source/ /root/source
ADD install.sh .
RUN ["bash", "install.sh"]

ADD README.md .

ENV PATH ~/.cargo/bin/:${PATH}

CMD ["/bin/bash"]
