function [batsBottle] = processRawBatsBottle(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    batsBottle = readtable(fullpathFile,opts);

    % Replace column names
    tableColumnNames = {'ID', 'Date', 'DecimalYear', 'Time', 'Latitude', 'Longitude', 'QualityFlag', ...
                       'Depth', 'Temperature', 'CTDSalinity', 'Salinity1', 'SigmaTheta', 'Oxygen1', ...
                       'OxygenFixTemp', 'OxygenAnomaly1', 'CO2', 'Alkalinity', 'NitrateNitrite1', ...
                       'Nitrite1', 'Phosphate1', 'Silicate1', 'POC', 'PON', 'TOC', 'TN', ...
                       'Bacteria', 'POP', 'TotalDissolvedPhosphorus', 'LowLevelPhosphorus', ...
                       'ParticulateBiogenicSilica', 'ParticulateLithogenicSilica', 'Prochlorococcus', ...
                       'Synechococcus', 'Picoeukaryotes', 'Nanoeukaryotes'};

    batsBottle.Properties.VariableNames = tableColumnNames;

    % Convert 'Date' to datetime and add a 'month' and 'year' column; round
    % depths to the nearest integer
    batsBottle.Date = datetime(num2str(batsBottle.Date), 'InputFormat', 'yyyyMMdd');   
    batsBottle.month = month(batsBottle.Date);
    batsBottle.year = year(batsBottle.Date);
    batsBottle.Depth = round(batsBottle.Depth);

    % Replace '-999' with NaN for all numeric columns
    batsBottle = standardizeMissing(batsBottle, -999);

    % Eliminate rows with NaN depths
    batsBottle = batsBottle(~isnan(batsBottle.Depth), :);
    
end % processRawBatsBottle