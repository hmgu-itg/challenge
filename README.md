# ITG Challenge

## Description/Instructions

Please find below a few questions that mimic some common problems we encounter at ITG. They are grouped by broad theme. You will notice there are many questions, the goal is not to answer them all. Pick a few questions, as many as you want, they can be all from one theme, or span all of them. 

For programmatic questions, you can use the language of your choice. If you use the shell, you can assume that common non-core packages will be installed (e.g. `sponge`, `wget` or `jq`)

To submit your answer, please clone this repository and make your edits. Once you're done, send us a link to your repository, or compress it and send us a link to the archive.

## Questions

### Support/resource management
1. A user has several versions of R installed in their path. Each version of R has a number of locally installed libraries. The user is confused, and would like to know which library is installed for which version of R. Can you write a command to help them out?
2. A common problem with shared filesystems is a disk quota overflow. This can be due to 1) a large combined size on disk or 2) too many files present on disk. We would like to help users who encounter this problem to locate the problematic files/directories. Write a command to sort all subdirectories of level n (n determined by the user) by their human-readable size. Write another command to sort all subdirectories of level n according to the number of files they contain.
3. A user wants to install an `R` package and gets the following [error log](data/error.log). What is likely to cause the error and how can they solve it?
4. A user is running commands like this one `cat file1 <(cut -d " " -f 1-15,17,18 file2) > file3`. What does this command do? It runs fine on the command line, but then the user puts all their commands into a script, and runs `chmod +x` on it. However, that line of code throws the following error : `syntax error near unexpected token '('`. Why?
5. A collaborator has sent you [this script](data/EasyQCWrapper.sh). It is a wrapper for a bioinformatics software called `EasyQC`.  Running it, you get the following error: 

    ```bash
    ./test.EasyQC-START.R: line 6: syntax error near unexpected token 'EasyQC'
    ./test.EasyQC-START.R: line 6: 'library(EasyQC)'
    ```
    
     You need to run this script now, but it's Friday, your collaborator is in Japan and they have already left the office.
3. The bjobs command gives this kind of output: . on screen, list of all jobs running/pending in every queue. Use LSF commands if you know them, the shell otherwise.
4. An analysis you need to run on the cluster requires a particular python library, but you do not have administrator rights. IT is on holiday. What do you do? Similar solutions exist for other languages, however things become more tricky 

### Bioinformatics
1. Converting VCF to BIMBAM
2. for appropriately named chr files, add a column to the beginning of the file containing the chromosome code ("chr" followed by the number of the chromosome, 1 to 22)
3.	zdiff
4.	what is the p corresponding to a given z score (have to use log)
5.	We want to round a column of numbers x in R to n digits, with values with 5 as their  rightmost significant digit rounded up. How would you write this?
