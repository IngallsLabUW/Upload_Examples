library(cmap4r)
library(knitr)
library(tidyverse)

## Test for CMAP4r usage. 

# Questions:
# Not fully understanding the spacetime() function

set_authorization(cmap_key = "52dd4650-4396-11ea-aa09-71d9d763e28d")

# How to access all the data:
full_catalog <- get_catalog() %>%
  select(Variable, Table_Name, Unit, Sensor, Unit) %>%
  head(20) %>%
  kable()

table_head <- get_head("tblArgoMerge_REP")
table_coverage <- get_var_coverage("tblAltimetry_REP", "sla")
table_resolution <- get_var_resolution("tblAltimetry_REP", "sla")
table_unit <- get_var_unit("tblAltimetry_REP", "sla")
table_columns <- get_columns("tblSST_AVHRR_OI_NRT")

## Cruises
cruisename = "KOK1606" 
get_cruise_by_name(cruisename) 
get_cruise_bounds(cruisename)
get_head("tblAMT13_Chisholm")
get_columns("tblAMT13_Chisholm")

## Download data
spacetime <- get_spacetime(tableName = 'tblArgoMerge_REP',
              varName = 'argo_merge_salinity_adj',
              dt1='2015-05-01',
              dt2='2015-05-30',
              lat1=28,
              lat2=38,
              lon1=-71,
              lon2=-50,
              depth1=0,
              depth2=100) %>% head(10)

## Colocalize
## cruise = 'Diel'
cruise = 'MGL1704'
targetTables = c('tblSeaFlow', 'tblPisces_NRT')
targetVars = c('abundance_synecho', 'NO3')
depth1 = 0
depth2 = 5
temporalTolerance = c(0, 10)
latTolerance = c(0, 5)##0.25)
lonTolerance = c(0, 5)##0.25)
depthTolerance = c(5, 5)
dat = along_track(cruise[1],
                  targetTables[1],
                  targetVars[1],
                  depth1[1],
                  depth2[1],
                  temporalTolerance[1],
                  latTolerance[1],
                  lonTolerance[1],
                  depthTolerance[1])

## Visualize
tableName <- "tblsst_AVHRR_OI_NRT"
varName <- "sst"

# Range variable [lat,lon,time,depth]
lat1 = 10; lat2 = 70
lon1 = -180; lon2 = -80
dt1 = "2016-04-30"; dt2 = "2016-04-30"
depth1 <- 0; depth2 =  0

p <- plot_regmap(tableName, varName, lat1, lat2, lon1, lon2,
                 dt1, dt2, depth1, depth2, type = "plotly")
p