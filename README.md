# BCB546X_FinalProject

## *Panicum Mosaic Virus* and Its Satellites Acquire RNA Modifications Associated with Host-Mediated Antiviral Degradation

This assignment is the final project for BCB546X Fall 2019. 
The purpose is to create a well-documented pipeline of the chosen paper to understand the importance and difficulty of reproducing research.

### Pipeline

Download cluster: SRA toolkit download

Ref genomes for PMV & SPMV: Ref AccessonIDs: SRX746906; SRX747740; SRX747746.

What They Did:
* Sequenced Samples
* Counted Reads
* BLAST: 
  * Seq. Data = database
  * Reg. Genome = queries
* For reads that blast-ed to ref.genomes:
  * Assembled into contigs with CodonCode Aligner
  * Contigs as query for megablast in NCBI


Reproduce what they did:
* Download Data
* Count Reads
* Download Ref. Genomes
* BLAST stuff
* Tabulate results & compare to Table S1

