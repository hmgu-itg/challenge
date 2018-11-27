#!/bin/bash
### INPUT 
# $1 =  File prefix/phenotype
# $2 =  PATH output
# $3 =  PATH to file Folder
# $4 =  PATH to Mapping File

########  write EasyQC-START.R and Fileqc.EasyQC.ecf Script
cd $2
touch  $1.EasyQC-START.R
touch  $1.EasyQC.ecf

#######  write EASYQC-START.R  #########################
echo "
#!/software/bin/Rscript --vanilla

# EasyQC-START.R    
# Loading dependancies
library(EasyQC)
#RUN EASYQC
EasyQC('$2$1.EasyQC.ecf')
# Exiting EasyQC.R
q()
#########################################################
" >> $1.EasyQC-START.R

#########################################################
######### Write EasyQC.ecf #######################

echo "
#########################################################
####    Genetics of Osteoarthritis EasyQC script    #####
#########################################################
DEFINE  --pathOut $2
	--strSeparator TAB 
	--acolIn CPTID;CHR;POS;EA;NEA;EAF;P;BETA;SE;NCASES;NCONTROLS;N;INFO
	--acolInClasses character;character;numeric;character;character;numeric;numeric;numeric;numeric;numeric;numeric;numeric;numeric ">>  $1.EasyQC.ecf

for i in $(ls -d -1 $3*)
do
echo EASYIN  --fileIn $i >> $1.EasyQC.ecf
done

echo "
 
######################
## EASYQC Scripting interface:
####################

START EASYQC

## 1. Sanity checks:
#Remove missing values
CLEAN --rcdClean is.na(EA) & is.na(NEA)   --strCleanName numDrop_Missing_Alleles
CLEAN --rcdClean is.na(P)                 --strCleanName numDrop_Missing_P
CLEAN --rcdClean is.na(BETA)              --strCleanName numDrop_Missing_BETA
CLEAN --rcdClean is.na(SE)                --strCleanName numDrop_Missing_SE
CLEAN --rcdClean is.na(EAF)               --strCleanName numDrop_Missing_EAF
CLEAN --rcdClean is.na(NCASES)            --strCleanName numDrop_Missing_CASES
CLEAN --rcdClean is.na(NCONTROLS)         --strCleanName numDrop_Missing_CONTROLS
CLEAN --rcdClean is.na(INFO)              --strCleanName numDrop_Missing_Imputation

# Harmonize the Alleles to A/T/C/G and I/D 
HARMONIZEALLELES 			  --colInA1  EA
					  --colInA2  NEA

# Remove nonsense values
CLEAN --rcdClean !(EA%in%c('A','C','G','T','I','D'))    --strCleanName numdrop_invalid_EA
CLEAN --rcdClean !(NEA%in%c('A','C','G','T','I','D'))   --strCleanName numdrop_invalid_NEA
CLEAN --rcdClean P<0|P>1                                --strCleanName numDrop_invalid_PVAL
CLEAN --rcdClean SE<=0|SE==Inf                          --strCleanName numDrop_invalid_SE
CLEAN --rcdClean abs(BETA)==Inf                         --strCleanName numDrop_invalid_BETA
CLEAN --rcdClean EAF<0|EAF>1                            --strCleanName numDrop_invalid_EAF
CLEAN --rcdClean INFO<0|INFO>1                          --strCleanName numDrop_invalid_IMPUTATION

# This is important for data reduction, because some studies report an unnecessary large number of significant digits
EDITCOL --rcdEditCol signif(BETA,4) --colEdit BETA
EDITCOL --rcdEditCol signif(SE,4)   --colEdit SE
EDITCOL --rcdEditCol signif(P,4)    --colEdit P

####################
## 2. Effective sample size and MAC based on Neff for Filtering
ADDCOL --rcdAddCol signif(2/(1/NCASES)+(1/NCONTROLS),4)  --colOut Neff
ADDCOL --rcdAddCol signif(2*pmin(EAF,1-EAF)*Neff*INFO,4) --colOut EAC

