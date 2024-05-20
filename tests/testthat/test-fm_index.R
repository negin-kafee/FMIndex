library(testthat)
library(FMIndex)

test_that("FM Index components are correctly written", {
  # Create an example FASTA file
  writeLines(">example\nAGCTAGCTAGCTA", "example.fasta")
  
  # Run the fm_index function
  fm_index("example.fasta", "test_output")
  
  # Check if the files are created
  expect_true(file.exists("test_output/bwt.txt"))
  expect_true(file.exists("test_output/sa.txt"))
  expect_true(file.exists("test_output/occ.txt"))
  expect_true(file.exists("test_output/c_table.txt"))

  # Read the contents of the files
  bwt <- readLines("test_output/bwt.txt")
  sa <- read.table("test_output/sa.txt")
  occ <- read.table("test_output/occ.txt", header = TRUE)
  c_table <- read.table("test_output/c_table.txt", header = TRUE)

  # Validate the contents (the actual expected values should be correct)
  expect_equal(bwt, "ATTT$GGGAAACCC")  # Adjust this expected value as necessary
  expect_equal(dim(sa), c(14, 1))
  expect_equal(dim(occ), c(14, 5))
  expect_equal(dim(c_table), c(5, 1))
  
  # Clean up
  unlink("test_output", recursive = TRUE)
  unlink("example.fasta")
})

