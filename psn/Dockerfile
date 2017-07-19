FROM osmosisfoundation/nonmem:latest

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF
LABEL org.label-schema.name="osmosisfoundation/psn" \
      org.label-schema.description="Perl-speaks-NONMEM (PSN) and NONMEM Installed in a Ubuntu Container" \
      org.label-schema.url="http://osmosis.foundation" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/osmosisfoundation/pmx-docker" \
      org.label-schema.vendor="Osmosis Foundation" \
      org.label-schema.schema-version="1.0"

# cpanm and PsN requirements
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
		ca-certificates \
		gcc \
		build-essential \
		curl \
		expect \
    && rm -fr /var/lib/apt/lists/* \
    && wget -qO- \
	    https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | \
	    perl - --skip-satisfied App::cpanminus \
    && rm -r ~/.cpanm \
    && cpanm \
		Math::Random \
		Statistics::Distributions \
		Archive::Zip \
		File::Copy::Recursive \
		Storable \
		Moose \
		MooseX::Params::Validate \
		Test::Exception \
		YAML::Tiny

WORKDIR /tmp

# install PsN
RUN curl -SL https://github.com/UUPharmacometrics/PsN/releases/download/4.7.0/PsN-4.7.0.tar.gz -o PsN-4.7.0.tar.gz \
    && tar -zxf /tmp/PsN-4.7.0.tar.gz \
    && cd /tmp/PsN-Source \
    && expect -c "set timeout { 2 exit }; \
        spawn perl setup.pl; \
		expect -ex \"PsN Utilities installation directory \[/usr/local/bin\]:\"; \
		send \"\r\"; \
		expect -ex \"Path to perl binary used to run Utilities \[/usr/bin/perl\]:\"; \
		send \"\r\"; \
		expect -ex \"PsN Core and Toolkit installation directory \[/usr/local/share/perl\"; \
		send \"\r\"; \
		expect -ex \"Would you like this script to check Perl modules \[y/n\]?\"; \
		send \"y\r\"; \
		expect -ex \"Continue installing PsN (installing is possible even if modules are missing)\[y/n\]?\"; \
		send \"y\r\"; \
		expect -ex \"Would you like to copy the PsN documentation to a file system location of your choice?\"; \
		send \"n\r\"; \
		expect -ex \"Would you like to install the PsN test library?\"; \
		send \"y\r\"; \
		expect -ex \"PsN test library installation directory \[/usr/local/share/perl/\"; \
		send \"\r\"; \
		expect -ex \"Would you like help to create a configuration file?\"; \
		send \"y\r\"; \
        expect -ex \"Enter the *complete* path of the NM-installation directory:\"; \
        send \"/opt/nm/\r\"; \
		expect -ex \"Would you like to add another one\"; \
		send \"n\r\"; \
		expect -ex \"or press ENTER to use the name\"; \
		send \"nm\r\"; \
		expect -ex \"installation program.\"; \
		send \"\r\";" \
    && rm -rf /tmp/*

# default number of nonmem threads, based on your nonmem license
# this is written to a /root/psn.conf on startup using the docker-entrypoint.sh
# no need to change it here, you can change it in docker-compose.yml or at command line with -e
ENV NUM_THREADS=4

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR /data

CMD ["--help"]
