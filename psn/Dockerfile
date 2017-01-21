FROM nonmem

# cpanm and PsN requirements
RUN apt-get update \
 && apt-get -y --no-install-recommends install ca-certificates \
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
	MooseX::Params::Validate

WORKDIR /tmp

# install PsN
RUN curl -SL http://downloads.sourceforge.net/project/psn/PsN-4.6.0.tar.gz -o PsN-4.6.0.tar.gz \
 && tar -zxf /tmp/PsN-4.6.0.tar.gz \
 && cd /tmp/PsN-Source \
 && expect -c "spawn perl setup.pl; \
	expect -ex \"/usr/bin]:\"; \
	send \"\r\"; \
	expect -ex \"/usr/bin/perl]:\"; \
	send \"\r\"; \
	expect -ex \"/usr/local/share/perl\"; \
	send \"\r\"; \
	expect -ex \"check Perl modules\"; \
	send \"y\r\"; \
	expect -ex \"are missing)\"; \
	send \"y\r\"; \
	expect -ex \"of your choice?\"; \
	send \"n\r\"; \
	expect -ex \"test library?\"; \
	send \"y\r\"; \
	expect -ex \"/usr/local/share/perl\"; \
	send \"\r\"; \
	expect -ex \"configuration file?\"; \
	send \"y\r\"; \
	expect -ex \"add another one\"; \
	send \"n\r\"; \
	expect -ex \"name nm730\"; \
	send \"\r\"; \
	expect -ex \"installation program.\"; \
	send \"\r\";" \
  && rm -rf /tmp/*
 
WORKDIR /data

ENTRYPOINT ["psn"]

CMD ["--help"]
