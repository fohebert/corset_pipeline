RAW_READS="02_raw_reads"
VECTORS="00_archive/univec_trimmomatic.fasta"
TRIMMED_FOLDER="03_trimmed"
TRIMMOMATIC_PROGRAM="/prg/trinityrnaseq/trinityrnaseq_r20140717/trinity-plugins/Trimmomatic-0.32/trimmomatic.jar"

# Filtering and trimming data with trimmomatic
java -Xmx160G -jar $TRIMMOMATIC_PROGRAM PE \
    -threads 10 \
    -phred33 \
    $RAW_READS/"$FILENAME".raw-reads.R1.fastq \
    $RAW_READS/"$FILENAME".raw-reads.R2.fastq \
    $RAW_READS/"$FILENAME".R1.trim.paired.fastq \
    $RAW_READS/"$FILENAME".R1.trim.single.fastq \
    $RAW_READS/"$FILENAME".R2.trim.paired.fastq \
    $RAW_READS/"$FILENAME".R2.trim.single.fastq \
    ILLUMINACLIP:$VECTORS:2:30:10 \
    SLIDINGWINDOW:20:2 \
    LEADING:2 \
    TRAILING:2 \
    MINLEN:60 \

# Places the output from Trimmomatic into the trimmed folder
mkdir $TRIMMED_FOLDER/single
mv $RAW_READS/*single* $TRIMMED_FOLDER/single
mv $RAW_READS/*paired* $TRIMMED_FOLDER
