# Assembly Pipeline from Illumina paired-end data
**NOTE**:
*This pipline uses raw read files to trim and assemble RNA-seq data, while correcting for redundancy in the dataset*

**VERSION**: v.0.1 <br>
**DATE**: 02-06-2015

##Disclaimer##
This pipeline works well for a specific type of data on a specific cluster at Laval University. You might have to
change certain lines of code in order to make it work, depending on the type of data and the name of the files.
The various steps presented in this pipeline were mainly taken from the CORESET github project page, you can find it 
[here](https://github.com/Oshlack/Corset/wiki/Example). <br>
Feel free to use it, distribute it, but most of all, HAVE FUN WITH IT :-)

## Overview ##
1) Read trimming; <br>
2) *De novo* assembly using Trinity; <br>
3) Mapping trimmed reads on the reference generated with Trinity; <br>
4) Use of CORSET to clusterize the transcript and correct for redundancy; <br>
5) Mapping read files from multiple individuals to the reference; <br>
5) Obtain gene expression levels (raw counts) and use of EdgeR for downstream analyses <br>
<br>

## Required Programs ##
* [TRIMMOMATIC] (http://www.usadellab.org/cms/?page=trimmomatic)
* [Trinity] (http://trinityrnaseq.github.io/)
* [Bowtie] (http://bowtie-bio.sourceforge.net/index.shtml)
* [CORSET] (https://github.com/Oshlack/Corset/wiki)
* [Samtools] (http://www.htslib.org/)<br>

## General Instructions Before Beginning ##
* Run all the scripts (i.e. job files) from the main directory
* Begin by placing your read files into the 02_raw_data directory
* The job files are formatted according to the KATAK cluster requirements from Laval University (IBIS), but you can edit them to fit any other cluster.<br>

# 1. Read Trimming #
**Description**: cleans up read files according to sequencing quality thresholds and trims off sequencing adaptors.<br>

**Procedure**<br>
* Script file for the job can edited using vim:<br>
`vi 01_scripts/01.trimming.sh`
<br><br>
This script will create one trimming script file for each library present in the directory 02_raw_data.<br>
Each library will be trimmed independently according to the parameters entered in the general script file (`01.trimming.sh`).<br>

* You can edit the job file to change the running time, RAM, number of CPUS:<br>
<br>`vi 01_scripts/jobs/01.trimming.job.template.sh`

* You are now ready to start the job:<br>
<br>`01_scripts/01.trimming.sh`

**NOTE**: usually, you should submit the jobs from the `01_scripts/jobs/` directory, but here, the script `01_scripts/01.trimming.sh` takes care of creating independent job files and submitting them to KATAK.<br>

# 2. *De novo* assembly with Trinity #
**Description**: takes the trimmed files, concatenates them (for better transcript detection) and assemble all the reads into transcripts.<br>

**Procedure**<br>
* Again, script file can be changed according to your needs and data:<br>
`vi 01_scripts/02.trinity.sh`
<br><br>
**note**: you might want to check for file name concordance in the script to make sure the job does not crash.

* Submit the task to KATAK:<br>
`qsub 01_scripts/jobs/02.trinity.jobs.sh`<br>

# 3. Map reads back to Trinity *de novo* reference #
**Description**: uses `bowtie` to multi-map the reads of each library back to the reference generated with Trinity.<br>
<br>
**Procedure**<br>
