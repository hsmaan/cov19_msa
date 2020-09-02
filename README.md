
# COVID-19 Evolutionary Distance

An evolutionary distance calculation tool for SARS-CoV-2 viral genomes
that removes the following homoplasic sites:

**187, 1059, 2094, 3037, 3130, 6990, 8022, 10323, 10741, 11074, 13408,
14786, 19684, 20148, 21137, 24034, 24378, 25563, 26144, 26461, 26681,
28077, 28826, 28854, 29700, 4050, 13402, 11083, 15324, 21575**

## Overview

The script options are the following (**ensure input\_fasta is in same
directory as
    cov19\_evo\_dist**):

    Rscript --verbose evo_dist.R [input_fasta] [length_cutoff] [ambg_nucleotide_cutoff] [dist_method] [iterations] [refinements] [cores] 

  - input\_fasta: location of the input fasta file containing query
    sequences - ensure it’s in same directory as cov19\_evo\_dist
    \[file\]
  - length\_cutoff: minimum length of query sequences for filtering
    \[0-30000\]
  - ambg\_nucleotide\_cutoff: maximum percentage of ambiguous
    nucleotides in query sequences for filtering \[0-1\]
  - dist\_method: The evolutionary distance metric to use from the ape
    library. “K80” is recommended. More information is available in the
    ape documentation
    <https://www.rdocumentation.org/packages/ape/versions/5.4-1/topics/dist.dna>,
    under the “model” parameter. \[model\_name\]
  - iterations: Number of iterations for multiple sequence alignment
    algorithm - 0 recommended unless sequences are particularly low
    quality (then 5-6). \[0-n\]
  - refinements: Refinement steps for the multiple sequence alignment
    algorithm - 0 recommended unless sequences are particularly low
    quality (then 2-3). \[0-n\]
  - cores: number of cores to utilize during processing \[1-n\]

E.g:

    Rscript --verbose evo_dist.R example.fasta 29000 0.1 K80 0 0 2

Output is saved to **out** folder under same name as input file

## Installation

Clone repository:

    git clone https://github.com/hsmaan/cov19_evo_dist.git

Set up and activate conda environment:

    conda env create --name evo_env --file evo_dist.yaml
    conda activate evo_env

Example run:

    Rscript --verbose evo_dist.R example.fasta 29000 0.1 K80 0 0 2
