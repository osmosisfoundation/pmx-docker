FROM rocker/verse:latest

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF
LABEL org.label-schema.name="osmosisfoundation/rocker" \
      org.label-schema.description="A full Rocker rstudio (rocker/verse) with NONMEM and PSN" \
      org.label-schema.url="http://osmosis.foundation" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/osmosisfoundation/pmx-docker" \
      org.label-schema.vendor="Osmosis Foundation" \
      org.label-schema.schema-version="1.0"

#
# lets add nonmem so we can run it from rocker gui
#
ARG NONMEM_MAJOR_VERSION=7
ARG NONMEM_MINOR_VERSION=4
ARG NONMEM_PATCH_VERSION=1
ARG NONMEM_ZIP_PASS_74

# Install gfortran, wget, and unzip (then clean up the image
# as much as possible)
RUN apt-get update \
    && apt-get install --yes --no-install-recommends \
       ca-certificates \
       gfortran \
       libmpich-dev \
       mpich \
       wget \
       unzip \
    && rm -rf /var/lib/apt/lists/ \
              /var/cache/apt/archives/ \
	      /usr/share/doc/ \
	      /usr/share/man/ \
	      /usr/share/locale/

## Install NONMEM and then clean out unnecessary files to shrink
## the image
RUN cd /tmp \
    && wget --no-verbose --no-check-certificate -O NONMEM.zip \
    https://nonmem.iconplc.com/nonmem${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION}${NONMEM_PATCH_VERSION}/NONMEM${NONMEM_MAJOR_VERSION}.${NONMEM_MINOR_VERSION}.${NONMEM_PATCH_VERSION}.zip \
    && unzip -P ${NONMEM_ZIP_PASS_74} NONMEM.zip \
    && cd /tmp/nm${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION}${NONMEM_PATCH_VERSION}CD \
    && bash SETUP${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION} \
                    /tmp/nm${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION}${NONMEM_PATCH_VERSION}CD \
       	            /opt/nm \
                    gfortran \
                    y \
                    /usr/bin/ar \
                    same \
                    rec \
                    q \
                    unzip \
                    nonmem${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION}e.zip \
                    nonmem${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION}r.zip \
    && rm -r /tmp/* \
    && rm /opt/nm/mpi/mpi_ling/libmpich.a \
    && ln -s /usr/lib/mpich/lib/libmpich.a /opt/nm/mpi/mpi_ling/libmpich.a \
    && (cd /opt/nm && \
        rm -rf \
            examples/ \
            guides/ \
            help/ \
            html/ \
            *.pdf \
            *.txt \
            *.zip \
            install* \
            nonmem.lic \
            SETUP* \
            unzip.SunOS \
            unzip.exe \
            mpi/mpi_lini \
            mpi/mpi_wing \
            mpi/mpi_wini \
            run/*.bat \
            run/*.EXE \
            run/*.LNK \
            run/CONTROL* \
            run/DATA* \
            run/REPORT* \
            run/fpiwin* \
            run/mpiwin* \
            run/FCON \
            run/FDATA \
            run/FREPORT \
            run/FSIZES \
            run/FSTREAM \
            run/FSUBS \
            run/INTER \
            run/computername.exe \
            run/garbage.out \
            run/gfortran.txt \
            run/nmhelp.exe \
            run/psexec.exe \
            runfiles/GAWK.EXE \
            runfiles/GREP.EXE \
            runfiles/computername.exe \
            runfiles/fpiwin* \
            runfiles/mpiwin* \
            runfiles/nmhelp.exe \
            runfiles/psexec.exe \
            util/*.bat \
            util/*~ \
            util/CONTROL* \
            util/F* \
            util/DATA3 \
            util/ERROR1 \
            util/INTER \
            util/finish_Darwin* \
            util/finish_Linux_f95 \
            util/finish_Linux_g95 \
            util/finish_SunOS*)

## Copy the current license file into the image
#COPY license/nonmem.lic /opt/nm730/license/nonmem.lic
# OR, use this VOLUME to mount your license dir at run time
# which we expect to have a nonmem.lic file in it.
# e.g. docker run -v license:/opt/nm730/license nonmem
VOLUME /opt/nm/license

ENV PATH /opt/nm/run:$PATH

# link nmfe to specific version so we can use a consistant ENTRYPOINT
RUN ln -s /opt/nm/run/nmfe${NONMEM_MAJOR_VERSION}${NONMEM_MINOR_VERSION} /opt/nm/run/nmfe

#
#
# done installing nonmem
#
#


#
#
# lets install psn on top of nonmem
#
#

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
    expect -ex \"NM-installation directory:\"; \
	send \"/opt/nm\r\"; \
	expect -ex \"add another one\"; \
	send \"n\r\"; \
	expect -ex \"name nm\"; \
	send \"\r\"; \
	expect -ex \"installation program.\"; \
	send \"\r\";" \
  && rm -rf /tmp/*

#
#
# done installing psn
#
#

WORKDIR /home/rstudio

CMD ["/init"]
