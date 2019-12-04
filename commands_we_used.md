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
```
$grep -c ^"@SRX" \filename\
```

### Word Count Method

``` 
$wc -l \* filename \* 
```

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
```
$sed -n '1~4s/^@/>/p;2~4p' SRX746906_1.fastq > SRX746906_1/SRX746906_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX746906_2.fastq > SRX746906_2/SRX746906_2.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747740_1.fastq > SRX747740_1/SRX747740_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747740_2.fastq > SRX747740_2/SRX747740_2.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747746_1.fastq > SRX747746_1/SRX747746_1.fasta & sed -n '1~4s/^@/>/p;2~4p' SRX747746_2.fastq > SRX747746_2/SRX747746_2.fasta &
```


## Blast
1. Blastn
2. Megablast
3. Discontiguous megablast

ref: [https://www.ncbi.nlm.nih.gov/books/NBK279680/]

### Make blast database

```
$makeblastdb -in testOut.fasta -dbtype nucl -parse_seqids
```

#### In order to run this command on multiple folders simultaneously, you can run the commmands connected by an ampersand.

```
$makeblastdb -in SRX747746_1db/SRX747746_1.fasta -dbtype nucl -parse_seqids & makeblastdb -in SRX747746_2db/SRX747746_2.fasta -dbtype nucl -parse_seqids
``` 
#### adjusted our blast command to include an output format that was tabular and set a maximum for the number of target sequences.

```
$blastn -db SRX747746_1db/SRX747746_1.fasta -query NC_002598.1.fasta -out b_combined_pmv_1.out -max_target_seqs 200000 -outfmt 6
```

### blastn

### megablast
at the end of the command -task megablast

### discontinuous megablast
same but dc-megablast

```
$blastn –db SRX*_db[database_title]_[1,2].fasta –query NC_[query_title].fasta –out b_[mock,pmv,combined]_[pmv,spmv]_[1,2].out 

```
 
#### After running the blast, trying to figure out why we had more reads than they did in some cases: Used the following code to count the # of unique reads: sorted by the column of read location (column 2 in tabular file), then piped to an awk command to look at the uniq results in that column, then piped to a wc to count the # of lines in the file.
 
 ```
 $sort -k2 b_combined_pmv_1.out | awk '{A[$2]++}END{for(i in A)print i,A[i]}' | wc -l

 ```
#### Grepping out the reads that mapped to our reference genome:

* For FASTA file:

```
$cut -f 2 b_combined_pmv_1.out | sort | uniq | while read line; do grep -A1 -w “$line” SRX746906_1db/testOut.fasta >> b_combined_pmv.fasta; done;
```

* For FASTQ file:

```
$cut -f 2 b_pmv_pmv_1.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" SRX747740_1db/SRX747740_1.fastq >> b_pmv_pmv.fastq; done;
```
 
# Problems we've run into:
## Blast 
* Blast does not work on fastq files - fastq files need to be converted to fasta.  THere was no mention of this in the paper.
* In order to run Blast on fasta files, need to create a blast database.
* Adjusted our blast command to include an output format that was tabular and set a maximum for the number of target sequences.If not, the default max would be 250 sequences. 
* After running the blast, trying to figure out why we had more reads than they did in some cases: Used the following code to count the # of unique reads: sorted by the column of read location (column 2 in tabular file), then piped to an awk command to look at the uniq results in that column, then piped to a wc to count the # of lines in the file.
* No trimming, no filter by quality for fastq files. No quality control. Inconsistency in number of reads in the supplementary table S1 and number of reads in the paper.
* No mentioning about which blast result they used for the CodonCode Aligner, whether it is blastn, or megablast or dc-megablast


