FROM alpine

# The LABEL instruction adds metadata to an image
LABEL maintainer="madhank93"

# The RUN instruction will execute any commands in a new layer on top of the current image and commit the results
# apk is the package manager for alpine based images
# using that installing necessary packages
RUN apk --no-cache add \
    build-base\
    python3\
    nodejs \
    npm \
    ffmpeg \
    && npm install -g \
    npm@6.14.9 \
    # Clean up obsolete files:
    && rm -rf \
    /tmp/* \
    /root/.npm

# The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD 
# instructions that follow it in the Dockerfile.
WORKDIR /usr/lib/wdio

# The COPY instruction copies new files or directories from <src> and 
# adds them to the filesystem of the container at the path <dest>.
COPY package.json /usr/lib/wdio

COPY package-lock.json /usr/lib/wdio

# Installing all the dependecies present in the package.json file
RUN npm install \
    # Clean up obsolete files:
    && rm -rf \
    /tmp/* \
    /root/.npm

# Copying all the source code into the folder
COPY . /usr/lib/wdio

# An ENTRYPOINT allows you to configure a container that will run as an executable.
ENTRYPOINT [ "npm", "run" ]

# The main purpose of a CMD is to provide default commands to an executing container
CMD ["test"]
