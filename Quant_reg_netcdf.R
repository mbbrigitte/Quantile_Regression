## read 2 NetCDF files with lon, lat, time
## perform quantile regression over time at each lon x lat location and
## calculate 0.9-significance level with 200 bootstrapps, not that the significance
## level has not been used in the Mueller and Seneviratne-publication

## example with Number of Hot days and SPI as in:
## Mueller and Seneviratne, 2012, PNAS

## SELECT: tau is the quantile of the regression, here as an example
## the 70th percentile i.e. tau = 0.7

library(quantreg)
library(boot)
library(ncdf)

ex.nc = open.ncdf("/dir/SPI.nc")
print(ex.nc) 
x = get.var.ncdf( ex.nc, "LON")   # coordinate variable
y = get.var.ncdf( ex.nc, "LAT")   # coordinate variable
t = get.var.ncdf( ex.nc, "TIME")  # coordinate variable
v = get.var.ncdf( ex.nc, "SPI")   # variable SPI in v

ex.nc = open.ncdf("/dir/HD.nc")
print(ex.nc) 
w = get.var.ncdf( ex.nc, "HD")    # variable HD in w


conf.level <- 0.90
probs <- (1 + c(-1, 1) * conf.level) / 2
nboot <- 200


taus <- c(.7) 

slopvar <- array(-9999.0,c(dim(z)))
confvar <- array(-9999,c(dim(z)))

## loop over lons (x) and lats (y)
for (i in 1:length(x)) { 
  for (j in 1:length(y)) {
    SPI <- v[i,j,]
    HD <- w[i,j,]
    if (sum(!is.na(HD)) == length(t)) {
      if (sum(!is.na(SPI)) == length(t)) {
        f <- coef(rq(HD~SPI,tau=taus))
        slopvar[i,j]=f[2]
        # Significance bootstrap:
        b <- boot.rq(SPI,HD,tau=taus,R=nboot)
        interv <- sort(b)[(nboot + 1) * probs]
        if ((f[2] <= interv[1]) | (f[2] >= interv[2])) {
          confvar[i,j]=0.01
        }
      }
    }
  }
}

# NetCDF output from slopvar
dim1 = dim.def.ncdf( "LON","longitude", as.double(x))
dim2 = dim.def.ncdf( "LAT","latitude", as.double(y))
varz = var.def.ncdf("Slope_70Q","-", list(dim1,dim2), -1, 
                    longname="Slope of the 0.7 Quantile Regression SPI-HD")
# associate the netcdf variable with a netcdf file   
nc.ex = create.ncdf( "/outdir/QRegression_70Q_Slope.nc", varz )
put.var.ncdf(nc.ex, varz, slopvar)
close.ncdf(nc.ex)


# NETCDF output from confidence level (separate file)
dim1 = dim.def.ncdf( "LON","longitude", as.double(x))
dim2 = dim.def.ncdf( "LAT","latitude", as.double(y))
varz = var.def.ncdf("Slope_70Q_conf","-", list(dim1,dim2), -1, 
                    longname="0.7 Quantile Reg SPI-HD Confidence")
# associate the netcdf variable with a netcdf file   
nc.ex = create.ncdf( "/outdir/QRegression_70Q_Slope_confidence.nc", varz )
put.var.ncdf(nc.ex, varz, confvar)
close.ncdf(nc.ex)

