library(testthat)
library(FMIndex)

test_that("FM Index components are correctly written", {
  # Create the example.fasta file
  fasta_content <- ">example\nAGCTAGCTAGCTA"
  writeLines(fasta_content, "example.fasta")
  
  # Ensure the test_output directory is clean
  if (dir.exists("test_output")) {
    unlink("test_output", recursive = TRUE)
  }

  # Run the fm_index function
  fm_index("example.fasta", "test_output")
  
  # Check if files are created
  expect_true(file.exists("test_output/bwt.txt"))
  expect_true(file.exists("test_output/sa.txt"))
  expect_true(file.exists("test_output/occ.txt"))
  expect_true(file.exists("test_output/c_table.txt"))
  
  # Read the contents of the files
  bwt <- readLines("test_output/bwt.txt")
  sa <- read.table("test_output/sa.txt")
  occ <- read.table("test_output/occ.txt", header = TRUE)
  c_table <- read.table("test_output/c_table.txt", header = TRUE)
  
  # Validate the contents
  expect_equal(bwt, "ATTT$GGGAAACCC")
  expect_equal(dim(sa), c(14, 1))
  expect_equal(dim(occ), c(14, 5))
  expect_equal(dim(c_table), c(5, 1))
  
  # Clean up test files
  unlink("example.fasta")
  unlink("test_output", recursive = TRUE)
})

