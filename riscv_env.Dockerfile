FROM ubuntu:18.04

# Install RISC-V Toolchain
ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH
WORKDIR $RISCV

RUN apt update
RUN apt install -y autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
RUN apt install -y git

RUN git clone --recursive https://github.com/riscv/riscv-gnu-toolchain

RUN cd riscv-gnu-toolchain && ./configure && make

# Install Chisel
RUN apt install -y default-jdk
RUN echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
RUN apt update
RUN apt install sbt

# Install Verilator
RUN apt install -y git make g++
RUN git clone http://git.veripool.org/git/verilator
RUN cd verilator && git pull && git checkout verilator_4_006
RUN cd verilator && autoconf && ./configure && make && make install
