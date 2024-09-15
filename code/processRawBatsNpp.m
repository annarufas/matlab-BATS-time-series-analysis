function [batsNpp,batsNppDepthIntegrated] = processRawBatsNpp(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    batsNpp = readtable(fullpathFile,opts);

    % Replace column names
    tableColumnNames = {'Id', 'yymmdd_in', 'yymmdd_out', 'decy_in', 'decy_out', ...
                      'hhmm_in', 'hhmm_out', 'Lat_in', 'Lat_out', 'Long_in', ...
                      'Long_out', 'QF', 'dep1', 'pres', 'temp', 'salt', ...
                      'lt1', 'lt2', 'lt3', 'dark', 't0', 'pp'};
    batsNpp.Properties.VariableNames = tableColumnNames;

    % Convert 'yymmdd_in' and 'yymmdd_out' to datetime; add a 'month' and
    % 'year' column; round depths to the nearest integer
    batsNpp.yymmdd_in = datetime(num2str(batsNpp.yymmdd_in), 'InputFormat', 'yyyyMMdd');   
    batsNpp.yymmdd_out = datetime(num2str(batsNpp.yymmdd_out), 'InputFormat', 'yyyyMMdd'); 
    batsNpp.month = month(batsNpp.yymmdd_in);
    batsNpp.year = year(batsNpp.yymmdd_in);
    batsNpp.dep1 = round(batsNpp.dep1);

    % Replace '-999' with NaN for all numeric columns
    batsNpp = standardizeMissing(batsNpp, -999);

    % Make sure the table is sorted by 'depth' and then 'date' to properly
    % arrange data to perform depth integration
    batsNpp = sortrows(batsNpp,'dep1');
    batsNpp = sortrows(batsNpp,'yymmdd_in');

    % Find unique dates
    [T,~,~] = unique(batsNpp.yymmdd_in,'rows');

    % Build a new NPP table for depth-integrated values
    newTableColumnNames = {'NPP_mg_C_m2_d','date','month','year'};
    nCruises = numel(T); 
    batsNppDepthIntegrated = table('Size', [nCruises, length(newTableColumnNames)], ...
        'VariableTypes', {'double','datetime','double','double'}, ...
        'VariableNames', newTableColumnNames);

    % Integrate (use trapezoidal rule for integration)
    for iCruise = 1:nCruises
        profileDepths = batsNpp.dep1(batsNpp.yymmdd_in == T(iCruise));
        profileNpp = batsNpp.pp(batsNpp.yymmdd_in == T(iCruise)); % mg C m-3 d-1
        batsNppDepthIntegrated.NPP_mg_C_m2_d(iCruise) = trapz(profileDepths,profileNpp); % mg C m-3 d-1 --> mg C m-2 d-1
        batsNppDepthIntegrated.date(iCruise) = T(iCruise);
        batsNppDepthIntegrated.month(iCruise) = month(T(iCruise));
        batsNppDepthIntegrated.year(iCruise) = year(T(iCruise));
    end

    % Transform into categorical the variable 'month' 
    batsNppDepthIntegrated.month = categorical(batsNppDepthIntegrated.month);

end % processRawBatsNpp