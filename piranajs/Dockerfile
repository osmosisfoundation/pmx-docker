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
		nodejs \
		npm \
		r-base \
		python \
		sudo \
	&& rm -rf /var/lib/apt/lists/* \
    && ln -s `which nodejs` /usr/local/bin/node \
    && Rscript -e 'install.packages("ggplot2", repos="https://cran.rstudio.com")'

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
