make_output_dir(){
    echo "MAKING OUTPUT DIRECTORY $OUTDIR"
    mkdir -p "$OUTDIR"
}

make_table_index(){
    echo "MAKING TABLE INDEX $TBL_F
ILE"
    mdb-tables -1 "$INFILE" > "$TBL_FILE"
}

remove_table_index(){
    echo "REMOVING TABLE INDEX $TBL_FILE"
    rm -f "$TBL_FILE"
}

do_main_loop(){
    while read TABLE; do

	TABLE_FNAME=$(echo $TABLE | sed 's/\//-/g')

	OUTFILE=$OUTDIR/$TABLE_FNAME.$OUTEXT

	# Strip slashes
	# INFILE=$(printf '%q' $INFILE)

	echo "Writing: $INFILE.$TABLE => $OUTFILE "

	echo mdb-export "$MDB_OPTIONS" "$INFILE" "$TABLE > $OUTFILE"
	mdb-export $MDB_OPTIONS "$INFILE" "$TABLE" > "$OUTFILE"

    done<$TBL_FILE
}    

dump_tables(){
    INFILE="$1" # input database file
    OUTDIR="$2" # output directory
    OUTEXT="$3" # output file extension
    MDB_OPTIONS="$4" # extra options to pass to mydb-export
    TBL_FILE="TMP_TABLES"

    echo "$INFILE"
    echo "$OUTDIR"
    echo "$OUTEXT"
    echo "$MDB_OPTIONS"
    echo "$TBL_FILE"
    echo "--------------"

    # Make output directory
    make_output_dir
    
    # List all of the tables
    make_table_index # "$INFILE" "$TBL_FILE"

    # Process each file
    do_main_loop

    remove_table_index $TBL_FILE
}
