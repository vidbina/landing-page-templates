#!/bin/bash

# Install project-specific system dependencies
apt-get install -y --no-install-recommends \
  libx11-6 \
  libx11-xcb1 \
  libxcb1 \
  libxcb-dri3-0 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 \
  libdrm2 \
  libgbm1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  && return 0

# The return statement has been added to keep the diffs "clean" as additions
# can be made in a manner that flag the lines with the newly added, removed or
# modified packages without forcing the user to consider punctuation for line
# continuation for example.
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_02_01
