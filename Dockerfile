FROM ethereum/solc:0.8.10-alpine as solc-0.8.2
FROM ethereum/solc:0.8.11-alpine as solc-0.8.3
FROM ethereum/solc:0.8.12-alpine as solc-0.8.4
FROM ethereum/solc:0.8.13-alpine as solc-0.8.5
FROM ethereum/solc:0.8.14-alpine as solc-0.8.6
FROM ethereum/solc:0.8.15-alpine as solc-0.8.7
FROM ethereum/solc:0.8.16-alpine as solc-0.8.8
FROM ethereum/solc:0.8.17-alpine as solc-0.8.9
FROM ethereum/solc:0.8.10-alpine as solc-0.8.10
FROM ethereum/solc:0.8.11-alpine as solc-0.8.11
FROM ethereum/solc:0.8.12-alpine as solc-0.8.12
FROM ethereum/solc:0.8.13-alpine as solc-0.8.13
FROM ethereum/solc:0.8.14-alpine as solc-0.8.14
FROM ethereum/solc:0.8.15-alpine as solc-0.8.15
FROM ethereum/solc:0.8.16-alpine as solc-0.8.16
FROM ethereum/solc:0.8.17-alpine as solc-0.8.17
FROM ethereum/solc:0.8.18-alpine as solc-0.8.18
FROM ethereum/solc:0.8.19-alpine as solc-0.8.19
FROM ethereum/solc:0.8.20-alpine as solc-0.8.20
FROM ethereum/solc:0.8.21-alpine as solc-0.8.21
FROM ethereum/solc:0.8.22-alpine as solc-0.8.22
FROM ethereum/solc:0.8.23-alpine as solc-0.8.23

FROM backpackapp/build:v0.30.0 as build

LABEL MAINTAINER='Joseph'

COPY --from=solc-0.8.2 /usr/local/bin/solc /root/.solcx/solc-v0.8.2
COPY --from=solc-0.8.3 /usr/local/bin/solc /root/.solcx/solc-v0.8.3
COPY --from=solc-0.8.4 /usr/local/bin/solc /root/.solcx/solc-v0.8.4
COPY --from=solc-0.8.5 /usr/local/bin/solc /root/.solcx/solc-v0.8.5
COPY --from=solc-0.8.6 /usr/local/bin/solc /root/.solcx/solc-v0.8.6
COPY --from=solc-0.8.7 /usr/local/bin/solc /root/.solcx/solc-v0.8.7
COPY --from=solc-0.8.8 /usr/local/bin/solc /root/.solcx/solc-v0.8.8
COPY --from=solc-0.8.9 /usr/local/bin/solc /root/.solcx/solc-v0.8.9
COPY --from=solc-0.8.10 /usr/local/bin/solc /root/.solcx/solc-v0.8.10
COPY --from=solc-0.8.11 /usr/local/bin/solc /root/.solcx/solc-v0.8.11
COPY --from=solc-0.8.12 /usr/local/bin/solc /root/.solcx/solc-v0.8.12
COPY --from=solc-0.8.13 /usr/local/bin/solc /root/.solcx/solc-v0.8.13
COPY --from=solc-0.8.14 /usr/local/bin/solc /root/.solcx/solc-v0.8.14
COPY --from=solc-0.8.15 /usr/local/bin/solc /root/.solcx/solc-v0.8.15
COPY --from=solc-0.8.16 /usr/local/bin/solc /root/.solcx/solc-v0.8.16
COPY --from=solc-0.8.17 /usr/local/bin/solc /root/.solcx/solc-v0.8.17
COPY --from=solc-0.8.18 /usr/local/bin/solc /root/.solcx/solc-v0.8.18
COPY --from=solc-0.8.19 /usr/local/bin/solc /root/.solcx/solc-v0.8.19
COPY --from=solc-0.8.20 /usr/local/bin/solc /root/.solcx/solc-v0.8.20
COPY --from=solc-0.8.21 /usr/local/bin/solc /root/.solcx/solc-v0.8.21
COPY --from=solc-0.8.22 /usr/local/bin/solc /root/.solcx/solc-v0.8.22
COPY --from=solc-0.8.23 /usr/local/bin/solc /root/.solcx/solc-v0.8.23

# Solana Development Environment

RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN avm install 0.25.0
RUN avm install 0.26.0
RUN avm install 0.27.0
RUN avm install 0.28.0
RUN avm install 0.29.0
RUN avm install latest
RUN avm use latest

# Install Python3.10 Environment
RUN apt update
RUN apt install software-properties-common -y

RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt update

RUN apt install python3.10 python3.10-venv python3.10-dev -y

# Install pip
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

RUN python3 -m venv /py && \
    /py/bin/pip install --upgrade pip

ENV PATH="/py/bin:/usr/:$PATH"

RUN npm install -g ganache solc
