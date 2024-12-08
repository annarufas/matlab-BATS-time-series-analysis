function plotZooplanktonDataBySizeClass(batsZooDepthIntegrated,xMin,xMax,xStep,yMin,yMax,yStep)

    % Ticks
    xTickTimes = xMin:xStep:xMax;
    yTickValues = yMin:yStep:yMax;

    [uniqueSizeCategories, ~, ~] = unique(batsZooDepthIntegrated.sizeCategoryGroup);
    nSizeCategories = numel(uniqueSizeCategories);

    myColorScheme = brewermap(nSizeCategories,'*YlOrRd');

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

            plot(haxis(iSubplot),x,y,'Color',myColorScheme(iSizeCategory,:),'LineWidth',1.5); hold on;
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
    exportgraphics(gcf,fullfile('.','figures','bats_zoobiomass.png'),'Resolution',600) 

end % plotZooplankton
