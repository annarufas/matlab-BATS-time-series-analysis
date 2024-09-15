function [batsPigments] = processRawBatsPigments(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = '\t';
    batsPigments = readtable(fullpathFile,opts);

    % Replace column names
    tableColumnNames = {'Id', 'Date', 'DecimalYear', 'Time', 'LatitudeN', 'LongitudeW', 'QualityFlag', 'Depth',...
        'Pigment1_Chlorophyll_c3', 'Pigment2_Chlorophyllide_a', 'Pigment3_Chlorophyll_c1_c2', 'Pigment4_Peridinin', ...
        'Pigment5_19_Butanoyloxyfucoxanthin', 'Pigment6_Fucoxanthin', 'Pigment7_19_Hexanoyloxyfucoxanthin', ...
        'Pigment8_Prasinoxanthin', 'Pigment9_Diadinoxanthin', 'Pigment10_Alloxanthin', ...
        'Pigment11_Diatoxanthin', 'Pigment12_Zeaxanthin_Lutein', 'Pigment13_Chlorophyll_b', ...
        'Pigment14_Chlorophyll_a', 'Pigment15_a_b_Carotene', 'Pigment16_Turner_Chlorophyll_a', ...
        'Pigment17_Turner_Phaeopigments', 'Pigment18_Lutein', 'Pigment19_Zeaxanthin', ...
        'Pigment20_a_Carotene', 'Pigment21_b_Carotene'};
    batsPigments.Properties.VariableNames = tableColumnNames;

    % Convert 'Date' to datetime; round depths to nearest integer
    batsPigments.Date = datetime(num2str(batsPigments.Date), 'InputFormat', 'yyyyMMdd');  
    batsPigments.Depth = round(batsPigments.Depth);
 
    % Replace '-999' with NaN for all numeric columns
    batsPigments = standardizeMissing(batsPigments, -999);
    
end % processRawBatsPigments