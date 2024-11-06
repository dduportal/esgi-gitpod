FROM gitpod/workspace-node-23:2024-11-03-15-51-54

USER root

ARG HADOLINT_VERSION=v2.12.0
ARG HADOLINT_BIN=/usr/local/bin/hadolint

# Always uses latest package versions
# hadolint ignore=DL3008
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  cowsay \
  fortune \
  fortunes \
  shellcheck \
  sl \
  tree \
  && curl --silent --show-error --location \
  --output "${HADOLINT_BIN}" \
  "https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64" \
  && chmod a+x "${HADOLINT_BIN}" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  # Allow "funny" commands to be used from default PATH
  && for cli in /usr/games/*;do ln -s "$cli" /usr/local/bin/;done \
  && echo "PATH=/usr/games:\$PATH" >> /etc/environment \
  # Use "main" as default branch for new git repositories
  && git config --global init.defaultBranch main

USER gitpod
