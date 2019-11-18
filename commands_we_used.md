# UNIX commands and tools we used to do stuff

## Setting up our workspace

```
module load sra-toolkit
module load blast-plus
module load entrez-tools-things
```

## Downloading our data

```
fasterq-dump SRX
fasterq-dump SRX
fasterq-dump SRX
```
## Counting Reads
```grep -c ^"@SRX" *filename*```

### Word Count Method

``` wc -l *filename* ```

A FASTQ file has 4 lines/read. Divide this number by 4 to get the amount of reads in each file. 
