function batsFlux = processRawBatsFlux(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    batsFlux = readtable(fullpathFile,opts);

    % Replace column names
    tableColumnNames = {'cruiseNumber', 'dep', 'yymmdd1', 'yymmdd2', 'decy1', 'decy2', 'Lat1', ...
                       'Lat2', 'Long1', 'Long2', 'M1', 'M2', 'M3', 'Mavg', 'C1', 'C2', 'C3', ...
                       'Cavg', 'N1', 'N2', 'N3', 'Navg', 'P1', 'P2', 'P3', 'Pavg',...
                       'FBC1', 'FBC2', 'FBC3', 'FBCavg', 'FBN1', 'FBN2', 'FBN3', 'FBNavg'};

    batsFlux.Properties.VariableNames = tableColumnNames;

    % Convert 'yymmdd1' and 'yymmdd2' to datetime and add a 'month' and 'year' column
    batsFlux.yymmdd1 = datetime(num2str(batsFlux.yymmdd1), 'InputFormat', 'yyyyMMdd');  
    batsFlux.yymmdd2 = datetime(num2str(batsFlux.yymmdd2), 'InputFormat', 'yyyyMMdd');  
    batsFlux.month = month(batsFlux.yymmdd1);
    batsFlux.year = year(batsFlux.yymmdd1);

    % Replace '-999' with NaN for all numeric columns
    batsFlux = standardizeMissing(batsFlux, -999);
    
end % processRawBatsFlux