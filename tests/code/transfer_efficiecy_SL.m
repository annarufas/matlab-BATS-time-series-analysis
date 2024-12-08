
% ----------------------------------------------------------------------- %
% Visualization of BATS and OFP Flux Data                                 %
% ----------------------------------------------------------------------- %
% This script visualizes BATS and OFP flux data from their respective     %
% observation start dates and investigates the relationship between NPP   % 
% and effective temperature (Teff) through the ocean column (500–1500 m). %
%                                                                         %
%   WRITTEN BY S. LI, UNIVERISTY OF OXFORD                                %
%                                                                         %
%   Version 1.0 - Completed 26 Nov 2024                                   %
%                                                                         %
% ======================================================================= %

close all; clear; clc;

% -------------------------------------------------------------------------
% Load Data into Tables
% -------------------------------------------------------------------------
% BATS flux data
filenameBATSFlux = 'bats_flux_v003.txt';
batsFlux = processRawBatsFlux(filenameBATSFlux);

% OFP flux data
filenameFluxOfp = 'OFP_particle_flux.csv';
ofpFlux = processRawOfpFlux(filenameFluxOfp);

% NPP data
filenameNPP = 'bats_primary_production_v003.txt';
[nppFlux, batsNppDepthIntegrated] = processRawBatsNpp(filenameNPP);

% -------------------------------------------------------------------------
% Visualization: NPP (BATS Primary Production)
% -------------------------------------------------------------------------
xMin = datetime(1989, 01, 01);
xMax = datetime(2023, 06, 01);
xStep = calyears(2);
% xMin = datetime(1989,01,01);   % start date for plotting
% xMax = datetime(2023,06,01);   % end date for plotting
% xStep = calyears(2);           % X-axis step (years)
% 
% plotOdvStyle(nppFlux.pp,...                 % ocean variable to plot
%              nppFlux.dep1,...               % y values
%              datenum(nppFlux.yymmdd_in),... % x values
%              xMin,xMax,xStep,...            % x limits (xmin, xmax, xstep)
%              0,150,25,...                   % y limits (ymin, ymax, ystep)
%              0,20,2.5,...                   % colour bar limits (cmin, cmax, cstep) – mg C m-3 d-1
%              5,...                          % anomaly
%              'NPP (mg C m^{-3} d^{-1})',... % colour bar string
%              'bats_npp')                    % figure name tag

% -------------------------------------------------------------------------
% Visualization: BATS Flux Data
% -------------------------------------------------------------------------
% % Plotting configuration
% xMin = datetime(2013,01,01);
% xMax = datetime(2023,06,01);
% xStep = calyears(2);
% 
% % Define variables for plotting: (table variable name | plot label)
% oceanVarsLabel = {'Mavg', 'Mass flux (mg m^{-2} d^{-1})';...
%                   'Cavg', 'POC flux (mg C m^{-2} d^{-1})'};
% 
% % Colour bar adjustment              
% cMin     = [  0,   0];
% cMax     = [200, 100];
% cStep    = [ 20,   5];  
% cAnomaly = [100, 100];
% 
% % Depth axis
% yMin = 150;
% yMax = 300;
% yStep = 25;
% 
% for iVar = 1:height(oceanVarsLabel) 
% 
%     varName   = oceanVarsLabel{iVar,1};
%     varLabel  = oceanVarsLabel{iVar,2};
%     varValues = batsFlux.(varName);
%     varDepths = batsFlux.dep;
%     varDates  = datenum(batsFlux.yymmdd1);
% 
%     plotOdvStyle(varValues,...                         % ocean variable to plot
%                  varDepths,...                         % y values
%                  varDates,...                          % x values
%                  xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
%                  yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
%                  cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
%                  cAnomaly(iVar),...                    % anomaly
%                  varLabel,...                          % colour bar string
%                  strcat('bats_flux',varName))          % figure name tag
% 
% end

