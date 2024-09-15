function [ofpFlux] = processRawOfpFlux(fullpathFile)

    % Read the file into a table
    opts = detectImportOptions(fullpathFile);
    opts.Delimiter = ',';
    ofpFlux = readtable(fullpathFile,opts);

    % Convert specific columns from cell to double
    ofpFlux.OpalFlux = cellfun(@str2double, ofpFlux.OpalFlux); 
    ofpFlux.LithFlux = cellfun(@str2double, ofpFlux.LithFlux);  
              
    % Eliminate rows with NaN duration
    ofpFlux = ofpFlux(~isnan(ofpFlux.Duration), :);
    
    % Add a 'Mid_Date' column; add a 'month' and 'year' column
    ofpFlux.Start_Date = datetime(ofpFlux.Start_Date, 'InputFormat', 'yyyy-MM-dd');  
    ofpFlux.Mid_Date = ofpFlux.Start_Date + round(days(ofpFlux.Duration)./2); 
    ofpFlux.month = month(ofpFlux.Mid_Date);
    ofpFlux.year = year(ofpFlux.Mid_Date);

end % processRawOfpFlux