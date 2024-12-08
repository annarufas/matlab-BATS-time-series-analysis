function varsConfig = plotConfigBatsFlux()

% PLOTCONFIGBATSFLUX Creates a structure that contains the configuration 
% parameters to plot BATS flux data.

varsConfig = struct(...
    'Mavg', struct('label', 'Mass flux (mg m^{-2} d^{-1})',  'cMin', 0, 'cMax', 300, 'cStep', 20, 'cAnomaly', 100, 'yMin', 100, 'yMax', 450, 'yStep', 50, 'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Cavg', struct('label', 'POC flux (mg C m^{-2} d^{-1})', 'cMin', 0, 'cMax', 100, 'cStep', 25, 'cAnomaly', 50,  'yMin', 100, 'yMax', 450, 'yStep', 50, 'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)) ...        
);

end

