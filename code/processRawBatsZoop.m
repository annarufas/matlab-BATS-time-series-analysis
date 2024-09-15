function [batsZooDepthIntegrated] = processRawBatsZoop(fullpathFile) 

    % Read the file into a table, skipping the header rows
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    opts.DataLines = [37, Inf];  % Skip the first 36 rows which are comments
    opts.VariableNamesLine = 36;  % Specify the row that contains variable names

    % Read the file into a table
    batsZoo = readtable(fullpathFile, opts);

    % Remove the last column (it contains NaNs)
    batsZoo(:,end) = [];

    % Replace column names
    tableColumnNames = {'cruisenum', 'date', 'townum','lat_deg', 'lat_min', 'lon_deg', 'lon_min', ...
                        'time_in', 'time_out', 'duration_min', 'max_depth', 'volume_water_m3', ...
                        'sieve_size_um', 'ww_mg', 'dw_mg',...
                        'ww_per_vol_mg_m3', 'dw_per_vol_mg_m3',...
                        'total_ww_per_vol_mg_m3', 'total_dw_per_vol_mg_m3',...
                        'ww_per_vol_mg_m3_norm_200m', 'dw_per_vol_mg_m3_norm_200m',...
                        'total_ww_per_vol_mg_m3_norm_200m', 'total_dw_per_vol_mg_m3_norm_200m'};            
    batsZoo.Properties.VariableNames = tableColumnNames;

    % Notice that the zooplankton data belongs to the size category of
    % 'mesozooplankton' (200 um - 20 mm) as per the mesh size range of 200 to
    % 5000 um.
    % Two replicate oblique tows are made during the day (between 09:00 and 
    % 15:00) and night (between 20:00 and 02:00) to a depth of approximately 200 m

    % Convert 'date' to datetime
    batsZoo.date = datetime(num2str(batsZoo.date), 'InputFormat', 'yyyyMMdd');

    % Replace '-999' with NaN for all numeric columns
    batsZoo = standardizeMissing(batsZoo, -999);

    % Combine date and time into a new column
    times_str = arrayfun(@(x) sprintf('%04d', x), batsZoo.time_in, 'UniformOutput', false); % ensure times are in a four-digit format (i.e., hhmm)
    dates_str = datestr(batsZoo.date, 'yyyy-mm-dd');  % convert to string format 'yyyy-mm-dd'
    datetime_str = strcat(dates_str, {' '}, times_str); % combine dates and times into a single string
    batsZoo.datetime = datetime(datetime_str, 'InputFormat', 'yyyy-MM-dd HHmm');

    % Add a column indicating whether the sampling happened during the day or
    % night
    hours = hour(batsZoo.datetime);
    day_night = cell(size(hours));
    night_indices = (hours >= 20 | hours < 5); % assign 'night' for times between 20:00 (8 PM) and 05:00 (5 AM)
    day_night(night_indices) = {'night'};
    day_indices = (hours >= 5 & hours < 20); % assign 'day' for times between 05:00 (5 AM) and 20:00 (8 PM)
    day_night(day_indices) = {'day'};
    batsZoo.day_night = day_night;

    % Find unique cruise numbers and assign them a date based on an average of
    % day/night values
    [uniqueCruiseNums, ~,idx] = unique(batsZoo.cruisenum); % find unique cruise numbers and their indices
    averageDateTimes = arrayfun(@(x) mean(batsZoo.datetime(batsZoo.cruisenum == x)), uniqueCruiseNums); % calculate average datetime for each unique cruise number
    batsZoo.datetime_average = averageDateTimes(idx); % add the new column to your table

    % Values from different tows happening in the same day (profile) are 
    % averaged and centred at the 200 m depth. Values are then integrated
    % over the 200 m depth range.

    % Group by 'cruisenum', 'day_night', 'sieve_size_um' and 'townum'
    [G, cruiseGroup, sizeCategoryGroup, dayNightGroup] = findgroups(batsZoo.datetime_average, ...
                                                                    batsZoo.sieve_size_um,...
                                                                    batsZoo.day_night);
    % Average the biomass for each group.
    zooAvgBiomass = splitapply(@(x) mean(x, 'omitnan'), batsZoo.dw_per_vol_mg_m3, G);
    zooAvgIntegrationDepth = splitapply(@(x) mean(x, 'omitnan'), batsZoo.max_depth, G);
    zooAvgIntegrationDepth(isnan(zooAvgIntegrationDepth)) = 200; % replace NaN by 200

    % Integrate over 200 m depth 
    zooAvgBiomass = zooAvgBiomass.*zooAvgIntegrationDepth; % mg DW m-3 --> % mg DW m-2

    % Display the group details along with the averaged biomass and integration
    % depth
    batsZooDepthIntegrated = table(cruiseGroup, sizeCategoryGroup, dayNightGroup,...
        zooAvgBiomass, zooAvgIntegrationDepth);

end % processRawBatsZoop