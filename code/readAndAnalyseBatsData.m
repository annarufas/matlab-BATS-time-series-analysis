% ======================================================================= %
%                                                                         %
% This script processes and visualises ocean biogeochemical datasets      %
% obtained from the Bermuda Atlantic Time Series (BATS) website           %
% (https://bats.bios.asu.edu/bats-data/). The visualisation style follows %
% the widely-used Ocean Data View (ODV) format, providing clear and       %
% comprehensive representations of oceanographic data. The available      % 
% datasets include:                                                       %
%   - Bottle (physical, chemical and biological variables)                %
%   - Bottle pigments                                                     %
%   - Net primary production                                              %
%   - Particulate fluxes                                                  %
%   - Zooplankton biomass                                                 %
%   - Bacteria production                                                 %
%                                                                         %
%   WRITTEN BY A. RUFAS, UNIVERISTY OF OXFORD                             %
%   Anna.RufasBlanco@earth.ox.ac.uk                                       %
%                                                                         %
%   Version 1.0 - Completed 22 Sep 2024                                   %
%                                                                         %
% ======================================================================= %

close all; clear all; clc
addpath(genpath(fullfile('externalresources')))
addpath(genpath(fullfile('code')))

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 1 - BOTTLE DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameBottleData = 'bats_bottle.txt';
[batsBottle] = processRawBatsBottle(fullfile('data',filenameBottleData));

% Plotting configuration
xMin = datetime(1989,01,01);   % start date for plotting
xMax = datetime(2023,06,01);   % end date for plotting
xStep = calyears(2);           % X-axis step (years)

% Define variables for plotting: (table variable name | plot label)
oceanVarsLabel = {'Temperature', 'Temperature (ºC)';...
                  'CTDSalinity', 'Salinity (PSU)';...
                  'SigmaTheta', 'Density (kg m^{-3})';...
                  'Oxygen1', 'O_2 (\mumol kg^{-1})';...
                  'CO2', 'CO_2 (\mumol kg^{-1})';...
                  'Alkalinity', 'ALK';...
                  'NitrateNitrite1', 'Nitrate + nitrite (\mumol kg^{-1})';...
                  'Phosphate1', 'Phosphate (\mumol kg^{-1})';...
                  'Silicate1','Silicate (\mumol kg^{-1})';...
                  'POC', 'POC (\mug kg^{-1})';...
                  'Bacteria', 'Bacteria (10^{8} x cells/kg)';...
                  'Prochlorococcus', 'Prochlorococcus (10^{3} x cells/mL)'; ...
                  'Synechococcus', 'Synechococcus (10^{3} x cells/mL)';...
                  'Picoeukaryotes', 'Picoeukaryotes (10^{3} x cells/mL)';...
                  'Nanoeukaryotes', 'Nanoeukaryotes (10^{3} x cells/mL)'};

% Colour bar adjustment              
cMin     = [  3,  35,  23, 130, 2000, 2300,  0,    0,  0,  0,  0,   0,  0,   0,   0];
cMax     = [ 30,  37,  27, 250, 2200, 2400, 20,  1.5, 15, 50, 10, 100, 20,   5,   1];
cStep    = [1.5, 0.2, 0.5,  10,   20,   10,  2, 0.10,  1,  5,  1,  10,  2, 0.5, 0.1];  
cAnomaly = [  2, 0.2, 0.5,  20,   20,   20,  5,  0.5,  5, 20,  2,  50, 20,   2, 0.5];

for iVar = 1:height(oceanVarsLabel) 
    
    varName = oceanVarsLabel{iVar,1};
    varLabel = oceanVarsLabel{iVar,2};
    if (iVar <= 11)
        varValues = batsBottle.(varName);
    else
        varValues = 1e-3.*batsBottle.(varName); % convert to better units
    end
    varDepths = batsBottle.Depth;
    varDates = datenum(batsBottle.Date);
    
    % Adjust y-axis limits based on the variable
    if (iVar < 10)
        yMin = 0;
        yMax = 2000;
        yStep = 500; 
    elseif (iVar == 10 || iVar == 11)
        yMin = 0;
        yMax = 1000;
        yStep = 200;
    else
        yMin = 0;
        yMax = 300;
        yStep = 50;
    end
    
    % For cell-related variables, zoom in to more recent years
    if (iVar > 10) 
        xMin = datetime(2013,01,01);
    end
    
    plotOdvStyle(varValues,...                         % ocean variable to plot
                 varDepths,...                         % y values
                 varDates,...                          % x values
                 xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
                 yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
                 cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
                 cAnomaly(iVar),...                    % anomaly
                 varLabel,...                          % colour bar string
                 strcat('bats_bottle_',varName))       % figure name tag

end         

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 2 - PIGMENT DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenamePigments = 'bats_pigments.txt';
[batsPigments] = processRawBatsPigments(fullfile('data',filenamePigments));

% Plotting configuration
xMin = datetime(1990,01,01);   % start date for plotting
xMax = datetime(2023,06,01);   % end date for plotting
xStep = calyears(2);           % X-axis step (years)
    
% Define variables for plotting: (table variable name | plot label)
oceanVarsLabel = {'Pigment14_Chlorophyll_a', 'Chl. a (ng kg^{-1})';...
                  'Pigment7_19_Hexanoyloxyfucoxanthin', '19-Hex. (ng kg^{-1} (cocco.)';...
                  'Pigment5_19_Butanoyloxyfucoxanthin', '19-But. (ng kg^{-1}) (picoeuk.) ';...
                  'Pigment6_Fucoxanthin', 'Fucoxanthin (ng kg^{-1}) (diatom) ';...
                  'Pigment4_Peridinin', 'Peridinin (ng kg^{-1}) (dino.) ';...
                  'Pigment12_Zeaxanthin_Lutein', 'Zeax.+lut. (ng kg^{-1}) (Cyano.)'};

% .........................................................................

% Plot ODV style

% Colour bar adjustment             
cMin     = [  0,   0,  0,  0,  0,  0];
cMax     = [600, 200, 80, 20, 10, 80];
cStep    = [ 50,  20, 10,  2,  1,  8];  
cAnomaly = [ 50,  10, 10, 20, 20, 20];

% Depth limits
yMin = 0;
yMax = 300;
yStep = 50;
        
for iVar = 1:height(oceanVarsLabel) 
    
    varName   = oceanVarsLabel{iVar,1};
    varLabel  = oceanVarsLabel{iVar,2};
    varValues = batsPigments.(varName);
    varDepths = batsPigments.Depth;
    varDates  = datenum(batsPigments.Date);
    
    plotOdvStyle(varValues,...                         % ocean variable to plot
                 varDepths,...                         % y values
                 varDates,...                          % x values
                 xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
                 yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
                 cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
                 cAnomaly(iVar),...                    % anomaly
                 varLabel,...                          % colour bar string
                 strcat('bats_pigments_',varName))     % figure name tag

end

% .........................................................................

% Plot varibles over time at 100 m depth

% Depth limits
yMin  = 0;
yMax  = 500;
yStep = 50; 

plotVariablesOverTimeInOnePlot(batsPigments,...
                               batsPigments.Date,...            % x values
                               batsPigments.Depth,...           % y values
                               oceanVarsLabel,...
                               xMin,xMax,xStep,...              % x limits (xmin, xmax, xstep)
                               yMin,yMax,yStep,...              % y limits (ymin, ymax, ystep)
                               'Concentration (ng kg^{-1})',... % ylabel
                               'Pigments at 100 m depth',...    % title
                               {'Chl a','19-Hex (cocco)','19-But (pico)','Fuco (diat)','Peri (dino)','Zea (Cyan)'},... % legend
                               'bats_pigments_100m.png')        % figure name 

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 3 - NET PRIMARY PRODUCTION (NPP) DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameNpp = 'bats_primary_production_v003.txt';
[batsNpp,batsNppDepthIntegrated] = processRawBatsNpp(fullfile('data',filenameNpp));

% Plotting configuration
xMin = datetime(1989,01,01);
xMax = datetime(2023,06,01);
xStep = calyears(2);

% .........................................................................

% Plot ODV style

plotOdvStyle(batsNpp.pp,...                 % ocean variable to plot
             batsNpp.dep1,...               % y values
             datenum(batsNpp.yymmdd_in),... % x values
             xMin,xMax,xStep,...            % x limits (xmin, xmax, xstep)
             0,150,25,...                   % y limits (ymin, ymax, ystep)
             0,20,2.5,...                   % colour bar limits (cmin, cmax, cstep) – mg C m-3 d-1
             5,...                          % anomaly
             'NPP (mg C m^{-3} d^{-1})',... % colour bar string
             'bats_npp')                    % figure name tag

% .........................................................................

% Plot NPP depth-integrated over time 

plotVariableOverTime(batsNppDepthIntegrated.date,...          % x values
                     batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
                     xMin,xMax,xStep,...                      % x limits (xmin, xmax, xstep)
                     0,1200,200,...                           % y limits (ymin, ymax, ystep) - mg C m-2 d-1
                     'NPP (mg C m^{-2} d^{-1})',...           % y-label
                     'npp.png')                               % figure name

% .........................................................................

% Show trends on data with outliers removed

plotTrends(batsNppDepthIntegrated.date,...          % x values
           batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
           'NPP (mg C m^{-2} d^{-1})',...           % y-label
           'npp_trends.png')                        % figure name

% .........................................................................

% Show ciclicity of data

plotCycles(batsNppDepthIntegrated.date,...          % x values
           batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
           0,1200,...                               % ymin, ymax
           'NPP (mg C m^{-2} d^{-1})',...           % y-label
           'npp_cycles.png')                        % figure name

% .........................................................................

% Plot anomaly plots

plotAnomalies(batsNppDepthIntegrated.date,...          % x values
              batsNppDepthIntegrated.NPP_mg_C_m2_d,... % y values
              -50,50,20,...                            % ylimits (min, max, step) (percent)
              'mg C m^{-2} d^{1}',...                  % y units
              'npp_anomalies.png')                     % figure name
              
% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 4 - BATS FLUX DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameFlux = 'bats_flux_v003.txt';
[batsFlux] = processRawBatsFlux(fullfile('data',filenameFlux));

% Plotting configuration
xMin = datetime(2013,01,01);
xMax = datetime(2023,06,01);
xStep = calyears(2);

% Define variables for plotting: (table variable name | plot label)
oceanVarsLabel = {'Mavg', 'Mass flux (mg m^{-2} d^{-1})';...
                  'Cavg', 'POC flux (mg C m^{-2} d^{-1})'};

% Colour bar adjustment              
cMin     = [  0,   0];
cMax     = [200, 100];
cStep    = [ 20,   5];  
cAnomaly = [100, 100];

% Depth axis
yMin = 150;
yMax = 300;
yStep = 25;

for iVar = 1:height(oceanVarsLabel) 
    
    varName   = oceanVarsLabel{iVar,1};
    varLabel  = oceanVarsLabel{iVar,2};
    varValues = batsFlux.(varName);
    varDepths = batsFlux.dep;
    varDates  = datenum(batsFlux.yymmdd1);

    plotOdvStyle(varValues,...                         % ocean variable to plot
                 varDepths,...                         % y values
                 varDates,...                          % x values
                 xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
                 yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
                 cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
                 cAnomaly(iVar),...                    % anomaly
                 varLabel,...                          % colour bar string
                 strcat('bats_flux',varName))          % figure name tag

end         

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 5 - OFP FLUX DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameFluxOfp = 'OFP_particle_flux.csv';
[ofpFlux] = processRawOfpFlux(fullfile('data',filenameFluxOfp));

% Plotting configuration (for bSi and Lithogenic there's data only for 2002-2015)
xMin = datetime(2002,01,01);
xMax = datetime(2016,01,01);
xStep = calyears(2);

% Define variables for plotting: (table variable name | plot label)
oceanVarsLabel = {'MassFlux', 'Total mass flux (mg m^{-2} d^{-1})';...
                  'CorgFlux', 'POC flux (mg C m^{-2} d^{-1})';...
                  'CarbFlux', 'CaCO_3 flux (mg CaCO_3 m^{-2} d^{-1})';...
                  'OpalFlux', 'bSi flux (mg bSi m^{-2} d^{-1})';...
                  'LithFlux', 'Lithogenic flux (mg m^{-2} d^{-1})'};

% .........................................................................

% Plot ODV style

% Colour bar adjustment              
cMin     = [  0,   0,   0,  0,   0];
cMax     = [150,   5, 100, 10,   5];
cStep    = [ 25, 0.5,  10,  1, 0.5];  
cAnomaly = [50,    2,  50,  5,   5];

% Depth axis
yMin = 500;
yMax = 3200;
yStep = 500;

for iVar = 1:height(oceanVarsLabel) 
    
    varName   = oceanVarsLabel{iVar,1};
    varLabel  = oceanVarsLabel{iVar,2};
    varValues = ofpFlux.(varName);
    varDepths = ofpFlux.depth;
    varDates  = datenum(ofpFlux.Mid_Date);
    
    plotOdvStyle(varValues,...                         % ocean variable to plot
                 varDepths,...                         % y values
                 varDates,...                          % x values
                 xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
                 yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
                 cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
                 cAnomaly(iVar),...                    % anomaly
                 varLabel,...                          % colour bar string
                 strcat('ofp_flux',varName))           % figure name tag

end         

% .........................................................................

% Plot varibles at 500 m depth over time 

% Y-axis adjustment
yMin     = [  0,   0,   0,  0, 0];
yMax     = [250,  18, 200, 10, 6];
yStep    = [ 25, 2.5,  20,  1, 1];  

for iVar = 1:height(oceanVarsLabel) 

    varName   = oceanVarsLabel{iVar,1};
    varLabel  = oceanVarsLabel{iVar,2};
    varValues = ofpFlux.(varName)(ofpFlux.depth == 500);
    varDates  = ofpFlux.Mid_Date(ofpFlux.depth == 500);
%     disp(mean(varValues,'omitnan'))
%     disp(std(varValues,'omitnan'))

    plotVariableOverTime(varDates(~isnan(varValues)),...          % x values
                         varValues(~isnan(varValues)),...         % y values
                         xMin,xMax,xStep,...                      % x limits (xmin, xmax, xstep)
                         yMin(iVar),yMax(iVar),yStep(iVar),...    % y limits (ymin, ymax, ystep) - mg C m-2 d-1
                         varLabel,...                             % y-label
                         strcat('ofp_flux_500m_',varName,'.png')) % figure name

end 

% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 6 - ZOOPLANKTON DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameZoo = 'bats_zooplankton.txt';
[batsZooDepthIntegrated] = processRawBatsZoop(fullfile('data',filenameZoo));

% Plotting configuration
xMin = datetime(1995,01,01);
xMax = datetime(2021,12,01);
xStep = calyears(2);

plotZooplankton(batsZooDepthIntegrated,... % data (mg DW m-2)
                xMin,xMax,xStep,...        % x-axis values
                0,800,200)                 % y-axis values
    
% =========================================================================
%%
% -------------------------------------------------------------------------
% SECTION 7 - BACTERIA PRODUCTION DATA
% -------------------------------------------------------------------------

% Read in the file into a Matlab table
filenameBac = 'bats_bacteria_production.txt';
[batsBacteria] = processRawBatsBacteria(fullfile('data',filenameBac));

% Plotting configuration
xMin = datetime(1991,01,01);
xMax = datetime(2012,01,01);
xStep = calyears(2);

plotOdvStyle(batsBacteria.thy,...               % ocean variable to plot
             batsBacteria.dep1,...              % y values
             datenum(batsBacteria.yymmdd),...   % x values
             xMin,xMax,xStep,...                % x limits (xmin, xmax, xstep)
             0,1000,100,...                     % y limits (ymin, ymax, ystep)
             0,0.8,0.10,...                     % colour bar limits (cmin, cmax, cstep) – mg C m-3 d-1
             1,...                              % anomaly
             'Bacteria growth rate (pmol L^{-1} h^{-1})',... % colour bar string
             'bats_bacteriagrowth')             % figure name tag
            
%%
% -------------------------------------------------------------------------
% LOCAL FUNCTIONS
% -------------------------------------------------------------------------

function plotOdvStyle(oceanVar,depthVector,dateVector,xMin,xMax,xStep,...
    yMin,yMax,yStep,cMin,cMax,cStep,cAnomaly,cbString,varName)

    % Find unique depths and dates
    uniqueDepths = unique(depthVector);
    uniqueDates = unique(dateVector);
    varOdvStyle = NaN(length(uniqueDepths),length(uniqueDates)); 
    for i = 1:height(oceanVar)
        [~, idxDepth] = ismember(depthVector(i), uniqueDepths);
        [~, idxDate] = ismember(dateVector(i), uniqueDates);
        varOdvStyle(idxDepth,idxDate) = oceanVar(i);
    end
    
    % Anomaly
    varOdvStyle_mean = mean(varOdvStyle, 2, 'omitnan'); % calculate the climatological mean (average over time at each depth)
    varOdvStyle_anomaly = varOdvStyle - varOdvStyle_mean; % subtract the mean to get the anomalies

    % Ticks
    yTickValues = yMin:yStep:yMax;
    xTickTimes = xMin:xStep:xMax;
    xTickTimesNumeric = datenum(xTickTimes);

    % .....................................................................
    
    % Create figure
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.60 0.30],'Color','w')

    % Prepare variables for plotting
    [X, Y] = meshgrid(uniqueDates, uniqueDepths); % make sure size(X) = size(Y) = size(Z)

    % Interpolate missing data
    F = scatteredInterpolant(X(~isnan(varOdvStyle)), Y(~isnan(varOdvStyle)), varOdvStyle(~isnan(varOdvStyle)), 'linear', 'none');
    Z_interp = F(X, Y); % interpolated data, filling NaN gaps

    % Plot contour
    contourLevels = cMin:cStep:cMax;
    contourf(X,Y,Z_interp,contourLevels)
    hold on;

    % Plot the original data points on top of the interpolated data
    scatter(datenum(dateVector),depthVector,0.5,'k','filled');

    % Colormap
    myColormap = brewermap(1000,'*Spectral'); % Spectral is the equivalent of Jet
    colormap(myColormap)
    caxis([cMin, cMax])

    % Remove contour lines
    h = findobj(gca, 'Type', 'Contour');
    if ~isempty(h)
        set(h, 'LineColor', 'none');
    end

    % X-axis settings
    xlim([datenum(xMin) datenum(xMax)])
    xticks(xTickTimesNumeric)
    xticklabels(datestr(xTickTimes, 'yyyy'));
    xtickangle(45)
    xlabel('Year')

    % Y-axis settings
    ylim([yMin yMax])
    yticks(yTickValues)
    yticklabels(yTickValues)
    ylabel('Depth (m)');
    axh = gca;
    axh.YAxis.TickDirection = 'out';

    set(gca,'YDir','Reverse','XAxisLocation','Bottom','FontSize', 12)

    % Add vertical lines for each January 1st
    for i = year(xMin):year(xMax)
        jan1 = datetime(i, 01, 01);
        xline(datenum(jan1), 'k', 'LineWidth', 1.5);  % 'w' for white color, adjust line width as needed
    end

    % Add box
    xLimits = xlim;
    yLimits = ylim;
    rectangle('Position', [xLimits(1), yLimits(1), diff(xLimits), diff(yLimits)], ...
        'EdgeColor', 'k', 'LineWidth', 1);

    % Colour bar settings
    cb = colorbar('Location','eastoutside');
    cb.Ticks = contourLevels;
    cb.TickLabels = arrayfun(@(x) sprintf('%.1f', x), cb.Ticks, 'UniformOutput', false);
    cb.Label.String = cbString;
    cb.Label.FontSize = 12; 

    % Save figure
    exportgraphics(gcf,fullfile('.','figures',strcat(varName,'.png')),'Resolution',600)

    % .....................................................................
    
    % Anomaly plot
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.60 0.30],'Color','w')

    % Interpolate missing data
    F = scatteredInterpolant(X(~isnan(varOdvStyle_anomaly)), Y(~isnan(varOdvStyle_anomaly)), varOdvStyle_anomaly(~isnan(varOdvStyle_anomaly)), 'linear', 'none');
    Z_interp = F(X, Y); % interpolated data, filling NaN gaps

    % Plot contour
    contourf(X,Y,Z_interp,40) % 40 is the number of contour levels
    
    % Colormap
    myColormap = brewermap(1000,'*RdBu'); % Spectral is the equivalent of Jet
    colormap(myColormap)
    caxis([-cAnomaly, cAnomaly]);

    % Remove contour lines
    h = findobj(gca, 'Type', 'Contour');
    if ~isempty(h)
        set(h, 'LineColor', 'none');
    end

    % X-axis settings
    xlim([datenum(xMin) datenum(xMax)])
    xticks(xTickTimesNumeric)
    xticklabels(datestr(xTickTimes, 'yyyy'));
    xtickangle(45)
    xlabel('Year')

    % Y-axis settings
    ylim([yMin yMax])
    yticks(yTickValues)
    yticklabels(yTickValues)
    ylabel('Depth (m)');
    axh = gca;
    axh.YAxis.TickDirection = 'out';

    set(gca,'YDir','Reverse','XAxisLocation','Bottom','FontSize', 12)

    % Add vertical lines for each January 1st
    for i = year(xMin):year(xMax)
        jan1 = datetime(i, 01, 01);
        xline(datenum(jan1), 'k', 'LineWidth', 1.5);  % 'w' for white color, adjust line width as needed
    end

    % Add box
    xLimits = xlim;
    yLimits = ylim;
    rectangle('Position', [xLimits(1), yLimits(1), diff(xLimits), diff(yLimits)], ...
        'EdgeColor', 'k', 'LineWidth', 1);

    % Colour bar settings
    cb = colorbar('Location','eastoutside');
    cb.Label.String = {'Anomaly', cbString};
    cb.Label.FontSize = 12; 

    % Save figure
    exportgraphics(gcf,fullfile('.','figures',strcat('anomaly_',varName,'.png')),'Resolution',600)  

