# UNIX commands and tools we used to do stuff

## Setting up our workspace

```
module load sra-toolkit
module load blast-plus
```

## Downloading our data

```
fasterq-dump SRX
fasterq-dump SRX
fasterq-dump SRX
```
## Counting Reads

### Grep Method
```grep -c ^"@SRX" \filename\```

### Word Count Method

``` wc -l \* filename \* ```

A FASTQ file has 4 lines/read. Divide this number by 4 to get the amount of reads in each file. 

## Format change
from fastq to fasta, prepare for blast

```
$sed -n '1~4s/^@/>/p;2~4p' SRX746906_1.fastq >testOut.fasta
```
# Make Directories for each fastq file
mkdir filename.fastq

SRX746906_1
SRX747740_1 
SRX747746_1
SRX746906_2
SRX747740_2
SRX747746_2

# Convert from fastq to fasta and save to each new directory
sed -n '1~4s/^@/>/p;2~4p' SRX746906_1.fastq > SRX746906_1/SRX746906_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX746906_2.fastq > SRX746906_2/SRX746906_2.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747740_1.fastq > SRX747740_1/SRX747740_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747740_2.fastq > SRX747740_2/SRX747740_2.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747746_1.fastq > SRX747746_1/SRX747746_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747746_2.fastq > SRX747746_2/SRX747746_2.fasta &


## Blast
1. Blastn
2. Megablast
3. Discontiguous megablast

ref: [https://www.ncbi.nlm.nih.gov/books/NBK279680/]

### Make blast database

```
makeblastdb -in testOut.fasta -dbtype nucl -parse_seqids
```

### blastn

```
$blastn –db testOut.fasta –query NC_002598.1.fasta –out results.out 

# Problems we've run into:
## Blast 
Blast does not work on fastq - fastq files need to be converted to fasta.  THere was no mention of this in the paper.
In order to run Blast on fasta files, need to create a blast database.

```
