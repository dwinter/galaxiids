#Comparing transcriptome sequences between two Galaxiid fish. 

This project data compares transcriptome data from two galaxiid fish.

_Galaxias brevipinis_ (kōaro in Maori, `brev` my python code) is the 
"climbing galaxiid", a migratory species. Adults live in freshwater but their 
young wash out to sea shortly after hacthing. They return to freshwater a few 
months later as whitebait. 

_Galaxias depressiceps_ is a stream-limited galaxiid, one of many species that
have arisen from the _G. brevipinis_ lineage when acess to the sea was blocked. 

THis project uses 454 transcriptome data to explore how these life-histories
 effect the evolution of these species (and also perhaps find the basis of the
 behavioural change that keeps _G. depressiceps_ in freshwater). 


##What you need to run these analyses 


* [FindORf](https://github.com/vsbuffalo/findorf)
* BLAST+
* sqlite 
* Python 2.7 or 3.x
* R
* Python packages
    + Biopython
    + BioSQL for Biopython
    + Pandas
* R packages
    + seqinr

##What's already been done

* Sequencing and assembly: `brev` is a high-quality/high coverege assembly to
  form a reference for later studies. `dep` is less high qual/cov but will allow
  us to do some analayses. 

* Other files:
    + `annotation/seqs/uniprot_sprot.fasta` is the current release of what used 
    to be called "swissprot"
    + `annotations/blastdbs` contains databases made form the protein files
       from related genome projects (Salmon, Trout, chichlid, Zebrafish)

##Workflow

Each of the following analysis steps are held together by `ipython` notebooks,
which sometimes call small scripts in `R` or `python`, or executables like
`BLAST+`


###Summary

The notebook in `/Summary` has a brief exploratory analysis and summary of the
sequncing data before it goes into these pipelines.

###Annotation

The contigs were annotate at two leves. First, I tried to find some sort of
homology-based functional annotation using `Swissprot` as the target database

Each contig-set was `blastx`-ed against swissprot, with `xml` ouput format. I
then used `Biopython` to parse the xml. I saved the hits as a `BioSQL` database 
(effectively a seriealised SeqRecord object) with each record having a
`swissprot` field in their `.annotation` object.

I also identified putative ORFs from the contigs. I tried various stupid
home-spun approaches for this, before finding Vince Buffalo's  [FindORf](https://github.com/vsbuffalo/findorf)
, which worked really well for us. We used blasts against trout, salmon, cichlid
and zebrafish protein files from various genome projects. The resulting ORFs
were saved to fasta files:  `seqs/[species]_orf.fasta`

###DnDs






