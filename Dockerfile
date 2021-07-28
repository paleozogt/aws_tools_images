FROM paleozogt/debian:sid as base

RUN apt-get update && apt-get install -y \
        python3 \
        python3-pip \
 && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip

######################################################
FROM base as builder
RUN apt-get update && apt-get install -y \
        build-essential \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
        curl \
 && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN apt-get update && apt-get install -y \
        libffi-dev \
        libssl-dev \
 && rm -rf /var/lib/apt/lists/*

ARG GIMME_AWS_CREDS_VER=2.4.3
RUN . $HOME/.cargo/env \
 && mkdir wheels && cd wheels \
 && pip3 wheel gimme-aws-creds==$GIMME_AWS_CREDS_VER

######################################################
FROM base as gimme-aws-creds
ENTRYPOINT ["gimme-aws-creds"]

COPY --from=builder /wheels /wheels
RUN pip3 install /wheels/*.whl \
 && rm -rf /wheels

######################################################
FROM base as awscli
ARG AWSCLI_VER=1.20.9
RUN pip3 install awscli==$AWSCLI_VER
ENTRYPOINT ["aws"]

