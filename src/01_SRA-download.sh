################################################################################
#                             Downloading SRA files                            #
################################################################################
# This scripts uses command-line /bash sripting
# make sure you have the needed tools installed if you want to use this script
#   in the future for your own work.

# to download an SRA file that includes the raw reads, you'll need to use the
#   SRAToolKit [STEP 2]. You can skip STEP 2, and just download the files 
#   uploaded to the folder section in thios workshop.



#### STEP 1
# build your directory that will include all files and results
mkdir -p GSE179379
# the next line moves you inside this created directory
cd GSE179379
# this next line creates these separate folders inside your project directory
mkdir -p data/raw data/derivatives src figs logs doc archive


#### STEP 2
# download your sequncing files
# This command downloads all SRA files, and transforms them to fastq in PARALLEL
#   PARALLEL means you can run the same command on several files that are 
#   independent from each other. 
# it requires SRAToolKit and ncbi-entrez-direct to be installed
# you change the value given to the query parameter to the SRA project accession
# you change the number after the P parameter to the number of cores you want to use
# This command will take a long time depending on how many samples you have, 
#   and how big their reads files.
esearch -db sra \
    -query PRJNA743513  | efetch \
    -format runinfo | cut -d ',' \
    -f 1 | grep SRR | xargs -n 1 \
    -P 20 fastq-dump --split-files \
    --gzip --skip-technical


