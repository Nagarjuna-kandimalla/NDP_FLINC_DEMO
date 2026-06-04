FROM pramonettivega/terra:0.1

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

WORKDIR /home/jovyan

RUN git clone https://github.com/radiant-systems-lab/Flinc.git

WORKDIR /home/jovyan/Flinc

RUN git clone https://github.com/radiant-systems-lab/sciunit.git

WORKDIR /home/jovyan/Flinc/sciunit

RUN git fetch \
    && git checkout fix-sciunit-copy

RUN python -m pip install --no-cache-dir cmake==3.22.1

RUN python -m pip install --no-cache-dir .

WORKDIR /home/jovyan/Flinc

RUN git checkout nasa-demo

# Some Sciunit flows initialize git state during install; set a neutral identity for CI builds.
RUN git config --global user.name "GitHub Actions" \
    && git config --global user.email "actions@github.local"

RUN bash ./install.sh /opt/conda/share/jupyter/kernels/python3