end % plotOdvStyle

% *************************************************************************

function plotVariableOverTime(x,y,xMin,xMax,xStep,yMin,yMax,yStep,...
    yLabelString,figureName)

    % Ticks
    xTickTimes = xMin:xStep:xMax;
    xTickTimesNumeric = datenum(xTickTimes);
    yTickValues = yMin:yStep:yMax;

    % Plot
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.50 0.25],'Color','w') 
    plot(datenum(x),y,'r');
    
    % X-axis settings
    xlim([datenum(xMin) datenum(xMax)])
    xticks(xTickTimesNumeric)
    xticklabels(datestr(xTickTimes, 'yyyy'));
    xtickangle(45)
    xlabel('Year')

    % Y-axis settings
    ylim([yMin yMax])
    yticks(yTickValues)
    yticklabels(yTickValues)
    ylabel(yLabelString);
    
    % Add vertical lines for each January 1st
    for i = year(xMin):year(xMax)
        jan1 = datetime(i, 1, 1);
        xline(datenum(jan1), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5);
    end
    
    set(gca,'FontSize', 12)

    % Save figure
    exportgraphics(gcf,fullfile('.','figures',figureName),'Resolution',600)

end % plotVariableOverTime

% *************************************************************************

function plotVariablesOverTimeInOnePlot(B,T,D,oceanVarsLabel,...
    xMin,xMax,xStep,yMin,yMax,yStep,yLabelStr,titleStr,legendStr,figureName)                             
        
    % Ticks
    xTickTimes = xMin:xStep:xMax;
    xTickTimesNumeric = datenum(xTickTimes);
    yTickValues = yMin:yStep:yMax;

    myColorscheme = brewermap(height(oceanVarsLabel),'*Paired');

    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.70 0.30],'Color','w')
    ax = axes('Position', [0.08 0.17 0.74 0.74]); 

    for iVar = 1:height(oceanVarsLabel)
        varName   = oceanVarsLabel{iVar,1};
        varValues = B.(varName)(D == 100);
        varDates  = T(D == 100);
        plot(ax,datenum(varDates),varValues,'Color',myColorscheme(iVar,:),'LineWidth',1.5)
        hold on
    end 
    hold off

    % X-axis settings
    xlim([datenum(xMin) datenum(xMax)])
    xticks(xTickTimesNumeric)
    xticklabels(datestr(xTickTimes, 'yyyy'));
    xtickangle(45)
    xlabel('Year')

    % Y-axis settings
    ylim([yMin yMax])
    yticks(yTickValues)
    yticklabels(yTickValues)
    ylabel(yLabelStr);

    % Add vertical lines for each January 1st
    for i = year(xMin):year(xMax)
        jan1 = datetime(i, 1, 1);
        xline(datenum(jan1), 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5);
    end

    title(titleStr)
    
    set(gca,'FontSize', 12)

    lg = legend(legendStr,'NumColumns', 1);
    lg.Position(1) = 0.82; lg.Position(2) = 0.52;
    lg.Orientation = 'vertical';
    lg.ItemTokenSize = [11,1];
    lg.FontSize = 11; 
    lg.Box = 'off';

    % Save the figure
    exportgraphics(gcf,fullfile('.','figures',figureName),'Resolution',600)

