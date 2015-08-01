# Armagetronad 0.2.9-sty+ct+ap Server

FROM	  debian:jessie

MAINTAINER	izissise <morisset.hugues@gmail.com>

EXPOSE 4534/udp

RUN apt-get update && apt-get install -y locales wget

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

ADD build/run.sh /

RUN chmod 755 run.sh

# Install Required Packages
RUN apt-get update
RUN apt-get -y --ignore-missing install build-essential automake libboost-dev libxml2-dev \
                bison pkg-config autoconf autotools-dev libprotobuf-dev sudo perl-base
RUN apt-get -y --no-install-recommends install bzr

# Create user
RUN useradd -d /home/armagetronad -m armagetronad

USER armagetronad
WORKDIR /home/armagetronad

RUN bzr branch lp:~armagetronad-ct/armagetronad/0.2.8-armagetronad-sty+ct
RUN mkdir -p "/home/armagetronad/armagetronad-build"

WORKDIR /home/armagetronad/0.2.8-armagetronad-sty+ct

RUN ./bootstrap.sh
RUN ./configure --prefix="/home/armagetronad/armagetronad-build" --disable-glout --enable-authentication \
     --disable-sysinstall --disable-useradd --disable-etc --disable-desktop --disable-uninstall

RUN make
RUN make install
RUN chmod 755 /home/armagetronad/armagetronad-build/bin

RUN rm -Rv /home/armagetronad/0.2.8-armagetronad-sty+ct/

WORKDIR /
USER root

ADD build/server /home/armagetronad/

RUN mv /home/armagetronad/armagetronad-build/bin /home/armagetronad/bin
RUN rm -rf /home/armagetronad/armagetronad-build
RUN chown armagetronad:armagetronad -R /home/armagetronad/

RUN apt-get remove -y --purge bzr build-essential automake bison pkg-config autoconf autotools-dev && apt-get -y autoremove

USER armagetronad

CMD ["./run.sh"]
