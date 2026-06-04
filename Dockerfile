FROM pramonettivega/terra:0.1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /opt

RUN git clone https://github.com/radiant-systems-lab/Flinc.git \
    && cd Flinc \
    && git clone https://github.com/radiant-systems-lab/sciunit.git \
    && cd sciunit \
    && git fetch \
    && git checkout fix-sciunit-copy \
    && python -m pip install --no-cache-dir cmake==3.22.1 \
    && python -m pip install --no-cache-dir . \
    && cd .. \
    && git checkout nasa-demo \
    && bash ./install.sh /opt/conda/share/jupyter/kernels/python3
