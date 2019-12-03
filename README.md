# BCB546X_FinalProject

## *Panicum Mosaic Virus* and Its Satellites Acquire RNA Modifications Associated with Host-Mediated Antiviral Degradation

**Purpose:**
This assignment is the final project for BCB546X Fall 2019. 
The purpose is to create a well-documented pipeline of the chosen paper to understand the importance and difficulty of reproducing research.

**Description:**


### Pipeline

Download cluster: SRA toolkit download

Ref genomes for PMV & SPMV: Ref AccessonIDs: SRX746906; SRX747740; SRX747746.


|**What the Authors did:** |  **What We are going to do:**   |
|---|---|
| Sequenced Samples  |  Download Data |   |   |   |
|  Counted Reads | Count Reads  |   |   |   |
|  BLAST:
  Seq. Data = database
  Ref. Genome = queries | Download Ref. Genomes  |   
| Assembled into contigs with CodonCode Aligner
  (Contigs as query for megablast in NCBI)   | BLAST stuff  |
  | |Tabulate results & compare to Table S1|

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

**File transfer protocol:**
1. Download FileZilla on local desktop/computer. 
2. In the toolbars, select File->Site Manager
3. Creat new site
4. * Host:hpc-class.its.iastate.edu
   * Protocol: SFTP - SSH File Transfer Protocol
   * Type: Interactive
   * User: yourNetID
   * In AdvancedSetting, put /ptmp/zlozier as the remote directory. 
 Then Connect!
 
 Different hpc cluster might have different file transfer protocls. 
