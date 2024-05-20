#' Compute FM Index for a DNA sequence
#'
#' This function takes a single FASTA sequence file (DNA sequence) as input and writes the corresponding FM Index.
#'
#' @param fasta_file Path to the input FASTA file containing a single DNA sequence.
#' @param output_dir Path to the output directory where FM Index components will be written.
#' @param compress Logical flag indicating whether to compress the output files.
#' @return The function writes the FM Index components to the specified output directory.
#' @details This function computes the Burrows-Wheeler Transform, suffix array, occurrence table, and C table for the given DNA sequence.
#' @importFrom utils write.table
#' @examples
#' writeLines(">example\nAGCTAGCTAGCTA", "example.fasta")
#' fm_index("example.fasta", "output")
#' @export
fm_index <- function(fasta_file, output_dir, compress = FALSE) {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Read the DNA sequence from the FASTA file
  dna_seq <- tryCatch(
    {
      readLines(fasta_file)
    },
    error = function(e) {
      stop("Error reading FASTA file: ", e$message)
    }
  )

  dna_seq <- paste(dna_seq[!grepl("^>", dna_seq)], collapse = "")

  # Append the terminator character
  dna_seq <- paste0(dna_seq, "$")

  # Compute the Burrows-Wheeler Transform
  bwt <- bw_transform(dna_seq)
  bwt_file <- file.path(output_dir, "bwt.txt")
  writeLines(bwt, bwt_file)
  if (compress) compress_file(bwt_file)

  # Compute the suffix array
  sa <- suffix_array(dna_seq)
  sa_file <- file.path(output_dir, "sa.txt")
  write.table(sa, sa_file, row.names = FALSE, col.names = FALSE)
  if (compress) compress_file(sa_file)

  # Compute the Occurrence table
  occ <- occurrence_table(bwt)
  occ_file <- file.path(output_dir, "occ.txt")
  write.table(occ, occ_file, row.names = FALSE, col.names = TRUE)
  if (compress) compress_file(occ_file)

  # Compute the C table
  c_table <- c_table(bwt)
  c_table_file <- file.path(output_dir, "c_table.txt")
  write.table(c_table, c_table_file, row.names = FALSE, col.names = TRUE)
  if (compress) compress_file(c_table_file)

  message("FM Index components written", if (compress) " and compressed", " to ", output_dir)
}

compress_file <- function(file_path) {
  lines <- readLines(file_path)
  compressed <- gzfile(paste0(file_path, ".gz"), "w")
  writeLines(lines, compressed)
  close(compressed)
  file.remove(file_path)
}

bw_transform <- function(seq) {
  n <- nchar(seq)
  rotations <- sapply(seq_len(n), function(i) {
    paste0(substr(seq, i, n), substr(seq, 1, i - 1))
  })
  sorted_rotations <- sort(rotations)
  paste0(substr(sorted_rotations, n, n), collapse = "")
}

suffix_array <- function(seq) {
  n <- nchar(seq)
  suffixes <- sapply(seq_len(n) - 1, function(i) {
    substr(seq, i + 1, n)
  })
  order(suffixes)
}

occurrence_table <- function(bwt) {
  alphabet <- sort(unique(unlist(strsplit(bwt, ""))))
  occ <- sapply(alphabet, function(c) {
    cumsum(unlist(strsplit(bwt, "")) == c)
  })
  colnames(occ) <- alphabet
  occ
}

c_table <- function(bwt) {
  sorted_bwt <- sort(unlist(strsplit(bwt, "")))
  alphabet <- unique(sorted_bwt)
  c_table <- sapply(alphabet, function(c) {
    sum(sorted_bwt < c)
  })
  names(c_table) <- alphabet
  c_table
}
