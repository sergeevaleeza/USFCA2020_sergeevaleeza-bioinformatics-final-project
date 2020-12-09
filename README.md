# Title: Comparison of Texas COVID-19 Mortality Data To Other US States With High Populations and SARS-CoV-2 Sequencing Data

Author: Leeza Sergeeva  
Email: esergeeva@usfca.edu

# Summary

This project is designed to compare Texas COVID-19 mortality and increase in positive test results data to other US states with high overall mortality statistics. I'm also interested to see whether the high population density or just large population in general is related to high death numbers.

First part uses user input for any date to gain insight of situation in the United States during the COVID-19 pandemic. By providing an argument in the form of a date (YYYYMMDD), we can look at total death numbers, number of positive cases, and number of total hospitalizations up to the chosen date and compare those to Texas COVID-19 statistics. This data is also compared with the 2020 United States population density and the general time line of mortality increase and the amount on positive tests increase for the top 5 states with the highest number of deaths up to chosen date, including Texas. The states with the highest population have the highest number of deaths. 

Second part consists of variant analysis of SARS-CoV-2 sequencing data from Texas obtained from BioProject on NCBI website. This was an adaptation of the previous SARS-CoV-2 variant analysis. As predicted S and N genes have the highest number of SNPs variants in analyzed Texas samples possibly due to their larger size comparing to the other genes.

The report is generated through the use of MAKEFILE that brings together pipelines for analyzing and aligning the SARS-CoV-2 genome sequences and generates a Report.pdf file that shows project findings and graphs/tables.

# Methods

## COVID-19 data

The data is provided in real time using API from the [COVID Tracking Project](https://covidtracking.com/data/api) website. The following columns were selected for the visualization:
'date' column represents date as YYYYMMDD on which data was collected by The COVID Tracking Project. The earliest date that can be used is 20200122.
'state' column represents two-letter abbreviation for the state.
'death' column represents total fatalities with confirmed OR probable COVID-19 case diagnosis.
'deathIncrease' column represents daily increase in death, calculated from the previous day’s value.
'hospitalizedCumulative' column represents total number of individuals who have ever been hospitalized with COVID-19.
'hospitalizedIncrease' column represents daily increase in hospitalizedCumulative, calculated from the previous day’s value.
'positive' column represents total number of confirmed plus probable cases of COVID-19 
'positiveIncrease' column represents the daily increase positive cases (confirmed plus probable) calculated based on the previous day’s value.

## US Population Density Data
The US population density data was downloaded from this [website](https://worldpopulationreview.com/state-rankings/state-densities) as a .csv table. Using Excel the 'State' column was modified to match state's two letter codes.

## SARS-CoV-2 Sequences

On November 16, 2020 I downloaded "TX SARS-CoV-2 Sequencing" SraRunTable from BioProject on NCBI website related to SARS-CoV-2. Here are the links to "TX SARS-CoV-2 Sequencing" BioProject: "https://www.ncbi.nlm.nih.gov/bioproject/PRJNA639066".

Reference SARS-CoV-2 isolate Wuhan-Hu-1, complete genome sequence was downloaded on October 15, 2020 from NCBI website "https://www.ncbi.nlm.nih.gov/nuccore/NC_045512".

## Sequence data processing and filtering, from .fastq to .vcf files

Through series of executed shell scripts the .fastq files referenced in SraRunTables_tx.txt file were downloaded to external server provide by the University of San Francisco, as well as the SARS-CoV-2 reference genome file, the annotation gff for SARS-CoV-2. Then [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) program processed .fastq files downloaded to validate the quality of the high throughput sequencing data sets. Next step used [trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic) function to clean up sequencing data by throwing out bad sequences. With the help of [Burrows-Wheeler Alignment Tool](http://bio-bwa.sourceforge.net/bwa.shtml) reference genome was indexed, and the reads in each of the samples provided were aligned to the reference genome and saved as .sam files. Using [Samtools](https://www.htslib.org/), .sam files were converted to .bam files and sorted by leftmost coordinates. Then each sorted .bam file was processed by [Samtools flagstat](https://www.htslib.org/doc/samtools-flagstat.html) to count number of alignments in each FLAG type, like QC pass, QC fail etc. Using [bcftools mpileup](https://samtools.github.io/bcftools/bcftools.html) on sorted .bam files generate .bcf file that contains genotype likelihoods at each genomic position with coverage and then SNPs are called for each input file saving output of that as .vcf files and filtering out the short variants for the final VCF.  

See the set of tutorials on the [vcfR package website](https://knausb.github.io/vcfR_documentation/index.html).

Parts of this pipeline approach are based on the pipeline described in the [Data Carpentry Genomics lessons](https://datacarpentry.org/genomics-workshop/), which are made available under a [CC-BY 4.0 license](https://creativecommons.org/licenses/by/4.0/).
