# Quantile Regression
Code for Quantile Regression used in Mueller and Seneviratne, 2012, PNAS

Read in 2 NetCDF files with lon, lat, time.

Perform quantile regression over time at each lon x lat location and
calculate 0.9-significance level with 200 bootstrapps (significance was not used in Mueller and Seneviratne, 2012)


Reference:  
Mueller, B. and S.I. Seneviratne (2012): Hot days induced by precipitation deficits at the global scale. Proceedings of the National Academy of Sciences of the United States of America, 109 (31), 12398-12403, doi: 10.1073/pnas.1204330109