end % plotVariablesOverTimeInOnePlot

% *************************************************************************

function plotTrends(x,y,yLabelString,figureName)

    % Detect and replace outliers in data
    yFill = filloutliers(y,'clip','movmedian',days(7),'SamplePoints',x);

    % Fit a linear trend to the data once all NaNs have been removed
    xd = datenum(x); % transform datetime into double
    [p,S,mu] = polyfit(xd(~isnan(yFill)),yFill(~isnan(yFill)),1);
    yTrend = polyval(p,xd,S,mu);

    % Get statistics of the fit
    slope = p(1);
    yMean = mean(yFill(~isnan(yFill)));              % Mean of observed data
    SSres = sum((yFill(~isnan(yFill)) - yTrend(~isnan(yFill))).^2); % Sum of squared residuals
    SStot = sum((yFill(~isnan(yFill)) - yMean).^2);  % Total sum of squares
    R2 = 1 - (SSres / SStot);                        % R^2 value

    % Calculate seasonal cycle (use the 'climatology' function in the 
    % Climate Data Toolbox for Matlab) 
    ynonnan = yFill;
    ynonnan(isnan(ynonnan)) = 0;
    ySeasonalCycle = climatology(ynonnan,x,'full');

    % Prepare axes environment
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.50 0.25],'Color','w')
    ax = axes('Position', [0.09 0.14 0.70 0.74]); 
    hold on

    % Plot the data
    p1 = plot(ax,x,ySeasonalCycle,'Color','#5aae61','LineWidth',1.0); hold on;
    p2 = scatter(ax,x,yFill,2,'k','filled'); hold on;
    p3 = plot(ax,x,yTrend,'Color',[0 0 1],'LineWidth',1.5); hold off; % same as polyplot

    % Axis settings
    xlim([x(1) x(end)])
    ylim([0 max(ySeasonalCycle)+max(ySeasonalCycle)*0.50]) % ylim([0 max(ySeasonalCycle)+max(ySeasonalCycle)*0.20])
    yl = ylabel(yLabelString);
    yl.Position(1) = yl.Position(1) - 200;

    box on

    % Add legend
    lg = legend([p2 p1 p3], {'Data','Seasonal cycle','Trend'},'FontSize',12);
    lg.Orientation = 'vertical';
    lg.Position(1) = 0.79; lg.Position(2) = 0.69;
    lg.ItemTokenSize = [15,1];
    set(lg,'Box','off')

    % Add R^2 and slope to the figure
    slopeText = sprintf('Slope: %.1f', slope); 
    R2Text = sprintf('R^2: %.3f', R2);  
    text(ax, x(end-100), max(ySeasonalCycle) + 0.2*max(ySeasonalCycle), slopeText, 'FontSize', 12, 'Color', 'k');
    text(ax, x(end-100), max(ySeasonalCycle) + 0.1*max(ySeasonalCycle), R2Text, 'FontSize', 12, 'Color', 'k');

    set(gca,'FontSize',12)
    
    % Save the figure
    exportgraphics(gcf,fullfile('.','figures',figureName),'Resolution',600)

