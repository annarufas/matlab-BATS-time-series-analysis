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
    exportgraphics(gcf,fullfile('.','figures',strcat(figureName,'.png')),'Resolution',600)
    
end % plotCycles