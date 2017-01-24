FROM ubuntu:16.04

# Build-time metadata as defined at http://label-schema.org
ARG VCS_REF
LABEL org.label-schema.name="osmosisfoundation/nonmem" \
      org.label-schema.description="NONMEM Installed in a Ubuntu Container" \
      org.label-schema.url="http://osmosis.foundation" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/osmosisfoundation/pmx-docker" \
      org.label-schema.vendor="Osmosis Foundation" \
      org.label-schema.schema-version="1.0"

ARG NONMEMURL=https://nonmem.iconplc.com/nonmem730/NONMEM7.3.0.zip
ARG NONMEMZIPPASS=gz952BqZX5

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
    && wget --no-verbose --no-check-certificate -O NONMEM7.3.0.zip ${NONMEMURL} \
    && unzip -P ${NONMEMZIPPASS} NONMEM7.3.0.zip \
    && cd /tmp/nm730CD \
    && bash SETUP73 /tmp/nm730CD \
       	            /opt/nm730 \
                    gfortran \
                    y \
                    /usr/bin/ar \
                    same \
                    rec \
                    q \
                    unzip \
                    nonmem73e.zip \
                    nonmem73r.zip \
    && rm -r /tmp/* \
    && rm /opt/nm730/mpi/mpi_ling/libmpich.a \
    && ln -s /usr/lib/mpich/lib/libmpich.a /opt/nm730/mpi/mpi_ling/libmpich.a \
    && (cd /opt/nm730 && \
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
VOLUME /opt/nm730/license

ENV PATH /opt/nm730/run:$PATH

# map in user data directory
VOLUME /data
WORKDIR /data

# expects in and out files specified at runtime
ENTRYPOINT ["/opt/nm730/run/nmfe73"]
CMD ["--help"]
