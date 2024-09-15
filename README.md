## Analysing the Bermuda Atlantic Time-series Study (BATS) data in MATLAB

This repository contains a collection of MATLAB scripts that I have developed to read, format and visualise freely-available oceanographic datasets from BATS for the practical sessions with the 4th-year undergraduate fieldtrip course. The visualisation style follows the widely-used Ocean Data View (ODV) format, providing clear and comprehensive representations of oceanographic data. The daatsets analysed include: **bottle data**, **pigment data**, **net primary production**, **particulate fluxes** and **zooplankton biomass**.

## Requirements

To use the content of this repository, ensure you have the following.

- MATLAB version R2021a or later installed. 
- Third-party functions downloaded from [MATLAB'S File Exchange](https://mathworks.com/matlabcentral/fileexchange/): `brewermap` and `lsubaxis`. Once downloaded, please place the functions in the `./externalresources/` directory.
- Oceanographic datasets from the Bermuda Atlantic Time-series Study (BATS) downloaded from [BATS/BIOS website](https://bats.bios.asu.edu/bats-data/): `bats_bottle.txt`, `bats_pigments.txt`, `bats_primary_production_v003.txt`, `bats_flux_v003.txt` and `bats_zooplankton.txt`. Once downloaded, please place the files in the `./data/` directory.
- Oceanographic dataset of particle flux data from the Oceanic Flux Program (OFP) downloaded from [BCO-DMO](https://www.bco-dmo.org/dataset/704722): `OFP_particle_flux.csv`. Once downloaded, please place the file in the `./data/` directory.