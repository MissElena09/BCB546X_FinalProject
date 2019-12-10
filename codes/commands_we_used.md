# Computational Commands
Due to the size of the genome files, they were stored in a folder on the ptmp directory of hpc-class.  To the best of our ability, we attempted to do as much of the computing using Unix commands in hpc-class as possible. 

We have noted when other programs are used.

## Setting up the workspace and load needed modules.
Using hpc-class, we were able to load the modules needed instead of having to download them.  If you are using a different shell, you may need to import these modules in a slightly different way.

```
$ module load sra-toolkit
```

```
$ module load blast-plus
```

## Downloading our data
To download our data, we used the fasterq-dump command from the SRA-Toolkit. 
`fasterq-dump` returns separate files for the forward and reverse reads.  For each subsequent step after this point, each step is performed on both the forward and reverse files.

```
$ fasterq-dump SRX746906 SRX747740 SRX747746
```
## Counting Reads
When attempting to count the number of reads for each file, we used two different commands that produced the same result.

### Grep Method:
The first command utilized the `grep` command in Unix.  Using the -c tag gives us a count of the lines containing the header for our sequences SRX.  The command shown below is used for the FASTQ file, the pattern grepped for was slightly modified for FASTA files.
```
$ grep -c ^"@SRX" <Path/and/FILENAME>.fastq
```

### Word Count Method:
The `wc -l` command can be used to simply count the number of lines in a file and then divide by the number of lines in the header.  
- A FASTQ file has 4 lines/read. Divide the `wc -l` output by 4 to get the amount of reads in each file.
- A FAStA file has 2 lines/read.  Divide the `wc -l` ouput by 2 to get the number of reads of a FASTA file.

``` 
$ wc -l <path/and/FILENAME>.fastq 
```

## Format change
Blast does not accept the FASTQ files as input so they must be converted to FASTA files.  We used the `sed` command to accomplish this task.  

```
$ sed -n '1~4s/^@/>/p;2~4p' <path/and/InputFILENAME>.fastq > <path/and/OutputFILENAME>.fasta
```

## Make Directories for each fastq file
To keep our directory clean, we made directories for each FASTQ file and additional files associated with it using the `mkdir` command.  This is not required, but can help keep things tidy.

```
$ mkdir <Path/to/NEWDIRECTORY>
```

## Move files to the created directories

```
$ mv <Path/and/FILENAME> <Path/to/NEWDIRECTORY/FILENAME>
```

## Running Blast Searches on FASTA files.
The authors of the paper ran three different BLAST searches on the resulting FASTA files.  
1. Blastn
2. Megablast
3. Discontiguous megablast

ref: [https://www.ncbi.nlm.nih.gov/books/NBK279680/]

### Make blast database
We discovered that in order to run the BLAST search, we first have to make a BLAST database.  This command can be used individually on each search or alternatively, the commands can be connected with an ampersand (&) to run each of the commands simultaneously.

Example of an individual command
```
$ makeblastdb -in <path/and/inputFILENAME>.fasta -dbtype nucl -parse_seqids 
``` 
Example of a series of commands connected with an ampersand.

```
$ makeblastdb -in <path/and/inputFILENAME_1>.fasta -dbtype nucl -parse_seqids & makeblastdb -in <Path/and/inputFILENAME_2>.fasta -dbtype nucl -parse_seqids

```
### BLAST

#### blastn
Below is the command for each type of Blast search.
We adjusted our blast command to include an output format that was tabular and set a maximum for the number of target sequences.  This is accomplished by adding the `-max_target_seqs` flag (we set our amount at 200,000 as an amount that was greater than the largest number of BLAST results.  If your BLAST search results are equal to the maximum target reads you set, you need to increase this number).
The tabular format of the BLAST search results can be achieved using the flag `-outfmt 6`.  We chose this format because it does not include the headers, the `7` output choice would include headers.  Not including headers made our ouput easier to parse.

#### Blast-n
Blast-n is optimized to search for sequences that are "somewhat similar" according to the NCBI website.

```
$ blastn -db <Path/and/DatabaseFILENAME>.fasta -query <Path/and/QueryFILENAME>.fasta -out <Path/and/Output>.out -max_target_seqs 200000 -outfmt 6
```

#### megablast
Megablast is optimized to search for sequences that are "highly similar" according to the NCBI website.

To choose the Megablast search type, append the flag `-task megablast` at the end of your blastn commmand.
```
$ blastn -db <Path/and/DatabaseFILENAME>.fasta -query <Path/and/QueryFILENAME>.fasta -out <Path/and/Output>.out -max_target_seqs 200000 -outfmt 6 - task megablast
```

#### discontiguous megablast
Discontiguous Megablast is optimized to search for sequences that are "more dissimilar" according to the NCBI website.
To choose the Discontiguous search type, append the flag `-task dc-megablast` at the end of your blastn command.
```
$ blastn -db <Path/and/DatabaseFILENAME>.fasta -query <Path/and/QueryFILENAME>.fasta -out <Path/and/Output>.out -max_target_seqs 200000 -outfmt 6 - task megablast -task dc-megablast
```

### Extracting unique reads
It was not specified that this was done in the original paper, however, we wanted to make sure that each read was only representing once even if it mapped to multiple locations in the viral genome.

#### Counting the unique reads
To accomplish this, we used the `cut` command to cut the second column from our tabular (.out) file piped to a `sort` and then piped to `uniq` commands and then performed a line count using `wc -l`.
 
 ```
 $ cut -f 2 <Path/and/outputFILENAME>.out | sort | uniq | wc -l
 ```
 
#### Extracting the unique reads that mapped to the viral genome using the `grep` command.
The authors of the paper did not specify whether they used FASTA or FASTQ format files in the assembly process using CodonCode Aligner.  The program is capable of using either as an input.  We chose to use FASTQ files because they contain quality information.

```
$ cut -f 2 <Path/and/outputFILENAME.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" <Path/and/FILENAME>.fastq >> <Path/and/UniqueReadsFILENAME>.fastq; done;
```
This command takes as input the unique read names from standard out and iterates through each line searching for that read line in the original FASTQ dataset.  It then writes this read to a separate FASTQ output file.

This command can take a fair amount of time because the grep command is searching through all 20 million reads in the original FASTQ file, and it is doing so for each of the 10,000 to 20,000 unique reads.  Therefore, we used a slurm script to run this command on the compute node of our HPC.  The slurm script used is included in the "Codes" folder of this repository.

### Next Steps:
The authors next step was to use the CodonCode aligner program that cannot be run on the UNIX command line.  See the CodonCode How to in this repository for steps on how we used this program.



