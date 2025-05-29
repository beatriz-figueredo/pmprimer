FROM ubuntu:25.10
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt install -y wget \
    build-essential libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev dnsutils
RUN wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz \
    && tar xzf Python-3.11.4.tgz \
    && cd Python-3.11.4 \
    && ./configure --enable-optimizations \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.11.4/
RUN apt-get update \
    && apt install -y apt-transport-https \
    && apt install -y python3-pip 
RUN wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.9.0/ncbi-blast-2.9.0+-x64-linux.tar.gz \
    && tar xvfz ncbi-blast-2.9.0+-x64-linux.tar.gz \
    && mv ncbi-blast-2.9.0+/bin/* /bin/ \
    && rm -rf ncbi-blast-2.9.0+/ \
    && rm *gz
RUN pip3 install PMPrimer --break-system-packages
WORKDIR /
ENTRYPOINT ["pmprimer"]