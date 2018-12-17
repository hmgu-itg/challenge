# ITG Challenge

## Description/Instructions

Please find below a few questions that mimic some common problems we encounter at ITG. They are grouped by broad theme. You will notice there are many questions, the goal is not to answer them all but to pick a few questions to focus on (10 is a good number, but pick as many as you want). They can be all from one theme, or span all disciplines. We encourage you to choose your questions wisely: if you are a Python expert, avoid R questions, for example. Or if you are strong in genetics but not in systems maintenance, the last category will be your best bet.

For programmatic questions, you can use the language and libraries of your choice. If you use a shell script, you can assume that common non-core packages will be installed (e.g. `awk`, `sed`, `perl`, `python`, `sponge`, `wget` or `jq`). You can use the shell of your choice, if not otherwise specified we will assume `bash`. Assume that all common bioinformatics tools `bcftools`, `bedtools`, `vcftools`, `plink` and others are all installed.

We are primarily interested in how you would solve these problems if you encountered them in real life. Whenever the command line or programming is used, please include your code along with your answer. Not all questions are programmatic, and some are open-ended. Feel free to include details and to discuss potential issues if you don't think there is a clear-cut answer.

To submit your results, please clone this repository and make your edits. Once you're done, send us a link to your repository, or compress it and send us a link to the archive.

## Questions

### Support/resource management/Shell
1. A user has several versions of R installed in their path. Each version of R has a number of locally installed libraries. The user is confused, and would like to know which library is installed for which version of R. Can you write a command to help them out?
2. A common problem with shared filesystems is a disk quota overflow. This can be due to 1) a large combined size on disk or 2) too many files present on disk. We would like to help users who encounter this problem to locate the problematic files/directories. Write a command to sort all subdirectories of level `n` (`n` determined by the user) by their human-readable size. Write another command to sort all subdirectories of level `n` according to the number of files they contain.
3. A user wants to install an `R` package and gets the following [error log](data/error.log). What is likely to cause the error and how can they solve it?
4. A user is running commands like this one `cat file1 <(cut -d " " -f 1-15,17,18 file2) > file3`. What does this command do? It runs fine on the command line, but then the user includes it into a file with other commands, saves it and runs `chmod +x` on it. However, that line of code throws the following error : `syntax error near unexpected token '('`. What has the user forgotten?
5. A collaborator has sent you [this script](data/EasyQCWrapper.sh). It is a wrapper for a bioinformatics software called `EasyQC`.  Running it, you get the following error: 

    ```bash
    ./test.EasyQC-START.R: line 6: syntax error near unexpected token 'EasyQC'
    ./test.EasyQC-START.R: line 6: 'library(EasyQC)'
    ```

     You need to run this script now, but your collaborator is unavailable for a few days. What is causing the error? (Hint: Nothing is wrong with the `.ecf` EasyQC script.)
6. Programmatic download
    - You have to download all autosomal files from this location: [http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions/](http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions/) onto **your server**. You connect to the server via SSH. Using only the command line, how do you perform this download?
    - You are at a conference abroad and you quickly realise that your connection is unstable. You get disconnected constantly, which interrupts the download. How do you ensure the download survives these disconnections?
7. Bioinformaticians often work on a computing cluster. The cluster runs a software called a job scheduler that attributes resources to users depending on the requirements of their jobs. In this case, let's imagine the cluster is running IBM LSF. You do not need to know it to answer this question. The `bjobs` command lists all jobs submitted by the user (manpage [here](https://www.ibm.com/support/knowledgecenter/en/SSETD4_9.1.2/lsf_command_ref/bjobs.1.html)). It gives this kind of output:
    ```
    JOBID   USER             STAT  QUEUE      FROM_HOST EXEC_HOST JOB_NAME SUBMIT_TIME
    9670681 current_user     RUN   basement   head_node node1     job1     Oct 24 10:24
    9740051 current_user     RUN   basement   head_node node1     job2     Oct 24 17:41
    9670681 current_user     RUN   normal     head_node node2     job3     Oct 24 10:24
    9740981 current_user     PEND  basement   head_node           job4     Oct 24 17:44

    ```
     - Given the [following output](data/farm-snapshot.txt) of `bjobs -all`, which users are the top 5 users of the cluster?
     - How many jobs does the user `pathpip` have running in all queues?
     - A user wants to know how many jobs they have pending (`PEND`) and running (`RUN`) in each queue. Write a command line to do that (You can use the log above to check your command line). How would they display this on their screen permanently, in real time?
8. An analysis you need to run on the cluster requires a particular python library, but you do not have administrator rights. IT is on holiday. What do you do?