end % plotTrends

% *************************************************************************

function plotCycles(x,y,yMin,yMax,yLabelStr,figureName)

    % Prepare axes environment
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.30 0.30],'Color','w')
    ax = axes('Position', [0.15 0.16 0.74 0.74]); 
    hold on

    % Plot       
    scatter(ax,doy(datenum(x)),y,10,datenum(x),'filled')
    xlim([1 365])   
    ylim([yMin yMax])

    yearsInRange = unique(year(x));
    nYearsInRange = numel(yearsInRange);
    cmap = brewermap(nYearsInRange,'*GnBu');
    colormap(cmap)

    tickAndLabelFreq = 3;
    cb = colorbar;
    cbdate('yyyy')
    dTk = diff(cb.Limits)/(tickAndLabelFreq*length(cmap));
    cbTicks = cb.Limits(1)+dTk:tickAndLabelFreq*dTk:cb.Limits(2)-dTk;
    
    % Only show tick labels every 3 years when there are more than 12
    % years on display, so that the colour bar does not look too crammed
    cbTickLabels = cell(size(yearsInRange));
    if (nYearsInRange > 12)
        % Set labels for every three years and leave the rest empty
        for i = 1:length(yearsInRange)
            if mod(i - 1, tickAndLabelFreq) == 0 % Check if the index is in our freq (0, 3, 6, ...)
                cbTickLabels{i} = num2str(yearsInRange(i));
            else
                cbTickLabels{i} = ''; % Leave the label empty
            end
        end
    else
        cbTickLabels = string(yearsInRange);
    end
    set(cb,'Ticks',cbTicks,'TickLabels',cbTickLabels)

    ylabel(yLabelStr,'FontSize',12);
    xlabel('Day of the year','FontSize',12);

    box on

    % Save the figure
    exportgraphics(gcf,fullfile('.','figures',figureName),'Resolution',600)
    