% -------------------------------------------------------------------------
% Visualization: OFP Flux Data
% -------------------------------------------------------------------------
% xMin = datetime(2002,01,01);
% xMax = datetime(2020,05,19);
% xStep = calyears(2);
% 
% % Define variables for plotting: (table variable name | plot label)
% oceanVarsLabel = {'MassFlux', 'Total mass flux (mg m^{-2} d^{-1})';...
%                   'CorgFlux', 'POC flux (mg C m^{-2} d^{-1})';...
%                   'CarbFlux', 'CaCO_3 flux (mg CaCO_3 m^{-2} d^{-1})';...
%                   'OpalFlux', 'bSi flux (mg bSi m^{-2} d^{-1})';...
%                   'LithFlux', 'Lithogenic flux (mg m^{-2} d^{-1})'};
% 
% % .........................................................................
% 
% % Plot ODV style
% 
% % Colour bar adjustment              
% cMin     = [  0,   0,   0,  0,   0];
% cMax     = [150,   5, 100, 10,   5];
% cStep    = [ 25, 0.5,  10,  1, 0.5];  
% cAnomaly = [50,    2,  50,  5,   5];
% 
% % Depth axis
% yMin = 500;
% yMax = 3200;
% yStep = 500;
% 
% for iVar = 1:height(oceanVarsLabel) 
% 
%     varName   = oceanVarsLabel{iVar,1};
%     varLabel  = oceanVarsLabel{iVar,2};
%     varValues = ofpFlux.(varName);
%     varDepths = ofpFlux.depth;
%     varDates  = datenum(ofpFlux.Mid_Date);
% 
%     plotOdvStyle(varValues,...                         % ocean variable to plot
%                  varDepths,...                         % y values
%                  varDates,...                          % x values
%                  xMin,xMax,xStep,...                   % x limits (xmin, xmax, xstep)
%                  yMin,yMax,yStep,...                   % y limits (ymin, ymax, ystep)
%                  cMin(iVar),cMax(iVar),cStep(iVar),... % colour bar limits (cmin, cmax, cstep) 
%                  cAnomaly(iVar),...                    % anomaly
%                  varLabel,...                          % colour bar string
%                  strcat('ofp_flux',varName))           % figure name tag
% 
% end
% 
% % .........................................................................
% 
% % Plot varibles at 500 m depth over time 
% 
% % Y-axis adjustment
% yMin     = [  0,   0,   0,  0, 0];
% yMax     = [250,  18, 200, 10, 6];
% yStep    = [ 25, 2.5,  20,  1, 1];  
% 
% for iVar = 1:height(oceanVarsLabel) 
% 
%     varName   = oceanVarsLabel{iVar,1};
%     varLabel  = oceanVarsLabel{iVar,2};
%     varValues = ofpFlux.(varName)(ofpFlux.depth == 500);
%     varDates  = ofpFlux.Mid_Date(ofpFlux.depth == 500);
% %     disp(mean(varValues,'omitnan'))
% %     disp(std(varValues,'omitnan'))
% 
%     plotVariableOverTime(varDates(~isnan(varValues)),...          % x values
%                          varValues(~isnan(varValues)),...         % y values
%                          xMin,xMax,xStep,...                      % x limits (xmin, xmax, xstep)
%                          yMin(iVar),yMax(iVar),yStep(iVar),...    % y limits (ymin, ymax, ystep) - mg C m-2 d-1
%                          varLabel,...                             % y-label
%                          strcat('ofp_flux_500m_',varName,'.png')) % figure name
% 
% end 


% -------------------------------------------------------------------------
% Calculate Transfer Efficiency (Teff) from 150m to 1500m
% -------------------------------------------------------------------------
% Depth Filtering
ofpFluxFiltered = ofpFlux(ofpFlux.depth == 1500, :);  
batsFluxFiltered = batsFlux(batsFlux.dep == 150, :); 

% Retain only relevant columns
% Keep only 'Start_Date' and 'CarbFlux' for ofpFlux
ofpFluxFiltered = ofpFluxFiltered(:, {'Start_Date', 'CarbFlux'});
% Keep only 'yymmdd1' and 'Cavg' for BATS
batsFluxFiltered = batsFluxFiltered(:, {'yymmdd1', 'Cavg'});

