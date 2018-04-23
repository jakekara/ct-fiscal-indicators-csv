#!/bin/sh

export_csv()
{
    mkdir -p $1_CSV
    
    while read TABLE; do
	# remove / from filenames
	# yes, some tables have / in their name...
	TBL=${TABLE//\/}
	CSV=$1_CSV/$TBL.csv
	mdb-export $1.mdb "$TABLE" > $CSV
    done<$2
}

convert()
{
    echo "CONVERTING DB $1.mdb"
    mdb-tables -1 $1.mdb > $1_TABLES
    export_csv $1 $1_TABLES
    # mdb-schema $1.mdb | sed 's/\///' > $1_SCHEMA.sql
    # sqlite3 $1.sqlite < $1_SCHEMA.sql
}

rm -f data/*.sql*
rm -f data/*_TABLES
rm -rf data/*_CSV

for fname in data/*.mdb
do
    echo $fname
    convert "${fname%.*}"
done

# convert data/MuniFiscalIndicators_11_15
