## Analysing the Bermuda Atlantic Time-series Study (BATS) Data in MATLAB

This repository contains a collection of MATLAB scripts that I have developed to read, format and visualise freely-available oceanographic datasets from the Bermuda Atlantic Time-series Study (BATS). These scripts were created to support the lab sessions in the Oxford’s 4th-year undergraduate field trip course. The visualisation style emulates the popular **Ocean Data View (ODV)** format, following the toolbox that the students will use in the lab session. The datasets analysed include: **bottle data**, **pigment data**, **net primary production**, **particulate fluxes**, **zooplankton biomass** and **bacteria production**.

![README_cover](https://github.com/user-attachments/assets/98435e8c-5a95-4f37-9db2-b666eb852ac2)

## Requirements

To use the content of this repository, ensure you have the following.
- [MATLAB](https://mathworks.com/products/matlab.html) version R2021a or later installed.
- Third-party functions downloaded from [MATLAB'S File Exchange](https://mathworks.com/matlabcentral/fileexchange/): `brewermap` and `subaxis`. Once downloaded, please place the functions under the `./resources/external/` directory.
- Oceanographic datasets from the Bermuda Atlantic Time-series Study (BATS) downloaded from [BATS/BIOS website](https://bats.bios.asu.edu/bats-data/): `bats_bottle.txt`, `bats_pigments.txt`, `bats_primary_production_v003.txt`, `bats_flux_v003.txt`, `bats_zooplankton.txt` and `bats_bacteria_production.txt`. Once downloaded, please place the files under a `./data/` directory.
- Oceanographic dataset of particle flux data from the Oceanic Flux Program (OFP) downloaded from [BCO-DMO](https://www.bco-dmo.org/dataset/704722): `OFP_particle_flux.csv`. Once downloaded, please place the file under the `./data/raw/` directory.