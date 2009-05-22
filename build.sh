#!/bin/sh
##       _________ __                 __                               
##      /   _____//  |_____________ _/  |______     ____  __ __  ______
##      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
##      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
##     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
##             \/                  \/          \//_____/            \/ 
##  ______________________                           ______________________
##			  T H E   W A R   B E G I N S
##	   Stratagus - A free fantasy real time strategy game engine
##
##	build.sh	-	The graphics and sound extractor.
##
##	(c) Copyright 1999-2005 by The Stratagus Team
##
##	Stratagus is free software; you can redistribute it and/or modify
##	it under the terms of the GNU General Public License as published
##	by the Free Software Foundation; only version 2 of the License.
##
##	Stratagus is distributed in the hope that it will be useful,
##	but WITHOUT ANY WARRANTY; without even the implied warranty of
##	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##	GNU General Public License for more details.
##
##	$Id: build.sh 1522 2009-05-22 17:05:02Z tlh2000 $
##

#       cdrom autodetection
CDROM="/cdrom"
[ -d "/mnt/cdrom" ] && CDROM="/mnt/cdrom"

#       location of data files
ARCHIVE="$CDROM/data/"

#	output dir
DIR="data.wc1"

#	location of the wartool binary
BINPATH="."

####	Do not modify anything below this point.

while [ $# -gt 0 ]; do
	case "$1" in
		-p)	ARCHIVE="$2"; shift ;;
		-o)	DIR="$2"; shift ;;

		-h)	cat << EOF

build.sh [-o output] -p path 
 -o output directory (default 'data.wc1')
 -p path to data files
EOF
			exit 1;;
		*)	$0 -h; exit 1;;
	esac
	shift
done

if [ -d "$ARCHIVE/fdata/" ]; then
	DATADIR="$ARCHIVE/fdata/"
else
	DATADIR="$ARCHIVE/"
fi

if [ ! -f "$DATADIR/data.war" ] && [ ! -f "$DATADIR/DATA.WAR" ] && [ ! -f "$DATADIR/War Resources" ]; then
    echo "error: '$DATADIR/data.war' does not exist"
    echo "error: '$DATADIR/War Resources' does not exist"
    echo "Specify the location of the data files with the '-p' option"
    exit 1
fi

# Create the directory structure

[ -d $DIR ] || mkdir $DIR
#[ -d $DIR/music ] || mkdir $DIR/music

###############################################################################
##	Extract and Copy
###############################################################################

# copy script files
cp -R scripts $DIR/scripts
rm -Rf `find $DIR/scripts | grep CVS`
rm -Rf `find $DIR/scripts | grep cvsignore`
rm -Rf `find $DIR/scripts | grep .svn`

$BINPATH/war1tool "$DATADIR" "$DIR" || exit

#	Compress the sounds
find $DIR/sounds -type f -name "*.wav" -print -exec gzip -f {} \;

#	Compress the texts
find $DIR/campaigns -type f -name "*.txt" -print -exec gzip -f {} \;

#	Setup the default map
#[ -f "$DIR/maps/multi/(2)mysterious-dragon-isle.sms.gz" ] && cd $DIR/maps \
#	&& ln -s "multi/(2)mysterious-dragon-isle.sms.gz" default.sms.gz \
#	&& ln -s "multi/(2)mysterious-dragon-isle.smp.gz" default.smp.gz

echo "War1gus data setup is now complete"
echo "Note: you do not need to run this script again"

exit 0
