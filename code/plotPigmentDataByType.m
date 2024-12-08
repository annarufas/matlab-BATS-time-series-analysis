function plotPigmentDataByType(B,T,D,varsConfig,xMin,xMax,xStep,yMin,yMax,yStep,...
    yLabelStr,titleStr,legendStr,figureName)                             
       
    fields = fieldnames(varsConfig);
   
    % Ticks
    xTickTimes = xMin:xStep:xMax;
    xTickTimesNumeric = datenum(xTickTimes);
    yTickValues = yMin:yStep:yMax;

    myColorScheme = brewermap(length(fields),'*Paired');

    figure()
    set(gcf,'Units','Normalized','Position',[0.01 0.05 0.70 0.30],'Color','w')
    ax = axes('Position', [0.08 0.17 0.74 0.74]); 

    for iVar = 1:length(fields)
        varName = fields{iVar};
        varValues = B.(varName)(D == 100);
        varDates  = T(D == 100);
        plot(ax,datenum(varDates),varValues,'Color',myColorScheme(iVar,:),'LineWidth',1.5)
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
    exportgraphics(gcf,fullfile('.','figures',strcat(figureName,'.png')),'Resolution',600)

end % plotPigmentDataByType