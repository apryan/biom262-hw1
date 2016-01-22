#!/bin/csh
#PBS -q hotel
#PBS -N APRhw1
#PBS -l nodes=1:ppn=2
#PBS -l walltime=0:10:00
#PBS -o tfbindout.o
#PBS -e tfbinderr.e
#PBS -V 
#PBS -M apryan@ucsd.edu
#PBS -m abe
cd ~/code/biom262-2016/weeks/week01/data
awk '$4 == "NFKB" {print $0 > "tf.nfkb.bed"}' tf.bed
wc -l tf.nfkb.bed
echo '--- First 10 lines ---'
head tf.nfkb.bed
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}'  tf.nfkb.bed | head
echo '--- Last 10 lines ---'
tail tf.nfkb.bed
awk '$3 == "transcript" {print $0 > "gencode.v19.annotation.chr22.transcript.gtf"}' gencode.v19.annotation.chr22.gtf

wc -l gencode.v19.annotation.chr22.transcript.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}'  gencode.v19.annotation.chr22.transcript.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.gtf
module load biotools
bedtools flank -i gencode.v19.annotation.chr22.transcript.gtf -g hg19.genome -s -l 2000 -r 0 > gencode.v19.annotation.chr22.transcript.promoter.gtf

wc -l gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.gtf
echo '--- Random 10 lines ---'
awk -v seed=907 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.gtf
module load biotools
bedtools intersect -a gencode.v19.annotation.chr22.transcript.promoter.gtf -b tf.nfkb.bed > gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf
module load biotools
bedtools getfasta -s -fi GRCh37.p13.chr22.fa -bed gencode.v19.annotation.chr22.transcript.promoter.nfkb.gtf -fo gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
# YOUR CODE HERE\n


wc -l gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- First 10 lines ---'
head gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
echo '--- Random 10 lines ---'
awk -v seed=908 'BEGIN{srand(seed);}{ if (rand() < 0.5 ) {print $0}}' gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | head
echo '--- Last 10 lines ---'
tail gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta
#i copied the + and - strand information from the paper's canonical NFKB site excel file and pasted them into nano, 
#saving it as nfkbcanon
#it will print out the total number of lines and then the number of lines that contain the canonical nfkb sequences 
grep  "chr" gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | wc -l
grep -Ff nfkbcanon gencode.v19.annotation.chr22.transcript.promoter.nfkb.fasta | wc -l
# you see that about half of them are on both lists
echo "Hello I am a message in standard out (stdout)"

# add line to go to error output 
echo "Hello I am a message in standard error (stderr)" >&2
