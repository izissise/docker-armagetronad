# Armagetronad 0.2.9-sty+ct+ap Server
# Version 1040

FROM	  debian:jessie

MAINTAINER	izissise <morisset.hugues@gmail.com>

EXPOSE 4534/udp

RUN apt-get update && apt-get install -y locales wget

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

ENV LC_ALL C.UTF-8

ADD build/install.sh /
ADD build/srv.sh /
ADD build/run.sh /

RUN chmod 755 install.sh srv.sh run.sh
RUN ./install.sh

RUN rm -f /install.sh

ADD build/server /home/armagetronad/

RUN mv /home/armagetronad/armagetronad/bin /home/armagetronad/bin
RUN rm -rf /home/armagetronad/armagetronad
RUN chown armagetronad:armagetronad -R /home/armagetronad/

CMD ["./run.sh"]
