## Analysing the Bermuda Atlantic Time-series Study (BATS) Data in MATLAB

![README_cover](https://github.com/user-attachments/assets/6eaf1907-f037-4b2d-bf75-f439c3d95c6b)
*Time-series of seawater density at BATS.*

The **Bermuda Atlantic Time-series Study (BATS)** is the world's longest continuous series of biogeochemical observations. While the data are [open access](https://bios.asu.edu/bats/bats-data), users are responsible for writing their own code to read, process and visualise it.

This repository contains a collection of scripts I developed to streamline the process of reading, formatting and visualising all the BATS data, offering an accessible solution for researchers and students looking to analyse these datasets in **MATLAB**. This is an ideal tool for further processing and analysis, as it enables the storage of pre-processed data in arrays and supports the implementation of more complex analyses

These scripts were created specifically for the Oxford 4th-year undergraduate field trip course. The visualisations closely follow the style of the **Ocean Data View ([ODV](https://odv.awi.de))** platform, aligning with the tool the students use during their lab sessions. These visualisations primarily consist of contour plots, which display data over both depth and time, with scatter points representing the measurements.

## Requirements

*⚠️ Note: These instructions are designed and tested specifically for macOS. While they may work on other operating systems (e.g., Windows or Linux), you might need to adapt the installation code accordingly.*

To use the content of this repository, ensure you have the following.
- [MATLAB](https://mathworks.com/products/matlab.html) version R2021a or later installed.
- Third-party functions downloaded from [MATLAB'S File Exchange](https://mathworks.com/matlabcentral/fileexchange/): `brewermap` and `subaxis`. Once downloaded, please place the functions under the `./resources/external/` directory.

## Datasets Analysed

The following BATS datasets were downloaded from the [BATS/BIOS website](https://bios.asu.edu/bats/bats-data) and can be found in the `./data/raw/` directory:

- **BATS bottle data** (physical, chemical and biological variables): `bats_bottle.txt`
- **BATS phytoplankton photosynthetic pigment data**: `bats_pigments.txt`
- **BATS net primary production**: `bats_primary_production_v003.txt`
- **BATS particulate fluxes**: `bats_flux_v003.txt`
- **BATS mesozooplankton biomass**: `bats_zooplankton.txt` 
- **BATS bacterial production**: `bats_bacteria_production.txt`

Additionally, the repository contains oceanographic particle flux data from the **Oceanic Flux Program (OFP)**, a partnered time-series program, downloaded from the [BCO-DMO repository](https://www.bco-dmo.org/dataset/704722) and can also be found in the `./data/raw/` directory:
- **OFP particulate fluxes**: `OFP_particle_flux.csv`

These datasets cover a range of oceanographic parameters, and the provided MATLAB scripts allow for easy access and inspection of these data.

## MATLAB Scripts

| Num | Script name               | Script action                                 |
|----|----------------------------|-----------------------------------------------
| 1   | main.m                    | Main entry point for running the entire data processing and plotting pipeline                                             |
| 2   | processRawBatsBottle.m    | Processes raw BATS bottle data     |
| 3   | processRawBatsPigments.m  | Processes raw BATS pigment data    |
| 4   | processRawBatsNpp.m       | Processes raw data on net primary production (NPP)    |
| 5   | processRawBatsFlux.m      | Processes raw data on particulate fluxes    |
| 6   | processRawBatsZoop.m      | Processes raw data on mesozooplankton biomass    |
| 7   | processRawBatsBacteria.m  | Processes raw data on bacterial production    |
| 8   | processRawOfpFlux.m       | Processes raw particle flux data from the Oceanic Flux Program (OFP)    |
| 9   | plotConfigBatsBottle.m    | Configuration parameters to plot in ODV style BATS bottle data    |
| 10  | plotConfigBatsPigments.m  | Configuration parameters to plot in ODV style BATS pigment data    |
| 11  | plotConfigBatsFlux.m      | Configuration parameters to plot in ODV style BATS flux data    |
| 12  | plotConfigOfpFlux.m       | Configuration parameters to plot in ODV style OFP flux data    |
| 13  | plotOdvStyle.m            | Generates a plot in the style of the Ocean Data View (ODV) platform    |
| 14  | plotPigmentDataByType.m   | Plot for BATS pigment data, categorised by pigment type (not ODV style plot)   |
| 15  | plotZooplanktonDataBySizeClass.m    | Plot for mesozooplankton biomass data, categorised by size class (not ODV style plot)    |
| 16  | plotVariableOverTime.m    | Plot time-series data (not ODV style plot)   |
| 17  | plotTrends.m              | Plot to visualise trends over time (not ODV style plot)    |
| 19  | plotCycles.m              | Plot to visualise periodic cycles in the data  (not ODV style plot)  |