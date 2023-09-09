FROM gitpod/workspace-node:2023-08-30-14-07-38

USER root

# Always uses latest package versions
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    cowsay \
    fortune \
    fortunes \
    sl \
  && curl -sSL https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64 -o /usr/local/bin/hadolint \
  && chmod a+x /usr/local/bin/hadolint \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Allow "funny" commands to be used from default PATH
RUN for cli in /usr/games/*;do ln -s "$cli" /usr/local/bin/;done \
  && echo "PATH=/usr/games:\$PATH" >> /etc/environment

# Use "main" as default branch for new git repositories
RUN git config --global init.defaultBranch main

USER gitpod
