# ITG Challenge

## Description/Instructions

Please find below a few questions that mimic some common problems we encounter at ITG. They are grouped by broad theme. You will notice there are many questions, the goal is not to answer them all. Pick a few questions, as many as you want, they can be all from one theme, or span all of them. We encourage you to choose your questions wisely: if you are a Python expert, avoid R questions, for example.

For programmatic questions, you can use the language of your choice. If you use the shell, you can assume that common non-core packages will be installed (e.g. `awk`, `sed`, `perl`, `python`, `sponge`, `wget` or `jq`). You can use the shell of your choice, if not otherwise specified we will assume `bash`. Assume that all common bioinformatics tools `bcftools`, `bedtools`, `vcftools`, `plink` and others are all installed.

Whenever the command line or programming is used, include your code along with your answer.

To submit your answer, please clone this repository and make your edits. Once you're done, send us a link to your repository, or compress it and send us a link to the archive.

## Questions

### Support/resource management/Shell
1. A user has several versions of R installed in their path. Each version of R has a number of locally installed libraries. The user is confused, and would like to know which library is installed for which version of R. Can you write a command to help them out?
2. A common problem with shared filesystems is a disk quota overflow. This can be due to 1) a large combined size on disk or 2) too many files present on disk. We would like to help users who encounter this problem to locate the problematic files/directories. Write a command to sort all subdirectories of level n (n determined by the user) by their human-readable size. Write another command to sort all subdirectories of level n according to the number of files they contain.
3. A user wants to install an `R` package and gets the following [error log](data/error.log). What is likely to cause the error and how can they solve it?
4. A user is running commands like this one `cat file1 <(cut -d " " -f 1-15,17,18 file2) > file3`. What does this command do? It runs fine on the command line, but then the user puts all their commands into a script, and runs `chmod +x` on it. However, that line of code throws the following error : `syntax error near unexpected token '('`. Why?
5. A collaborator has sent you [this script](data/EasyQCWrapper.sh). It is a wrapper for a bioinformatics software called `EasyQC`.  Running it, you get the following error: 

    ```bash
    ./test.EasyQC-START.R: line 6: syntax error near unexpected token 'EasyQC'
    ./test.EasyQC-START.R: line 6: 'library(EasyQC)'
    ```

     You need to run this script now, but it's Friday, your collaborator is in Japan and they have already left the office. What is causing the error? (Hint: Nothing is wrong with the `.ecf` EasyQC script.)
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
     - Given the [following output log](data/farm-snapshot.txt) of `bjobs -all`, which users are the top 5 users of the cluster?
     - How many jobs does the user `pathpip` have running in all queues?
     - A user wants to know how many jobs they have pending (`PEND`) and running (`RUN`) in each queue. Write a command line to do that (You can use the log above to check your command line). How would they display this on their screen permanently, in real time?
8. An analysis you need to run on the cluster requires a particular python library, but you do not have administrator rights. IT is on holiday. What do you do?  

### Bioinformatics
1. The [VCF format](http://www.internationalgenome.org/wiki/Analysis/vcf4.0/) is a popular format to describe genetic variations in a study group. It is often used in sequencing projects. Due to size concerns, it is often compressed using `gzip` and indexed using `tabix`. A binary version, BCF, also exists.
    - Write a command or script to remove duplicate positions in a VCF such as [this one](data/duplicates.vcf.gz), independently of their alleles. The positions can be duplicated an arbitrary number of times. Write code to keep the first, last and a random record among each set of duplicated records.
    - Same question, but make duplicate selection allele specific and remove all incriminated records instead of keeping one.
2. How do you produce a VCF file without any samples using `bcftools`?
3. You are the curator of a dataset with a very strict privacy policy in place. In particular, it should be impossible to tell, given access to a person's genetic data, whether they were part of your study by looking at a dataset you provided. A collaborator is asking you for some data to run tests on their code. What information can you safely contribute from your study?
4. How do you convert a gzipped VCF to the `bimbam` format? (you may script a solution yourself)
5. A user sends you a small number of chromosome and positions in build 38 that they want to know the rsID of. 
    - What is missing from their request? What kind of unexpected output can they expect?
    - Given [this file](data/rand.chrpos), honour their request using the Ensembl REST API.
    - Do the same, but offline, using the dbSNP r.150 VCF file.
    - Answer the above 2 questions in build 37.
    - If the user sends you 7,000 such chromosome positions, how would the above methods perform? Do you know of any alternatives?
2. for appropriately named chr files, add a column to the beginning of the file containing the chromosome code ("chr" followed by the number of the chromosome, 1 to 22)
3.	Download the 1000 Genomes sites VCF file for chromosome 21 [here](http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/supporting/GRCh38_positions/ALL.chr21_GRCh38_sites.20170504.vcf.gz). We want to compare it to [a locally stored file](data/ALL.chr21_GRCh38_sites.20170504.vcf.gz).
    - What is the fastest way to check the integrity of, or compare, any such downloaded file?
    - If you find that the files are indeed different, how do you find their differences? Keep in mind that this kind of file can be very large (>100Gb).
    - If you found no differences in the end, what could cause a false alarm?
4.	What is the p-value corresponding to standard normal z-scores of 10.35, 29.7, 45.688 and 78.1479?
5.	We want to round a column of numbers to `n` digits, with values with 5 as their rightmost significant digit rounded up. Use the language of your choice.
6.  Is [this HRC-imputed file](https://drive.google.com/open?id=1dOYlwIlAyz9-i4gVy2sgpQv_4YX9Y5nU) missing any chromosomes? Try to find out in seconds if you can.

### Statistical genetics
1. you sample 10,000 variants from a WGS file. Which MAF more likely.
2. Which filters for assoc
3. a collaborator studies a population of remote villagers in Finland. They are interested in a particular variant, and compare the frequency in their village (3.5%) to the EUR population frequency in the 1000 Genomes (0.03%). They conclude that the variant has increased in frequency in the Finns. 
4. Significance calculation. 
