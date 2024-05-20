\name{fm_index}
\alias{fm_index}
\title{Compute FM Index for a DNA sequence}
\usage{
fm_index(fasta_file, output_dir, compress = FALSE)
}
\arguments{
  \item{fasta_file}{Path to the input FASTA file containing a single DNA sequence.}
  \item{output_dir}{Path to the output directory where FM Index components will be written.}
  \item{compress}{Logical flag indicating whether to compress the output files.}
}
\description{
This function computes the FM Index for a given DNA sequence.
}
\examples{
writeLines(">example\nAGCTAGCTAGCTA", "example.fasta")
fm_index("example.fasta", "output")
}

