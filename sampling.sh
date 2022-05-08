#!/bin/bash

# Deklarasi nama file 
FILE=weather_data.xlsx
FILE_2014=weather_2014.csv
FILE_2015=weather_2015.csv
FILE_COMB=weather.csv
FILE_SAMPLE=sample_weather.csv

# Cek jika file sudah di-download, jika belum ada, maka akan mendownload file
if [[ ! -f "$FILE" ]];
then
	wget https://github.com/labusiam/dataset/raw/main/weather_data.xlsx
	echo "File $FILE has been downloaded"
else
	echo "File $FILE already exist"
fi

# Cek jika file weather_2014.csv dan file weather_2015.csv sudah ada
if [[ ! -f "$FILE_2014" && "$FILE_2015" ]];
then
	in2csv $FILE --sheet "weather_2014" > $FILE_2014
	in2csv $FILE --sheet "weather_2015" > $FILE_2015
	echo "File $FILE_2014 and $FILE_2015 has been converted"
else
	echo "File $FILE_2014 and $FILE_2015 already exist"
fi

# Cek jika file weather.csv sudah ada
if [[ ! -f "$FILE_COMB" ]];
then
	csvstack $FILE_2014 $FILE_2015 > $FILE_COMB
	echo "File $FILE_COMB has been created"
else
	echo "File $FILE_COMB already exist"
fi

# Cek jika file weather_data.xlsx sudah dihapus
if [[ ! -f "$FILE" ]];
then
	echo "File $FILE already removed"
else
	rm $FILE
	echo "File $FILE has been deleted"
fi

# Cek jika file sample_weather.csv sudah ada
if [[ ! -f "$FILE_SAMPLE" ]];
then
	cat weather.csv | sample -r 0.3 > sample_weather.csv
	echo "File $FILE_SAMPLE has been created"
else
	echo "File $FILE_SAMPLE already exist"
fi