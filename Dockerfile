# based on https://github.com/pytorch/pytorch/blob/master/Dockerfile
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        ca-certificates \
        libjpeg-dev \
        imagemagick \
        nano \
        net-tools \
        rtorrent \         
        unzip \
        p7zip-full \
        wget \
        libpng-dev \
        python-software-properties \
        software-properties-common \        
        && rm -rf /var/lib/apt/lists/*

# RUN add-apt-repository ppa:x2go/stable \
#     && apt-get update \
#     && apt-get install -y --no-install-recommends \
#     x2goserver x2goserver-xsession \
#     && rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get install -y --no-install-recommends ubuntu-desktop \
#    xrdp tightvncserver

ENV PATH /opt/conda/bin:$PATH

RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && conda update -n base conda \
    && conda create -n torch python=3.6 anaconda \    
    && PATH=/opt/conda/bin:$PATH

RUN conda install pytorch torchvision cuda80 -c soumith

RUN pip install \
    bcolz \
    jupyter \
    kaggle-cli \
    keras==1.2.2 \
    matplotlib\
    numpy \
    pillow \
    pandas \
    scikit-learn \
    scikit-image \
    scipy \
    sympy \
    theano \
    h5py \
    python-interface \
    tensorflow-gpu

WORKDIR /
COPY . /
RUN chmod 775 /usr/bin/runjn

WORKDIR /workspace
RUN chmod -R a+w /workspace

EXPOSE 8000 8080 8888 5901