### Bioinformatics
1. The [VCF format](http://www.internationalgenome.org/wiki/Analysis/vcf4.0/) is a popular format to describe genetic variations in a study group. It is often used in sequencing projects. Due to size concerns, it is often compressed using `gzip` and indexed using `tabix`. A binary version, BCF, also exists.
    - Write a command or script to remove duplicate positions in a VCF such as [this one](data/duplicates.vcf.gz), independently of their alleles. The positions can be duplicated an arbitrary number of times. Write code to keep the first, last and a random record among each set of duplicated records.
    - Same question, but make duplicate detection allele-specific. When it finds such an exact duplicate, your code should remove all of the corresponding records.
2. From an existing VCF with an arbitrary number of samples, how do you produce a VCF file without any samples using `bcftools`?
3. You are the curator of a genotype dataset with a very strict privacy policy in place. In particular, it should be impossible to tell, given access to a person's genetic data, whether they were part of your study by looking at a dataset you provided. A collaborator is asking you for some data to run tests on their code. What information can you safely contribute from your study?
4. How do you convert a gzipped VCF to the `bimbam` format? (you may choose to script a solution yourself, or not)
5. A user sends you a small number of chromosome and positions in build 38 that they want to know the rsID of. 
    - What is missing from their request? What kind of unexpected output can they expect?
    - Given [this file](data/rand.chrpos.txt), honour their request using the Ensembl REST API.
    - Do the same, but offline, using the dbSNP r.150 VCF file.
    - What would change if these positions were in build 37?
    - If the user sends you 7,000 such chromosome positions, how would the above methods perform? Do you know of any alternatives?
6. How would you change the chromosome numbers in the file above to chromosome names (e.g. "chr1" instead of "1")?
    - How would you change the names back to the original? Would your solution work if an additional column containing text of arbitrary length and content is appended at the left of the file?
    - These positions are extracted from a VCF. Convert this file to the BED format.
7.	Download the 1000 Genomes sites VCF file for chromosome 21 [here](http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions/ALL.chr21_GRCh38_sites.20170504.vcf.gz). We want to compare it to [a locally stored file](data/ALL.chr21_GRCh38_sites.20170504.vcf.gz).
    - What is the fastest way to check the integrity of, or compare, any such downloaded file?
    - If you find that the files are indeed different, how do you find their differences? Keep in mind that this kind of file can be very large (>100Gb), your solution should be as fast and memory-efficient as possible.
    - If you found no differences in the end, what could cause a false alarm?
8.	What is the p-value corresponding to standard normal z-scores of 10.35, 29.7, 45.688 and 78.1479?
9.	We want to round a column of numbers to `n` digits, with values with 5 as their rightmost significant digit rounded up. Use the language of your choice.
10.  Is [this HRC-imputed file](https://drive.google.com/open?id=1dOYlwIlAyz9-i4gVy2sgpQv_4YX9Y5nU) missing any chromosomes? Try to find out in seconds if you can.
11.  Find out the coordinates of the _ADIPOQ_ gene. Your method should be generalisable to a list of genes and take a few seconds to run (take inspiration from question 5). Then, please report the following:
    - the coordinates of the exons of its canonical transcript.
    - all documented variants in this gene.
    - all phenotype-associated variants. 
    - all documented loss-of-function (LoF) variants in this gene. How did you define LoF?
    - If asked to find all regulatory variants that potentially affect this gene, which questions would you ask and how would you proceed?
12. How would you convert a VCF file to the Plink binary format? How would you do the reverse, and what kind of problems do you anticipate?


### Statistical genetics
1. You sample at random 10,000 variants from a deep (50x) whole-genome sequencing variant call file describing 1,000 individuals. What do you expect the distribution of minor allele frequency to look like? In particular, which minor allele counts are likely to be most frequent?
2. You are running a single-point association study with a quantitative phenotype on the dataset above. Which filters, if any, would you apply to the dataset? 
3. A common practice when performing genetic association studies is to perform an ethnicity check as a quality control step. Can you explain how this is done?
    - You are dealing with whole-genome sequencing data in 2,326 Bulgarian samples. How would you perform such an ethnicity check, and which projection dataset would you use? 
4. You perform a single-point association with blood lipids and find a variant with MAF=0.7% associated at p=1e-14. Do you expect the effect size to be large or small? What would be your next steps investigating this signal?
5. You are running an inverse-variance based single-point meta-analysis of the above dataset together with a UK study of 12,400 individuals. The variant above is found in the UK dataset, but its association is weak (1e-3). However, another variant located 1kb downstream is strongly associated with the same trait (p=1e-15) but weakly associated in your study (p=5e-4). Which of these 2 variants do you expect will have the strongest meta-analysis p-value? What do you think is happening in this region, how can you test it, and which model could you apply if it is the case?
6. An analyst studies a population of remote villages in Eastern Europe. They are interested in a particular variant, and compare the frequency in their villages (3.5%) to the EUR population frequency in the 1000 Genomes (0.03%). They conclude that the variant has increased in frequency in their villages. Do you agree, and if not, what would your advice be?
7.  The same analyst sends you association summary statistics for random glucose.
    - Which checks would you perform on such a dataset?
    - You wish to include this dataset in a meta-analysis. Which additional information should you ask for in your next email to your colleague?
    - In this dataset, you observe  &#955;=1.25. The analyst has adjusted for age, age-squared, sex, and fasting status. What would you suggest they do?
8. You are a co-author on a manuscript. You receive a draft, in which the main author has used the traditional &#945;=5e-8 as the significance threshold. The paper describes an analysis of 10 related blood phenotypes (platelet count, platelet volume, immature platelet fraction ...) using the fixed markers of the Infinium ImmunoArray on 897 individuals. What do you think about the chosen threshold, and what would you suggest to the first author? What would be your comments on the design of the study? 
