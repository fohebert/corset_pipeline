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
5) Obtain gene expression levels (raw counts) and use of EdgeR for downstream analyses <br>
<br>

## Required Programs ##
* [TRIMMOMATIC] (http://www.usadellab.org/cms/?page=trimmomatic)
* [Trinity] (http://trinityrnaseq.github.io/)
* [Bowtie] (http://bowtie-bio.sourceforge.net/index.shtml)
* [CORSET] (https://github.com/Oshlack/Corset/wiki)
* [Samtools] (http://www.htslib.org/)<br>
* [edgeR] (http://www.bioconductor.org/packages/release/bioc/html/edgeR.html)

## General Instructions Before Beginning ##
* Run all the scripts (i.e. job files) from the main directory
* Begin by placing ALL of your read files into the 02_raw_data directory
* Raw read files should have this naming system: **XXX.raw-reads.R1.fastq** & **XXX.raw-reads.R2.fastq** (paired-end data).
* The job files are formatted according to the KATAK cluster requirements from Laval University (IBIS), but you can edit them to fit any other cluster.<br>

## Important Notice ##
This pipeline describes how to obtain a reference transcriptome AND levels of expression for different treatments.<br><br>
To avoid allele spliting into different contigs during the assembly, it is recommended to use only 1 individual to produce the reference. However, if more than 1 developmental stage are sequenced (e.g. parasite with complex life-cycle), it is crucial to use 1 individual per developmental stage for the assembly in order to maximize transcript discovery.<br><br>
So in this pipeline, ALL read files should be placed into the `02_raw_data` directory and when the Trinity assembly step is reached, only the best library of each developmental stage should be given as the input for Trinity (this will be explained when it's time to deal with Trinity).<br>

# 1. Read Trimming #
**Description**: cleans up read files according to sequencing quality thresholds and trims off sequencing adaptors.<br>

**Procedure**<br>
* **VERY IMPORTANT**: place the read files that will be used for the assembly in `03_trimmed/sp_assembly/`. These files should be 1 individual per developmental stage or treatment. Trinity will only assemble the reads contained in this sub-directory.
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
**NOTE**: for a de novo reference transcriptome, it is recommended not to use too many libraries (i.e. individuals) because it has the potential to substantially increase the number of transcripts assembled (allele splitting into different contigs). As a consequence, it is better to use 1 library per developmental stage (or condition, depending on your study system), ideally the ones with the best sequencing depth.<br>

**Procedure**<br>
* Script file can be changed according to your needs and data:<br>
`vi 01_scripts/02.trinity.sh`
<br><br>
**note**: you might want to check for file name concordance in the script to make sure the job does not crash.

* Submit the task to KATAK:<br>
`qsub 01_scripts/jobs/02.trinity.jobs.sh`<br>

# 3. Map reads back to Trinity *de novo* reference #
**Description**: uses `bowtie` to multi-map the reads of each library back to the reference generated with Trinity.<br>
**NOTE**: it is crucial to MULTI-MAP the reads back to the reference, i.e. multiple alignments per read. Corset will use this information to perform the clusterization and regroup contigs with similar sequences and similar expression levels.

**Procedure**<br>
* Make sure everything is ok in the script file and the job file:<br>
`vi 01_scripts/jobs/03.mapping.job.sh`<br>
`vi 01_scripts/03.mapping.sh`<br>

* Job can then be submitted to KATAK:<br>
`qsub 01_scripts/jobs/03.mapping.sh`<br>

# 4. Use CORSET to clusterize the numerous contigs assembled with Trinity #
**Description**: CORSET will clusterize contigs according to their sequence similarity and expression levels. It will generate a cluster file, containing the information of the number of clusters and the contigs in each one of them.<br>

**Procedure**<br>
* Make sure everything is ok in the script file and the job file:<br>
`vi 01_scripts/jobs/04.corset.job.sh`<br>
`vi 01_scripts/04.corset.sh`<br>
<br>
**NOTE**: here, we create groups with the libraries that correspond to experimental treatments or developmental stages. Every library has a group identifier (in this case letters representing developmental stages of a parasite) and a number that designates the individual library. So each library can be identified and assigned to a treatment/dev. stage. That way, CORSET has more power when splitting differentially expressed paralogs (-g option in the script file). The name of each library given in the CORSET command line (names after -n option) will appear in the header of the count files.

* Job can then be submitted to KATAK:<br>
`qsub 01_scripts/jobs/04.corset.sh`<br>

# 5. Run edgeR #
**Description**: this step will allow the identification of gene-level expression counts. EdgeR will allow the identification of top differentially expressed clusters.<br>
