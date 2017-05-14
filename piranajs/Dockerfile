FROM osmosisfoundation/psn:latest

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF
LABEL org.label-schema.name="osmosisfoundation/piranajs" \
      org.label-schema.description="PiranaJS with NONMEM and PSN built-in" \
      org.label-schema.url="http://osmosis.foundation" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/osmosisfoundation/pmx-docker" \
      org.label-schema.vendor="Osmosis Foundation" \
      org.label-schema.schema-version="1.0"

# perl modules, take forever to build, do them first
RUN cpanm HTTP::Date \
     && cpanm DBI \
     && cpanm DBD::SQLite \
     && cpanm Text::Diff \
     && cpanm Text::Diff::HTML \
     && cpanm HTTP::Lite \
     && cpanm Image::Size \
     && cpanm JSON::XS \
     && cpanm XML::TreePP \
     && cpanm Text::Table

RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list \
    && gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9 \
    && gpg -a --export E084DAB9 | apt-key add - \
    && apt-get update && apt-get install -y \
		git \
        libpam0g-dev \
		r-base \
		python \
		sudo \
	&& rm -rf /var/lib/apt/lists/*

# node gpg keys
# gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    56730D5401028683275BD23C23EFEFE93C4CFFFE \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
  done

# install node LTS
ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 6.10.3

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# add Rstudio dependencies
RUN Rscript -e 'install.packages("ggplot2", repos="https://cran.rstudio.com")'

WORKDIR /opt/pirana

RUN git clone https://github.com/ronkeizer/apirana.git \
    && git clone https://github.com/ronkeizer/pirana_modules.git \
    && git clone https://github.com/ronkeizer/pirana_scripts.git \
    && /opt/pirana/apirana/apirana -set_pirana_dir=/opt/pirana \
    && ln -s /opt/pirana/apirana/apirana /usr/bin/apirana

# specify your source file at build time
ARG PIRANAJSSOURCE=piranajs_current_20170322.zip

COPY $PIRANAJSSOURCE /opt/pirana/piranajs_current.zip

RUN unzip piranajs_current.zip \
    && mv ronk* piranajs \
    && sed -i -e 's/\/opt\/pirana\/piranajs.lic/\/opt\/pirana\/license\/piranajs.lic/g' piranajs/piranajs.json

WORKDIR /opt/pirana/piranajs

# install app dependencies
RUN npm install

#default user to log into http://localhost:8000 with
RUN useradd -p piranajs piranajs -d /home/piranajs \
    && mkdir /home/piranajs \
    && chown piranajs:piranajs /home/piranajs \
    && addgroup piranajs staff

# be sure piranajs.lic is in the /license folder on host
VOLUME /opt/pirana/license

EXPOSE 8000

ENTRYPOINT ["node", "app"]