####################
## 3. Filtering Steps
CLEAN --rcdClean (INFO<0.3)                 --strCleanName numDrop_lowImpQual
CLEAN --rcdClean (EAF==0)|(EAF==1)          --strCleanName numDrop_Monomorphic
CLEAN --rcdClean Neff<20                    --strCleanName numDrop_Nlt20
CLEAN --rcdClean EAC<=5                     --strCleanName numDrop_EAClt6


# Exclude Sex-Chromosomes & Save to other file
CLEAN --rcdClean !CHR%in%c(1:22,NA)  --strCleanName numDrop_ChrXY
      --blnWriteCleaned 1

####################
## 4. Add SNP data
MERGE   --colInMarker CPTID
        --fileRef $4	
	--acolIn  REF;ALT;AF;CPTID
        --acolInClasses character;character;numeric;character 
        --strRefSuffix .ref
        --colRefMarker CPTID
        --blnWriteNotInRef 1

#RENAMECOL --colInRename SNP.ref --colOutRename SNP
ADDCOL    --rcdAddCol signif(AF.ref,4) --colOut EAF.ref

####################
## 6.Filter duplicate SNPs
## This will count duplicates and throw out the SNP with the lower sample size:
CLEANDUPLICATES --colInMarker CPTID
                --strMode samplesize
                --colN Neff

## The duplicates are written to the output in a separate file duplicates.txt
####################
## 7. Check Alleles
ADJUSTALLELES   --colInA1 EA
                --colInA2 NEA
                --colInFreq EAF
                --colInBeta BETA
                --colRefA1 ALT.ref
                --colRefA2 REF.ref
                --blnMetalUseStrand 1
                --blnRemoveMismatch 1
                --blnRemoveInvalid 1

AFCHECK         --colInFreq EAF
                --colRefFreq EAF.ref
                #--numLimOutlier 0.2
                #--blnPlotAll 0

## blnPlotAll 0 causes that only outlying SNPs with |Freq-Freq.ref|>0.2 will be plotted (way less computational time)

####################
## 8. Rearrange columns and Write CLEANED output
GETCOLS --acolOut CPTID;CHR;POS;EA;NEA;EAF;BETA;SE;P;NCASES;NCONTROLS;N;Neff;EAC;INFO

WRITE   --strPrefix CLEANED.
        --strMissing NA
        --strMode gz

####################
## 9. QC PLOTS
CALCULATE --rcdCalc max(Neff,na.rm=T)
          --strCalcName Nmax

## Plot Z versus P
PZPLOT  --colBeta BETA
        --colSe SE
        --colPval P

## QQ plot
QQPLOT  --acolQQPlot P
        --numPvalOffset 0.05
        --strMode subplot

## GC plot
GC      --colPval P
        --blnSuppressCorrection 1

RPLOT   --rcdRPlotX Nmax
        --rcdRPlotY Lambda.P.GC
        --arcdAdd2Plot abline (h=1, col='orange');abline(h=1.1, col='red')
        --strAxes lim(0,NULL,0,NULL)
        --strPlotName GC-PLOT

# SE-N Plot - Trait transformation

CALCULATE --rcdCalc median(SE,na.rm=T) --strCalcName SE_median
CALCULATE --rcdCalc median(1/sqrt(2*EAF*(1-EAF)), na.rm=T) --strCalcName c_trait_transf

RPLOT 	--rcdRPlotX sqrt(Nmax)
		--rcdRPlotY c_trait_transf/SE_median
		--arcdAdd2Plot abline(0,1,col='orange')
		--strAxes zeroequal
		--strPlotName SEN-PLOT

###############
STOP EASYQC
" >> $1.EasyQC.ecf
##############################################################################

chmod +x $1.EasyQC-START.R

### RUN EASYQC

./$1.EasyQC-START.R

exit
