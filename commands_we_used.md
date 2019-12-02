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
```
