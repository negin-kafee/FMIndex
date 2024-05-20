# FMIndex

The FMIndex package provides functions to compute the FM Index for a DNA sequence provided in a FASTA file.

## Installation

You can install the package from source using the `devtools` package:

```r
# Install devtools if you haven't already
install.packages("devtools")

# Install FMIndex from GitHub
devtools::install_github("negin-kafee/FMIndex")
```


## Usage

```r
library(FMIndex)

# Compute FM Index for a sample FASTA file
fm_index("example.fasta", "output")
```

## Documentation

See the package documentation for detailed information on the available functions and their usage.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
