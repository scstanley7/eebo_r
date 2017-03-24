setwd("~/Desktop/eebo_r")
library(XML)
library(tm)
directory <- "holinshed"
directory
files.v <- dir(path=directory, pattern=".*xml")
documents.l <- list()
for(i in 1:length(files.v)){
  document <- xmlTreeParse(file.path(directory, files.v[i]), useInternalNodes = TRUE)
  documents.l[[files.v[i]]] <- getNodeSet(document, "/tei:TEI//tei:div[@type='chapter'] | /tei:TEI//tei:div[@type='section']", namespaces = c(tei="http://www.tei-c.org/ns/1.0"))
}
holinshed1.l <- documents.l[[1]]
holinshed2.l <- documents.l[[2]]
both.documents <- c(holinshed1.l, holinshed2.l)
paras.lower.v <- vector()
for(i in 1:length(both.documents)){
  paras <- xmlElementsByTagName(both.documents[[i]], "p")
  paras.words.v <- paste(sapply(paras, xmlValue), collapse = " ")
  paras.lower.v[[i]] <- tolower(paras.words.v)
}
?paste
holinshed.all <- paste(paras.lower.v, collapse=" ", sep="\n")
length(holinshed.all)
holinshed.all
holinshed.corpus <- Corpus(VectorSource(holinshed.all))
holinshed.corpus = tm_map(holinshed.corpus, removeWords, stopwords("english"))
?writeCorpus
writeCorpus(holinshed.corpus, filenames = "holinshed.txt")
holinshed <- scan("holinshed.txt", what="character", sep="\n")
holinshed[1:10]
holinshed <- paste(holinshed, collapse=" ")
length(holinshed)
holinshed.words <- strsplit(holinshed, "\\W")
holinshed.words[1:10]
holinshed.words <- unlist(holinshed.words)
length(holinshed.words)
holinshed.words[1:10]
class(holinshed.words)
holinshed.words <- holinshed.words[which(holinshed.words!="")]
holinshed.words[1:10]
holinshed.frequencies <- table(holinshed.words) 
length(holinshed.frequencies)
holinshed.frequencies[1:10]
length(holinshed.frequencies)
holinshed.frequencies <- holinshed.frequencies[895:37086]
holinshed.frequencies[1:10]
holinshed.frequencies.sort <- sort(holinshed.frequencies, decreasing = TRUE)
holinshed.frequencies.sort[1:10]
plot(holinshed.frequencies.sort[1:20])