%% Convert date columns to datetime
ofpFluxFiltered.Start_Date = datetime(ofpFluxFiltered.Start_Date, 'InputFormat', 'yyyy-MM-dd'); 
batsFluxFiltered.yymmdd1 = datetime(batsFluxFiltered.yymmdd1, 'InputFormat', 'yyyy-MM-dd'); 

%% Match dates within one-week tolerance
% Initialise a new table to store the matched results
matchedData = [];

for i = 1:height(ofpFluxFiltered)
    currentDate = ofpFluxFiltered.Start_Date(i);
    
    % Find rows in batsFluxFiltered where yymmdd1 is within +/- 6 days of currentDate
    matchingRows = abs(batsFluxFiltered.yymmdd1 - currentDate) <= days(6); 
    % This has been adjuested manually
    % To make sure there will not be one start time corresponding to two
    % dates in OFP dataset
    
    if any(matchingRows)
        matchedRows = batsFluxFiltered(matchingRows, :);
        matchedRows.CarbFlux = repmat(ofpFluxFiltered.CarbFlux(i), height(matchedRows), 1);
        matchedRows.Start_Date = repmat(ofpFluxFiltered.Start_Date(i), height(matchedRows), 1);
        matchedData = [matchedData; matchedRows]; % Append to the final matched data
    end
end

% Remove rows with no matches
matchedData = unique(matchedData, 'rows');
matchedData = sortrows(matchedData, 'yymmdd1'); % Sort by the date from batsFlux

% Calculate transfer efficiency 
matchedData.Teff = matchedData.CarbFlux ./ matchedData.Cavg;

% Remove rows with NaN values in any column
matchedData = rmmissing(matchedData);

