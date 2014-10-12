#! /usr/bin/Rscript
library(seqinr)
library(plyr)
library(stringr)

per_align <- function(a_file){
    ali <- read.alignment(a_file, "fasta")
    estimate <- kaks(ali)
    brev_id <- str_replace(str_split(a_file, "_")[[1]][1], "brev", "contig")
    len <- str_length(ali$seq[[1]])
    if (is.na(estimate[1])){
    #means there is missense mutation in the ORFs (or, more likey our assembly)
        res <- c(brev_id, len, NA, NA, NA)
    } else if (estimate$ka == 0 & estimate$ks == 0){
        res <- c(brev_id, len, 0, 0, NA)
    } else {
        res <- with(estimate, c(brev_id, len, ka, ks, ka/ks))
    }
    return(res)
}


main <- function(){
    afiles <- paste("../alignments/", list.files("../alignments/"), sep="")
    afiles <- afiles[str_detect(afiles, ".best.fas")]
    res <- ldply(afiles, per_align, .progress='text')
    names(res) <- c("brev_id", "length", "ka", "ks", "omega")
    write.csv(res, '../results/selection.csv')
}

if(!interactive() ){
    main()
}

     





