library(testthat)
library(FMIndex)

test_that("FM Index components are correctly written", {
  fm_index("example.fasta", "test_output")

  expect_true(file.exists("test_output/bwt.txt"))
  expect_true(file.exists("test_output/sa.txt"))
  expect_true(file.exists("test_output/occ.txt"))
  expect_true(file.exists("test_output/c_table.txt"))

  bwt <- readLines("test_output/bwt.txt")
  sa <- read.table("test_output/sa.txt")
  occ <- read.table("test_output/occ.txt", header = TRUE)
  c_table <- read.table("test_output/c_table.txt", header = TRUE)

  expect_equal(bwt, "ATTT$GGGAAACCC")
  expect_equal(dim(sa), c(14, 1))
  expect_equal(dim(occ), c(14, 5))
  expect_equal(dim(c_table), c(5, 1))
})