end % plotCycles

% *************************************************************************

function plotAnomalies(timeVector,oceanVar,yMin,yMax,yStep,yUnits,figureName)

    % Calculate climatological means (by year/month)
    TT = timetable(timeVector,oceanVar);
    yearlyMean = retime(TT,'yearly','mean');
    monthlyMean = retime(TT,'monthly','mean');

    % Variables to plot
    x = unique(year(timeVector)); 
    y = yearlyMean.oceanVar;

    % Colours for bars
    positiveColor = '#31a354';
    negativeColor = '#08519c';

    % ytick configuration
    if (yMax > 30)
        yStep = 20;
        yTickFmt = '%.0f%%';
    elseif (yMax > 20 && yMax <= 30)
        yStep = 10;
        yTickFmt = '%.0f%%';
    elseif (yMax > 10 && yMax <= 20)
        yStep = 5;
        yTickFmt = '%.0f%%';
    elseif (yMax <= 10 && yMax > 2)
        yStep = 2;
        yTickFmt = '%.0f%%';
    elseif (yMax <= 2)
         yStep = 0.5;
         yTickFmt = '%.1f%%';
    end

    % Calculate annual mean
    longTermMean = mean(y,'omitnan');
    diffFromLongTermMean = 100*((y - longTermMean)/longTermMean);
    idxPositiveYears = diffFromLongTermMean >= 0;
    idxNegativeYears = diffFromLongTermMean < 0;

    % Prepare axes environment
    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.30 0.30],'Color','w')
    ax = axes('Position', [0.15 0.15 0.75 0.75]); 
    hold on

    % Plot bars: annual deviation from the long-term mean
    h = bar(ax,x,diag(diffFromLongTermMean),'stacked','BaseValue',0);
    hold on
    set(h(idxPositiveYears),'FaceColor',positiveColor) 
    set(h(idxNegativeYears),'FaceColor',negativeColor)

    % Plot fit line on top
    time = datenum(x); % transform datetime into double
    [p,str,mu] = polyfit(time(~isnan(diffFromLongTermMean)),diffFromLongTermMean(~isnan(diffFromLongTermMean)),1);
    yDiffTrend = polyval(p,time,str,mu);
    plot(ax,x,yDiffTrend,'Color','k','LineWidth',2);
    hold off

    % Axis arrangement
    yLim = [yMin yMax];
    yTicks = (yMin:yStep:yMax);
    yTickLabels = arrayfun(@(y) sprintf(yTickFmt, y), yTicks, 'UniformOutput', false);

    ylim(yLim)
    yticks(yTicks)
    yticklabels(yTickLabels)

    grid on

    firstYear = x(1);
    lastYear = x(end);

    % Add text annotation for the average
    textString = strcat(num2str(firstYear, '%.0f'), '–', ...
                        num2str(lastYear, '%.0f'), ' avg:', {' '}, ...
                        num2str(longTermMean, '%.0f'), {' '}, yUnits);

    % Use annotation to place text outside the plot
    annotation('textbox', [0.50, 0.90, 0.1, 0.1], ... % Position [x, y, width, height] in normalized figure units
           'String', textString, ...
           'FontSize', 11, ...
           'FontWeight', 'bold', ...
           'HorizontalAlignment', 'left', ...
           'VerticalAlignment', 'top', ...
           'EdgeColor', 'none'); % 'none' to remove the border around the text
       
    % Define the components of the ylabel
    yl = ylabel('Difference from the running average');
    yl.Position(1) = yl.Position(1) - 0.001*yl.Position(1);
    
    set(gca,'FontSize',12)

    box on

    % Save the figure
    exportgraphics(gcf,fullfile('.','figures',figureName),'Resolution',600)

