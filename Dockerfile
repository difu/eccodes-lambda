FROM amazonlinux:2017.03

RUN yum -y install  \
    cmake \
    chrpath \
    gcc \
    git \
    jasper-devel \
    jasper-libs \
    openjpeg2-tools \
    openjpeg2-devel \ 
    openjpeg2 \
    python36 \
    python36-pip \
    python36-devel \
    wget \
    zip \
    && yum clean all

RUN python3.6 -m pip install numpy

WORKDIR /tmp

ENV ECCODES_URL=https://software.ecmwf.int/wiki/download/attachments/45757960 \
  ECCODES_VERSION=eccodes-2.10.0-Source
RUN cd /tmp && wget --output-document=${ECCODES_VERSION}.tar.gz ${ECCODES_URL}/${ECCODES_VERSION}.tar.gz?api=v2 && tar -zxvf ${ECCODES_VERSION}.tar.gz

RUN cd ${ECCODES_VERSION} && mkdir build && cd build && \
    cmake -DENABLE_FORTRAN=false -DPYTHON_LIBRARY_DIR=/usr/lib64/python3.6 -DPYTHON_INCLUDE_DIR=/usr/include/python3.6m -DPYTHON_EXECUTABLE=/usr/bin/python3  .. \
    && make -j2 && make install \
    && cd python3 && python3 setup.py install

WORKDIR /lambda_root

RUN cp -r /usr/local/lib64/python3.6/site-packages/eccodes /usr/local/lib64/python3.6/site-packages/numpy /usr/local/lib64/python3.6/site-packages/gribapi . && \
    mv /usr/local/lib/libeccodes.so gribapi/ && \
    chrpath -r '$ORIGIN' gribapi/_gribapi_swig.cpython-36m-x86_64-linux-gnu.so
COPY create_deployment.sh /usr/local/bin/
