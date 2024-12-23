function varsConfig = plotConfigBatsBottle()

% PLOTCONFIGBATSBOTTLE Creates a structure that contains the configuration 
% parameters to plot BATS bottle data.

varsConfig = struct(...
    'Temperature',     struct('label', 'Temperature (ºC)',                   'cMin', 4,    'cMax', 28,   'cStep', 2,   'cAnomaly', 4,   'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'CTDSalinity',     struct('label', 'Salinity (PSU)',                     'cMin', 35,   'cMax', 37,   'cStep', 0.2, 'cAnomaly', 0.4, 'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'SigmaTheta',      struct('label', 'Density (kg m^{-3})',                'cMin', 23,   'cMax', 27,   'cStep', 0.5, 'cAnomaly', 1,   'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Oxygen1',         struct('label', 'O_2 (\mumol kg^{-1})',               'cMin', 130,  'cMax', 250,  'cStep', 10,  'cAnomaly', 20,  'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'CO2',             struct('label', 'CO_2 (\mumol kg^{-1})',              'cMin', 2000, 'cMax', 2200, 'cStep', 20,  'cAnomaly', 40,  'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Alkalinity',      struct('label', 'ALK',                                'cMin', 2300, 'cMax', 2400, 'cStep', 10,  'cAnomaly', 20,  'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'NitrateNitrite1', struct('label', 'Nitrate + nitrite (\mumol kg^{-1})', 'cMin', 0,    'cMax', 20,   'cStep', 2,   'cAnomaly', 4,   'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Phosphate1'     , struct('label', 'Phosphate (\mumol kg^{-1})',         'cMin', 0,    'cMax', 1.8,  'cStep', 0.2, 'cAnomaly', 0.4, 'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Silicate1',       struct('label', 'Silicate (\mumol kg^{-1})',          'cMin', 0,    'cMax', 15,   'cStep', 1,   'cAnomaly', 3,   'yMin', 0, 'yMax', 2000, 'yStep', 500, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'POC',             struct('label', 'POC (\mug kg^{-1})',                 'cMin', 0,    'cMax', 50,   'cStep', 5,   'cAnomaly', 20,  'yMin', 0, 'yMax', 1000, 'yStep', 200, 'xMin', datetime(1989,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Bacteria',        struct('label', 'Bacteria (10^{8} x cells/kg)',       'cMin', 0,    'cMax', 10,   'cStep', 1,   'cAnomaly', 2,   'yMin', 0, 'yMax', 1000, 'yStep', 200, 'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Prochlorococcus', struct('label', 'Prochlorococcus (10^{3} x cells/mL)','cMin', 0,    'cMax', 100,  'cStep', 10,  'cAnomaly', 20,  'yMin', 0, 'yMax', 300,  'yStep', 50,  'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Synechococcus',   struct('label', 'Synechococcus (10^{3} x cells/mL)',  'cMin', 0,    'cMax', 100,  'cStep', 10,  'cAnomaly', 20,  'yMin', 0, 'yMax', 300,  'yStep', 50,  'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Picoeukaryotes',  struct('label', 'Picoeukaryotes (10^{3} x cells/mL)', 'cMin', 0,    'cMax', 10,   'cStep', 1,   'cAnomaly', 2,   'yMin', 0, 'yMax', 300,  'yStep', 50,  'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2)), ...
    'Nanoeukaryotes',  struct('label', 'Nanoeukaryotes (10^{3} x cells/mL)', 'cMin', 0,    'cMax', 0.4,  'cStep', 0.05,'cAnomaly', 0.1, 'yMin', 0, 'yMax', 300,  'yStep', 50,  'xMin', datetime(2013,01,01), 'xMax', datetime(2023,06,01), 'xStep', calyears(2))...
);

end