end % plotAnomalies

% *************************************************************************

function plotZooplankton(batsZooDepthIntegrated,xMin,xMax,xStep,yMin,yMax,yStep)

    % Ticks
    xTickTimes = xMin:xStep:xMax;
    yTickValues = yMin:yStep:yMax;

    [uniqueSizeCategories, ~, ~] = unique(batsZooDepthIntegrated.sizeCategoryGroup);
    nSizeCategories = numel(uniqueSizeCategories);

    myColorscheme = brewermap(nSizeCategories,'*YlOrRd');

    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.50 0.50],'Color','w') 
    haxis = zeros(2,1);

    for iSubplot = 1:2

        haxis(iSubplot) = subaxis(2,1,iSubplot,'Spacing',0.01,'Padding',0.03,'Margin',0.10);

        for iSizeCategory = 1:nSizeCategories

            thisSizeCategory = uniqueSizeCategories(iSizeCategory);

            % Filter data based on size category and time of day
            if iSubplot == 1
                timeCondition = strcmp(batsZooDepthIntegrated.dayNightGroup, 'day');
            else
                timeCondition = strcmp(batsZooDepthIntegrated.dayNightGroup, 'night');
            end

            % Extract x and y data
            x = batsZooDepthIntegrated.cruiseGroup(batsZooDepthIntegrated.sizeCategoryGroup == thisSizeCategory & timeCondition);
            y = batsZooDepthIntegrated.zooAvgBiomass(batsZooDepthIntegrated.sizeCategoryGroup == thisSizeCategory & timeCondition);

            plot(haxis(iSubplot),x,y,'Color',myColorscheme(iSizeCategory,:),'LineWidth',1.5); hold on;
        end
        hold off

        % X-axis settings
        xticks(xTickTimes)
        if (iSubplot == 2)  
            xtickangle(45)
            xlabel('Year')
        elseif (iSubplot == 1)
            xticklabels([])
        end

        % Y-axis settings
        ylim([yMin yMax])
        yticks(yTickValues)
        yticklabels(yTickValues)
        ylabel('mg DW m^{-2}','FontSize',12);

        if (iSubplot == 1)
            title('Day mesozooplankton biomass','FontSize',12)
        elseif (iSubplot == 2)
            title('Night mesozooplankton biomass','FontSize',12)
        end

        % Add vertical lines for each January 1st
        for i = year(xMin):year(xMax)
            jan1 = datetime(i, 1, 1);
            xline(jan1, 'Color', [0.5, 0.5, 0.5], 'LineWidth', 1.5);
        end

        set(gca,'FontSize', 12)

        % Display grid lines
        grid on; 
        ax = gca; 
        % Enable only horizontal grid lines
        ax.XGrid = 'off';
        ax.YGrid = 'on';

    end

    lg = legend('>0.2 mm','>0.5 mm','>1 mm','>2 mm','>5 mm','NumColumns', 1);
    lg.Position(1) = 0.87; lg.Position(2) = 0.72;
    lg.Orientation = 'vertical';
    lg.ItemTokenSize = [11,1];
    lg.FontSize = 11; 
    lg.Box = 'off';

    % Save figure
    exportgraphics(gcf,fullfile('.','figures','zoo_biomass.png'),'Resolution',600) 

end % plotZooplankton

% *************************************************************************