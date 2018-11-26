# ITG Challenge

## Description/Instructions

Please find below a few questions that mimic some common problems we encounter at ITG. They are grouped by broad theme. You will notice there are many questions, the goal is not to answer them all. Pick a few questions, as many as you want, they can be all from one theme, or span all of them. 

For programmatic questions, you can use the language of your choice. If you use the shell, you can assume that common non-core packages will be installed (e.g. `sponge`, `wget` or `jq`)

To submit your answer, please clone this repository and make your edits. Once you're done, send us a link to your repository, or compress it and send us a link to the archive.

## Questions

Support/resource management
1.	A user has several versions of R installed in their path. Each version of R has a number of locally installed libraries. The user is confused, and would like to know which library is installed for which version of R. Can you write a command to help them out?
2.	A common problem with shared filesystems is a disk quota overflow. This can be due to 1) a large combined size on disk or 2) too many files present on disk. We would like to help users who encounter this problem to locate the problematic files/directories. Write a command to sort all subdirectories of level n (n determined by the user) by their human-readable size. Write another command to sort all subdirectories of level n according to the number of files they contain.
3.	The bjobs command gives this kind of output: . on screen, list of all jobs running/pending in every queue. Use LSF commands if you know them, the shell otherwise.
4.	an analysis you require needs a python library but you are not an admin, what do you do? If you needed to ask IT to install one piece of software that allows you to install whatever you want w

Bioinformatics
1.	Converting VCF to BIMBAM
2.	for appropriately named chr files, add a column to the beginning of the file containing the chromosome code ("chr" followed by the number of the chromosome, 1 to 22)
3.	zdiff
4.	what is the p corresponding to a given z score (have to use log)
5.	We want to round a column of numbers x in R to n digits, with values with 5 as their  rightmost significant digit rounded up. How would you write this?
