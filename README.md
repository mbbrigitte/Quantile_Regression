# Quantile Regression
Code for Quantile Regression used in [Mueller and Seneviratne](http://www.pnas.org/content/109/31/12398), 2012, PNAS

Read in 2 NetCDF files with lon, lat, time.

Perform quantile regression over time at each lon x lat location and
calculate 0.9-significance level with 200 bootstrapps (significance was not used in Mueller and Seneviratne, 2012)

Figures showing slope of regression lines (left two maps, for Texas in the middle)
<p align="center"> 
  <img src="https://cloud.githubusercontent.com/assets/15571699/15908162/89ce069e-2dc0-11e6-9be0-99048dfa1fb0.jpg" width="300"/>
  <img src="https://cloud.githubusercontent.com/assets/15571699/15908166/8dd4cba6-2dc0-11e6-8078-610b7d10e7fa.jpg" width="380"/>
</p>

Reference:  
Mueller, B. and S.I. Seneviratne (2012): Hot days induced by precipitation deficits at the global scale. Proceedings of the National Academy of Sciences of the United States of America, 109 (31), 12398-12403, doi: 10.1073/pnas.1204330109

