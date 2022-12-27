FROM ubuntu:18.04

WORKDIR /home/

COPY . .

RUN bash ./setup.sh

ENV PATH="/root/.cargo/bin:$PATH"
ENV PATH="/root/.local/share/solana/install/active_release/bin:$PATH"

RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force \
    && avm install latest \
    && avm use latest

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# nvm environment variables
ENV NVM_DIR /usr/local/nvm

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh | bash

# install node, npm and yarn using nvm
RUN source $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && corepack enable \
    && corepack prepare yarn@stable --activate

# confirm installation
RUN node -v
RUN npm -v
RUN yarn -v

#setup solana cli
RUN solana-keygen new \
    && solana airdrop 2