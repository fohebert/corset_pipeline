# Assembly Pipeline from Illumina paired-end data
**NOTE**:
*This pipline uses raw read files to trim and assemble RNA-seq data, while correcting for redundancy in the dataset*

*** VERY IMPORTANT ***
Raw read files have to conform to a very specific name format, but you can change
the code so that it fits with whatever name your read files have.

*** USAGE ***
Use the scripts contained in the "01_scripts" directory. They are numbered, so start from 01.trimming.sh
and so on, until you've reached the end of the pipeline.

Input/Output files will be automatically taken from/added to the appropriate directory.
