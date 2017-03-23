# Converted fiscal indicators Access databases to CSVs

The goods are in the /data folder

#### Sourece mdb files:

http://www.ct.gov/opm/cwp/view.asp?A=2984&Q=383170

#### To run it yourself:

put all the .mdb files in the data folder and then

     $ chmod 755 CONVERT.sh
     $ ./CONVERT.sh


#### TODO

I'd like to pull these all into a better DB, and then actually build a sane
schema. These databases are not really databases as is; they're basically
just a mess of spreadsheets.

