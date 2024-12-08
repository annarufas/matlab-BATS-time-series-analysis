function plotVariableOverTime(x,y,xMin,xMax,xStep,yMin,yMax,yStep,...
    yLabelString,titleStr,figureName)

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
    
    title(titleStr)

    % Save figure
    exportgraphics(gcf,fullfile('.','figures',strcat(figureName,'.png')),'Resolution',600)

end % plotVariableOverTime