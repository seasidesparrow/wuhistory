#!/usr/bin/env bash

#---------------------------------------------------------------------------
#
# wuhistory.bash 
#
#---------------------------------------------------------------------------
# Simple bash script to download weather data archives from wunderground.com
# by year for a specific ICAO-coded airport.  This API does not require a
# developer key, and can be run as-is.
#
# The only values needing to be changed are "airport", "ystart", and "yend",
# which are the ICAO code, the first year and last year that you want data
# from respectively.  Data for each year will be downloaded into a CSV file 
# named "YYYY.csv", having a single header line naming the columns available.
# If data do not exist for a particular year, the resulting file will only 
# have the header row, and nothing else.
#
# For a list of ICAO codes, try
#
#	https://en.wikipedia.org/wiki/List_of_airports_by_IATA_and_ICAO_code
#
#---------------------------------------------------------------------------

# KJFK is Idlewild/JFK Intl. in New York City, NY, United States
airport="KJFK"

#First year that you want data for
ystart="1948"

#Last year that you want data for
ystop="2016"



# No need to edit below this line

yyyy=$ystart
st=2

while [ $yyyy -le $ystop ]; do
    echo "Retrieving weather data for the year $yyyy "
    wget -qO- "https://www.wunderground.com/history/airport/$airport/$yyyy/1/1/CustomHistory.html?dayend=31&monthend=12&yearend=$yyyy&format=1" | sed -r 's/<br \/>//' | sed -r '/^$/d'> "$yyyy.csv"
    let yyyy+=1
    sleep $st
done
