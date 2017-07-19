#!/bin/bash

# run a temporary Docker container to execute nonmem jobs against files in data subdir
###################################
# two optional param (input and data file should be in data/ sub directory)
# nmrun.sh input-file output-file
# CONTROL CONTROL.res

# TODO check for control and data files and error if missing
# TODO fail if no input file is listed in command, don't use default

INPUT=${1:-CONTROL}
OUTPUT=${2:-"$INPUT".res}
echo using input file \"$INPUT\" and output file \"$OUTPUT\"

# create new data dir
DATADIR=../data/${INPUT}_dir
n=1
while [[ -d $DATADIR$n ]]
do
    n=$((n+1))
done
DATADIR=$DATADIR$n
mkdir $DATADIR
echo "******   Data will be stored in $DATADIR   ******"

# find what our data file is in the control file and copy in both files
# someday make this a single awk command
DATAFILE=$(cat data/$INPUT | grep -m 1 '$DATA' | sed 's/$DATA//g' | sed 's/ //g' | tr -d '\r\n')
echo using datafile \"$DATAFILE\"
cp -f ../data/$INPUT ../data/$DATAFILE $DATADIR

# start container, which will auto remove once command is complete
# TODO check for existence of license file
docker run --rm -v $(pwd)/license:/opt/nm/license -v $(pwd)/$DATADIR:/data osmosisfoundation/nonmem:latest $INPUT $OUTPUT

# cleanup
# TODO if --clean given, delete, otherwise move to subfolder
rm -rf ../data/c-temp && mkdir ../data/c-temp && mv $DATADIR/$INPUT* $DATADIR/$DATAFILE ../data/c-temp/ && rm -rf $DATADIR && mv data/c-temp $DATADIR
echo "******   Data is stored in $DATADIR   ******"
ls $DATADIR

