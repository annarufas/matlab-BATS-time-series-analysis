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
    exportgraphics(gcf,fullfile('.','figures',strcat(figureName,'.png')),'Resolution',600)

end % plotTrends