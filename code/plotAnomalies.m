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
    exportgraphics(gcf,fullfile('.','figures',strcat(figureName,'.png')),'Resolution',600)

end % plotAnomalies