% -------------------------------------------------------------------------
% Plot Transfer Efficiency Over Time
% -------------------------------------------------------------------------
figure;
plot(matchedData.yymmdd1, matchedData.Teff, '-*', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Teff');
title('Transfer Efficiency Over Time');
grid on;
xtickformat('yyyy-MM'); % Show as yyyymm format on the x-axis

% -------------------------------------------------------------------------
% Analyze Relationship Between Teff and Primary Production (NPP)
% -------------------------------------------------------------------------

% % Extract Net Primary Productivity (NPP) from the dataset
% batsNppDepthIntegrated.date = datetime(batsNppDepthIntegrated.date, 'InputFormat', 'yyyy-MM-dd'); % Convert date to datetime
% batsNppDepthIntegrated = rmmissing(batsNppDepthIntegrated);
% 
% % Plot Teff against yymmdd1
% figure;
% yyaxis left; % Use left y-axis for Teff
% plot(matchedData.yymmdd1, matchedData.Teff, '-*', 'LineWidth', 1.5, 'Color', 'b');
% ylabel('Teff');
% xlabel('Time');
% title('Transfer Efficiency and Primary Production Over Time');
% grid on;
% 
% % Plot pp against yymmdd_in
% yyaxis right; % Use right y-axis for Primary Production (NPP_mg_C_m2_d)
% plot(batsNppDepthIntegrated.date, batsNppDepthIntegrated.NPP_mg_C_m2_d, '-o', 'LineWidth', 1.5, 'Color', 'r');
% ylabel('Primary Production (pp)');
% 
% % Format the x-axis for better readability
% xtickformat('yyyy-MM'); % Show as yyyy-mm format on the x-axis
% legend('Teff', 'Primary Production (pp)', 'Location', 'Best');

% -------------------------------------------------------------------------
% Plot Teff and NPP
% -------------------------------------------------------------------------
batsNppDepthIntegrated.date = datetime(batsNppDepthIntegrated.date, 'InputFormat', 'yyyy-MM-dd'); % Convert date to datetime
batsNppDepthIntegrated = rmmissing(batsNppDepthIntegrated);

figure;
yyaxis left; 
plot(matchedData.yymmdd1, matchedData.Teff, '-*', 'LineWidth', 1.5, 'Color', 'b');
ylabel('Teff (Transport Efficiency)');
yyaxis right; 

% Extract NPP values corresponding to Teff dates
matchingNPP = arrayfun(@(date) ...
    mean(batsNppDepthIntegrated.NPP_mg_C_m2_d(abs(batsNppDepthIntegrated.date - date) <= days(7)), 'omitnan'), ...
    matchedData.yymmdd1);

plot(matchedData.yymmdd1, matchingNPP, '-o', 'LineWidth', 1.5, 'Color', 'r');
ylabel('Primary Production (NPP, mg C m^{-2} d^{-1})'); 
xlabel('Date (Teff)');
title('Transfer Efficiency and Primary Production Over Time');
grid on;
xtickformat('yyyy-MM'); 
legend('Teff', 'Primary Production (NPP)', 'Location', 'Best');


%% Correlate the dates for batsNppDepthIntegrated and matchedData
% Initialize a new table to store the correlated data
correlatedData = [];

% Loop over each row in matchedData to find matching dates in batsNppDepthIntegrated
for i = 1:height(matchedData)
    % Get the current yymmdd1 date
    currentDate = matchedData.yymmdd1(i);
    
    % Find rows in batsNppDepthIntegrated where date is within +/- 7 days of currentDate
    matchingRows = abs(batsNppDepthIntegrated.date - currentDate) <= days(7);
    
    % If there are matching rows, append them to the correlatedData table
    if any(matchingRows)
        matchedRows = batsNppDepthIntegrated(matchingRows, :);
        % Add the corresponding Teff and yymmdd1 from matchedData to the matchedRows
        matchedRows.Teff = repmat(matchedData.Teff(i), height(matchedRows), 1);
        matchedRows.Matched_Date = repmat(currentDate, height(matchedRows), 1);
        correlatedData = [correlatedData; matchedRows]; % Append to the final correlated data
    end
end

correlatedData = unique(correlatedData, 'rows');
correlatedData = sortrows(correlatedData, 'Matched_Date'); % Sort by the matched date

% Plot Correlation of Teff and NPP_mg_C_m2_d
figure;
scatter(correlatedData.NPP_mg_C_m2_d, correlatedData.Teff, 'filled');
xlabel('Primary Production (NPP, mg C m^{-2} d^{-1})');
ylabel('Transfer Efficiency (Teff)');
title('Correlation between Net Primary Production and Transfer Efficiency');
grid on;

% Compute and display correlation coefficient
correlationCoefficient = corr(correlatedData.NPP_mg_C_m2_d, correlatedData.Teff, 'Rows', 'complete');
disp(['Correlation Coefficient: ', num2str(correlationCoefficient)]);


% -------------------------------------------------------------------------
% Plot one specific-year NPP and Teff plot and their correlation
% -------------------------------------------------------------------------

yearToPlot = 2014; % Replace with the year you want to visualize
plotNPPandTeffForYear(matchedData, batsNppDepthIntegrated, yearToPlot);

% -------------------------------------------------------------------------
% Correlation Coefficients Table (1990 - 2020)
% -------------------------------------------------------------------------
% Initialize results table
resultsTable = table('Size', [0 2], 'VariableTypes', {'double', 'double'}, ...
                     'VariableNames', {'Year', 'CorrelationCoefficient'});

% Loop over each year
for yearToPlot = 1990:2020
    % Filter matchedData for the specific year
    filteredTeffData = matchedData(year(matchedData.yymmdd1) == yearToPlot, :);
    
    % Filter batsNppDepthIntegrated for the specific year
    filteredNppData = batsNppDepthIntegrated(year(batsNppDepthIntegrated.date) == yearToPlot, :);
    
    % Check if data exists for the specified year
    if isempty(filteredTeffData) || isempty(filteredNppData)
        % Append NaN for the correlation if no data is available
        resultsTable = [resultsTable; {yearToPlot, NaN}];
        continue;
    end

    % Match dates within the filtered data for correlation calculation
    correlatedData = [];
    for i = 1:height(filteredTeffData)
        % Get the current date from filteredTeffData
        currentDate = filteredTeffData.yymmdd1(i);
        
        % Find rows in filteredNppData where date is within +/- 7 days
        matchingRows = abs(filteredNppData.date - currentDate) <= days(7);
        
        % If matching rows exist, store the matched NPP and Teff values
        if any(matchingRows)
            matchedNpp = mean(filteredNppData.NPP_mg_C_m2_d(matchingRows), 'omitnan');
            correlatedData = [correlatedData; filteredTeffData.Teff(i), matchedNpp]; %#ok<AGROW>
        end
    end

    % Compute correlation if correlatedData is not empty
    if ~isempty(correlatedData)
        TeffValues = correlatedData(:, 1);
        NppValues = correlatedData(:, 2);

        % Compute correlation coefficient
        correlationCoefficient = corr(TeffValues, NppValues, 'Rows', 'complete');
    else
        correlationCoefficient = NaN; % Assign NaN if no matching data
    end

    % Append the year and correlation coefficient to the results table
    resultsTable = [resultsTable; {yearToPlot, correlationCoefficient}];
end

% Display the results
disp(resultsTable);

% ------------------------------------------------------------------------
%                             Function 
% ------------------------------------------------------------------------
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

% Function to plot NPP and Teff for a specific year and calculate their correlation
function plotNPPandTeffForYear(matchedData, batsNppDepthIntegrated, yearToPlot)
    % Filter the matchedData for the specific year
    filteredTeffData = matchedData(year(matchedData.yymmdd1) == yearToPlot, :);
    
    % Filter the batsNppDepthIntegrated data for the specific year
    filteredNppData = batsNppDepthIntegrated(year(batsNppDepthIntegrated.date) == yearToPlot, :);

    % Check if data exists for the specified year
    if isempty(filteredTeffData) || isempty(filteredNppData)
        warning(['No data available for the year ', num2str(yearToPlot)]);
        return;
    end
    
    % Plot Teff and NPP over time for the specified year
    figure;
    yyaxis left; % Use left y-axis for Teff
    plot(filteredTeffData.yymmdd1, filteredTeffData.Teff, '-*', 'LineWidth', 1.5, 'Color', 'b');
    ylabel('Teff');
    xlabel('Time');
    title(['Transfer Efficiency and Primary Production for Year ', num2str(yearToPlot)]);
    grid on;

    yyaxis right; % Use right y-axis for Primary Production (NPP)
    plot(filteredNppData.date, filteredNppData.NPP_mg_C_m2_d, '-o', 'LineWidth', 1.5, 'Color', 'r');
    ylabel('Primary Production (NPP, mg C m^{-2} d^{-1})');

    % Format the x-axis for better readability
    xtickformat('yyyy-MM'); % Show as yyyy-mm format on the x-axis
    legend('Teff', 'Primary Production (NPP)', 'Location', 'Best');

    % Match the dates within the filtered data for correlation calculation
    correlatedData = [];
    for i = 1:height(filteredTeffData)
        % Get the current date from filteredTeffData
        currentDate = filteredTeffData.yymmdd1(i);
        
        % Find rows in filteredNppData where date is within +/- 7 days
        matchingRows = abs(filteredNppData.date - currentDate) <= days(7);
        
        % If matching rows exist, store the matched NPP and Teff values
        if any(matchingRows)
            matchedNpp = mean(filteredNppData.NPP_mg_C_m2_d(matchingRows), 'omitnan');
            correlatedData = [correlatedData; filteredTeffData.Teff(i), matchedNpp]; %#ok<AGROW>
        end
    end

    % Calculate and display the correlation if correlatedData is not empty
    if ~isempty(correlatedData)
        TeffValues = correlatedData(:, 1);
        NppValues = correlatedData(:, 2);

        % Compute correlation coefficient
        correlationCoefficient = corr(TeffValues, NppValues, 'Rows', 'complete');
        disp(['Correlation Coefficient for ', num2str(yearToPlot), ': ', num2str(correlationCoefficient)]);
        
        % Scatter plot to visualize the correlation
        figure;
        scatter(NppValues, TeffValues, 'filled');
        xlabel('Primary Production (NPP, mg C m^{-2} d^{-1})');
        ylabel('Transfer Efficiency (Teff)');
        title(['Correlation between Primary Production and Transfer Efficiency (Year ', num2str(yearToPlot), ')']);
        grid on;
    else
        warning(['No sufficient matching data for correlation in the year ', num2str(yearToPlot)]);
    end
end