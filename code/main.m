
% ======================================================================= %
%                                                                         %
% This script processes and visualises ocean biogeochemical datasets      %
% obtained from the Bermuda Atlantic Time Series (BATS) website           %
% (https://bios.asu.edu/bats/bats-data) and the Oceanic Flux Program      %
% (OFP) (https://www.bco-dmo.org/dataset/704722). The visualisation style % 
% follows the widely-used Ocean Data View (ODV) format, providing clear   %
% and comprehensive representations of oceanographic data.                %
%                                                                         %
% The datasets analysed include:                                          %
%   - Bottle data (physical, chemical and biological variables)           %
%   - Phytoplankton photosynthetic pigment data                           %
%   - Net primary production                                              %
%   - Particulate fluxes                                                  %
%   - Mesozooplankton biomass                                             %
%   - Bacteria production                                                 %
%                                                                         %
%   WRITTEN BY A. RUFAS, UNIVERISTY OF OXFORD                             %
%   Anna.RufasBlanco@earth.ox.ac.uk                                       %
%                                                                         %
%   Version 1.0 - Completed 22 Sep 2024                                   %
%   Version 1.1 - Completed 8 Dec 2024 (improved comments and workflow)   %
%                                                                         %
% ======================================================================= %

close all; clear all; clc
addpath(genpath('./resources/external/'));
addpath(genpath('./code/'));
addpath(genpath('./raw/data/'));

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 1 - PRESETS
% -------------------------------------------------------------------------

% Define filenames
filenameBottleData  = 'bats_bottle.txt';
filenamePigmentDara = 'bats_pigments.txt';
filenameNpp         = 'bats_primary_production_v003.txt';
filenameBatsFlux    = 'bats_flux_v003.txt';
filenameOfpFlux     = 'OFP_particle_flux.csv';
filenameZoo         = 'bats_zooplankton.txt';
filenameBac         = 'bats_bacteria_production.txt';

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 2 - PROCESS AND PLOT BOTTLE DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
batsBottle = processRawBatsBottle(fullfile('data','raw',filenameBottleData));

% Load plotting configurations (adjust accordingly)
varsConfig = plotConfigBatsBottle;
fields = fieldnames(varsConfig);

% Loop through each field in the structure and plot ODV style
for iVar = 1:length(fields)
    varName = fields{iVar};
    varDepths = batsBottle.Depth;
    varDates = datenum(batsBottle.Date);
    
    % Extract the configuration for the variable
    varConfig = varsConfig.(varName);
    
    % Adjust the data based on the variable
    if (iVar <= 11)
        varValues = batsBottle.(varName);
    else
        varValues = 1e-3.*batsBottle.(varName); % convert to better units
    end
    
    plotOdvStyle(varValues,...                                     % ocean variable to plot
                 varDepths,...                                     % y values
                 varDates,...                                      % x values
                 varConfig.xMin,varConfig.xMax,varConfig.xStep,... % x limits (xmin, xmax, xstep)
                 varConfig.yMin,varConfig.yMax,varConfig.yStep,... % y limits (ymin, ymax, ystep)
                 varConfig.cMin,varConfig.cMax,varConfig.cStep,... % colour bar limits (cmin, cmax, cstep) 
                 varConfig.cAnomaly,...                            % anomaly
                 varConfig.label,...                               % colour bar string
                 strcat('bats_bottle_',varName))                   % figure name tag

end         

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 3 - PROCESS AND PLOT PIGMENT DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
batsPigments = processRawBatsPigments(fullfile('data','raw',filenamePigmentDara));

% Load plotting configurations (adjust accordingly)    
varsConfig = plotConfigBatsPigments;
fields = fieldnames(varsConfig);
   
% Loop through each field in the structure and plot ODV style
for iVar = 1:length(fields)
    varName = fields{iVar};
    varValues = batsPigments.(varName);
    varDepths = batsPigments.Depth;
    varDates  = datenum(batsPigments.Date);
    
    % Extract the configuration for the variable
    varConfig = varsConfig.(varName);
    
    plotOdvStyle(varValues,...                                     % ocean variable to plot
                 varDepths,...                                     % y values
                 varDates,...                                      % x values
                 varConfig.xMin,varConfig.xMax,varConfig.xStep,... % x limits (xmin, xmax, xstep)
                 varConfig.yMin,varConfig.yMax,varConfig.yStep,... % y limits (ymin, ymax, ystep)
                 varConfig.cMin,varConfig.cMax,varConfig.cStep,... % colour bar limits (cmin, cmax, cstep) 
                 varConfig.cAnomaly,...                            % anomaly
                 varConfig.label,...                               % colour bar string
                 strcat('bats_pigments_',varName))                 % figure name tag

end

% Plot varibles over time at 100 m depth
plotPigmentDataByType(batsPigments,...
                      batsPigments.Date,...                                     % x values
                      batsPigments.Depth,...                                    % y values
                      varsConfig,...
                      datetime(1990,01,01),datetime(2023,06,01),calyears(2),... % x limits (xmin, xmax, xstep)
                      0,500,50,...                                              % y limits (ymin, ymax, ystep)
                      'Concentration (ng kg^{-1})',...                          % ylabel
                      'Phytoplankton pigments at 100 m depth',...               % title
                      {'Chl a','19-Hex (cocco)','19-But (pico)','Fuco (diat)','Peri (dino)','Zea (cyan)'},... % legend
                      'bats_pigments_100m')                                     % figure name 

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 4 - PROCESS AND PLOT NET PRIMARY PRODUCTION (NPP) DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
[batsNpp,batsNppDepthIntegrated] = processRawBatsNpp(fullfile('data','raw',filenameNpp));

% Plot ODV style
plotOdvStyle(batsNpp.pp,...                                            % ocean variable to plot
             batsNpp.dep1,...                                          % y values
             datenum(batsNpp.yymmdd_in),...                            % x values
             datetime(2010,01,01),datetime(2023,06,01),calyears(2),... % x limits (xmin, xmax, xstep)
             0,150,25,...                                              % y limits (ymin, ymax, ystep)
             0,20,2.5,...                                              % colour bar limits (cmin, cmax, cstep) – mg C m-3 d-1
             5,...                                                     % anomaly
             'NPP (mg C m^{-3} d^{-1})',...                            % colour bar string
             'bats_npp')                                               % figure name tag

% Plot NPP depth-integrated over time 
plotVariableOverTime(batsNppDepthIntegrated.date,...                           % x values
                     batsNppDepthIntegrated.NPP_mg_C_m2_d,...                  % y values
                     datetime(2010,01,01),datetime(2023,06,01),calyears(2),... % x limits (xmin, xmax, xstep)
                     0,1200,200,...                                            % y limits (ymin, ymax, ystep) - mg C m-2 d-1
                     'mg C m^{-2} d^{-1}',...                                  % y-label
                     'NPP depth-integrated',...                                % title
                     'bats_npp_depthintegrated')                               % figure name tag

% Show trends on data with outliers removed
plotTrends(batsNppDepthIntegrated.date,...          % x values
           batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
           'NPP (mg C m^{-2} d^{-1})',...           % y-label
           'bats_npp_trends')                       % figure name tag

% Show ciclicity of data
plotCycles(batsNppDepthIntegrated.date,...          % x values
           batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
           0,1200,...                               % ymin, ymax
           'NPP (mg C m^{-2} d^{-1})',...           % y-label
           'bats_npp_cycles')                       % figure name tag

% Plot anomaly plots
plotAnomalies(batsNppDepthIntegrated.date,...          % x values
              batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
              -50,50,20,...                            % ylimits (min, max, step) (percent)
              'mg C m^{-2} d^{1}',...                  % y units
              'bats_npp_anomalies')                    % figure name tag
              
% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 5 - PROCESS AND PLOT BATS FLUX DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
batsFlux = processRawBatsFlux(fullfile('data','raw',filenameBatsFlux));

% Load plotting configurations (adjust accordingly)    
varsConfig = plotConfigBatsFlux;
fields = fieldnames(varsConfig);

% Loop through each field in the structure and plot ODV style
for iVar = 1:length(fields)     
    varName = fields{iVar};
    varValues = batsFlux.(varName);
    varDepths = batsFlux.dep;
    varDates  = datenum(batsFlux.yymmdd1);
    
    % Extract the configuration for the variable
    varConfig = varsConfig.(varName);

    plotOdvStyle(varValues,...                                     % ocean variable to plot
                 varDepths,...                                     % y values
                 varDates,...                                      % x values
                 varConfig.xMin,varConfig.xMax,varConfig.xStep,... % x limits (xmin, xmax, xstep)
                 varConfig.yMin,varConfig.yMax,varConfig.yStep,... % y limits (ymin, ymax, ystep)
                 varConfig.cMin,varConfig.cMax,varConfig.cStep,... % colour bar limits (cmin, cmax, cstep) 
                 varConfig.cAnomaly,...                            % anomaly
                 varConfig.label,...                               % colour bar string
                 strcat('bats_flux',varName))                      % figure name tag

end         

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 6 - PROCESS AND PLOT OFP FLUX DATA
% -------------------------------------------------------------------------

% Read in the .csv data into a Matlab table
ofpFlux = processRawOfpFlux(fullfile('data','raw',filenameOfpFlux));

% Load plotting configurations (adjust accordingly)    
varsConfig = plotConfigOfpFlux;
fields = fieldnames(varsConfig);

% Loop through each field in the structure and plot ODV style as well as
% sections over time
for iVar = 1:length(fields)  
    varName = fields{iVar};
    
    % Extract the configuration for the variable
    varConfig = varsConfig.(varName);
    
    % Plot ODV
    varValues = ofpFlux.(varName);
    varDepths = ofpFlux.depth;
    varDates  = datenum(ofpFlux.Mid_Date);

    plotOdvStyle(varValues,...                                     % ocean variable to plot
                 varDepths,...                                     % y values
                 varDates,...                                      % x values
                 varConfig.xMin,varConfig.xMax,varConfig.xStep,... % x limits (xmin, xmax, xstep)
                 varConfig.yMin,varConfig.yMax,varConfig.yStep,... % y limits (ymin, ymax, ystep)
                 varConfig.cMin,varConfig.cMax,varConfig.cStep,... % colour bar limits (cmin, cmax, cstep) 
                 varConfig.cAnomaly,...                            % anomaly
                 varConfig.label,...                               % colour bar string
                 strcat('ofp_flux',varName))                       % figure name tag

             
    % Plot varibles at 500 m depth over time
    varValues = ofpFlux.(varName)(ofpFlux.depth == 500);
    varDates  = ofpFlux.Mid_Date(ofpFlux.depth == 500);

    plotVariableOverTime(varDates(~isnan(varValues)),...                      % x values
                         varValues(~isnan(varValues)),...                     % y values
                         varConfig.xMin,varConfig.xMax,varConfig.xStep,...    % x limits (xmin, xmax, xstep)
                         varConfig.yMint,varConfig.yMaxt,varConfig.yStept,... % y limits (ymin, ymax, ystep) - mg C m-2 d-1
                         varConfig.label,...                                  % y-label
                         'Flux at 500 m',...                                  % title
                         strcat('ofp_flux_500m_',varName))                    % figure name tag
                     
end         

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 7 - PROCESS AND PLOT ZOOPLANKTON DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
batsZooDepthIntegrated = processRawBatsZoop(fullfile('data','raw',filenameZoo));

% Plot zooplankton biomass by size category over time
plotZooplanktonDataBySizeClass(batsZooDepthIntegrated,...                                % data (mg DW m-2)
                               datetime(1995,01,01),datetime(2021,12,01),calyears(2),... % x-axis values
                               0,800,200)                                                % y-axis values
    
% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 8 - PROCESS AND PLOT BACTERIA PRODUCTION DATA
% -------------------------------------------------------------------------

% Read in the .txt data into a Matlab table
batsBacteria = processRawBatsBacteria(fullfile('data','raw',filenameBac));

% Plot ODV style
plotOdvStyle(batsBacteria.thy,...                                      % ocean variable to plot
             batsBacteria.dep1,...                                     % y values
             datenum(batsBacteria.yymmdd),...                          % x values
             datetime(1991,01,01),datetime(2012,01,01),calyears(2),... % x limits (xmin, xmax, xstep)
             0,1000,100,...                                            % y limits (ymin, ymax, ystep)
             0,2,0.20,...                                              % colour bar limits (cmin, cmax, cstep)
             1,...                                                     % anomaly
             'Bacteria growth rate (pmol L^{-1} h^{-1})',...           % colour bar string
             'bats_bacteriagrowth')                                    % figure name tag
