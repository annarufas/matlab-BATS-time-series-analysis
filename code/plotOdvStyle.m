function plotOdvStyle(oceanVar,depthVector,dateVector,xMin,xMax,xStep,...
    yMin,yMax,yStep,cMin,cMax,cStep,cAnomaly,cbString,varName)

% PLOTODVSTYLE Plots an oceanographic variable following the style of the 
% Ocean Data View (ODV) platform.

    % Preprocess data: find unique depths and dates
    uniqueDepths = unique(depthVector);
    uniqueDates = unique(dateVector);
    varOdvStyle = NaN(length(uniqueDepths),length(uniqueDates)); 
    for i = 1:height(oceanVar)
        [~, idxDepth] = ismember(depthVector(i), uniqueDepths);
        [~, idxDate] = ismember(dateVector(i), uniqueDates);
        varOdvStyle(idxDepth,idxDate) = oceanVar(i);
    end
    
    % Calculate anomalies
    varOdvStyle_mean = mean(varOdvStyle, 2, 'omitnan'); % calculate the climatological mean (average over time at each depth)
    varOdvStyle_anomaly = varOdvStyle - varOdvStyle_mean; % subtract the mean to get the anomalies

    % Ticks
    yTickValues = yMin:yStep:yMax;
    xTickValues = xMin:xStep:xMax;
    
    % Plot the data as they are
    createPlot(varOdvStyle,depthVector,dateVector,uniqueDepths,uniqueDates,...
        xMin,xMax,yMin,yMax,cMin,cMax,cStep,cbString,varName,...
        xTickValues,yTickValues,false);
           
    % Plot the anomaly data
    createPlot(varOdvStyle_anomaly,depthVector,dateVector,uniqueDepths,uniqueDates,...
        xMin,xMax,yMin,yMax,-cAnomaly,cAnomaly,cStep,cbString,['anomaly_' varName],...
        xTickValues,yTickValues,true);
           
end % plotOdvStyle

% =========================================================================
%%
% -------------------------------------------------------------------------
% LOCAL FUNCTION
% -------------------------------------------------------------------------

function createPlot(varData,depthVector,dateVector,uniqueDepths,uniqueDates,...
    xMin,xMax,yMin,yMax,cMin,cMax,cStep,cbString,varName,xTickValues,...
    yTickValues,isAnomalyPlot)
    
    % Create figure
    figure()
    set(gcf, 'Units', 'Normalized', 'Position', [0.01 0.05 0.60 0.30], 'Color', 'w')
    
    % Prepare grid for interpolation
    [X, Y] = meshgrid(uniqueDates, uniqueDepths);  % make sure size(X) = size(Y)
    
    % Interpolate missing data
    F = scatteredInterpolant(X(~isnan(varData)),Y(~isnan(varData)),...
        varData(~isnan(varData)),'linear','none');
    Z_interp = F(X, Y);

    % Plot contour
    contourLevels = cMin:cStep:cMax;
    contourf(X, Y, Z_interp, contourLevels)
    hold on;

    % Plot original data points on top of the interpolated data
    scatter(datenum(dateVector), depthVector, 1.5, 'k', 'filled');

    % Set colormap
    if isAnomalyPlot
        myColormap = brewermap(1000, '*RdBu');  % Use diverging colormap for anomalies
        caxis([-cMax, cMax]);
    else
        myColormap = brewermap(1000, '*Spectral');
        caxis([cMin, cMax]);
    end
    colormap(myColormap);

    % Remove contour lines
    h = findobj(gca, 'Type', 'Contour');
    if ~isempty(h)
        set(h, 'LineColor', 'none');
    end

    % Set axis properties
    xlim([datenum(xMin) datenum(xMax)])
    xticks(datenum(xTickValues))
    xticklabels(datestr(xTickValues, 'yyyy'));
    xtickangle(45)
    xlabel('Year')

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
        xline(datenum(jan1), 'k', 'LineWidth', 1.5);
    end

    % Add box
    xLimits = xlim;
    yLimits = ylim;
    rectangle('Position', [xLimits(1), yLimits(1), diff(xLimits), diff(yLimits)], ...
        'EdgeColor', 'k', 'LineWidth', 1);

    % Add colorbar
    cb = colorbar('Location', 'eastoutside');
    cb.Ticks = contourLevels;
    if cMax < 5 || cStep < 1  
        format = '%.1f';
    elseif cMax >= 5 || cStep >= 1  
        format = '%.0f';
    end
    cb.TickLabels = arrayfun(@(x) sprintf(format, x), cb.Ticks, 'UniformOutput', false);
    cb.Label.String = cbString;
    cb.Label.FontSize = 12;

    % Save figure
    exportgraphics(gcf, fullfile('.', 'figures', strcat(varName, '.png')), 'Resolution', 600);
    
end
