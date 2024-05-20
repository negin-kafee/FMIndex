\name{fm_index}
\alias{fm_index}
\title{Compute FM Index for a DNA sequence}
\description{
  This function computes the FM Index for a given DNA sequence.
}
\usage{
fm_index(fasta_file, output_dir, compress = FALSE)
}
\arguments{
  \item{fasta_file}{A character string specifying the path to the input FASTA file.}
  \item{output_dir}{A character string specifying the directory to write the output files.}
  \item{compress}{Logical, whether to compress the output files.}
}
\value{
  Writes the FM Index components (BWT, suffix array, occurrence table, and C table) to the specified directory.
}
\examples{
# Create an example FASTA file
writeLines(">example\nAGCTAGCTAGCTA", "example.fasta")

# Compute FM Index
fm_index("example.fasta", "output", compress = FALSE)
}

