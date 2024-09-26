function [batsBacteria] = processRawBatsBacteria(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    batsBacteria = readtable(fullpathFile,opts);

    % Replace column names
    tableColumnNames = {'Id', 'yymmdd', 'decy', 'Lat', 'Long', ...
                      'dep1', 'salt', 'thy1', 'thy2', 'thy3', 'thy'};
    batsBacteria.Properties.VariableNames = tableColumnNames;

    % Convert 'yymmdd' to datetime
    batsBacteria.yymmdd = datetime(num2str(batsBacteria.yymmdd), 'InputFormat', 'yyyyMMdd');   

    % Replace '-999' with NaN for all numeric columns
    batsBacteria = standardizeMissing(batsBacteria, -999);

end % processRawBatsNpp