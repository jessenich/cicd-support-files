ARG VARIANT=11
FROM debian:"$VARIANT"

ARG TZ= ;
ENV TZ=${TZ:-UTC}

RUN apt-get update && \
    apt-get install -y sudo

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN sudo apt-get update

WORKDIR /home/docker/scripts
COPY scripts ./

ARG SCRIPT="exit 0" \
    SHELL=/bin/bash \
    ENVIRONMENT=null \
    ASSERT_STDOUT_IS=null \
    ASSERT_STDERR_IS=null \
    ASSERT_EXIT_IS=0 \
    ASSERT_SUCCESS_SCRIPT="exit 0" \
    ASSERT_FAIL_SCRIPT="[ ("$?" != 0) ] && echo "Failure assertion raised for script: '$script'" ;


