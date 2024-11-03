#!/usr/bin/env bash
#
# Script adapted for creating a relief map of Turkey.

gmt begin turkey_relief_map png

    # 1. Set a Mercator projection and region for Turkey.
    gmt basemap -R25/45/35/43 -JM15c -B+n

    # 2. Set the default frame (-Baf) and add a title to the plot (-B+t).
    gmt basemap -Baf -B+t"Relief Map of Turkey"

    # 3. Plot the earth synbath data using the "oleron" CPT. Adding shading at a 45
    # degree azimuth (+a45) with intensity scaled to 2 (+nt2).
    gmt grdimage @earth_synbath -I+a45+nt2 -Coleron

    # 4. Plot contours on top of the shaded grid. Limit to negative contours only
    # (-Ln) and omit contours less than 1000 km long (-Q). For the annotations,
    # configure the font size to be 6pt (+f).
    gmt grdcontour @earth_synbath -Ln -Q1000k \
        -C200 -Wcthinnest,gray20 \
        -A1000+f6p+gwhite+p -Wathinnest,gray20

    # 5. Plot the country borders (-N1) in white.
    gmt coast -N1/white

    # 6. Place a colorbar outside near the top right with an offset in x (+o) and
    # customize the width and height (+w). Set the annotation interval to 1 km (-Ba1f1)
    # and add a label to the x-axis (-Bx+l). Add a frame around the colorbar (-F).
    gmt colorbar -DJMR+o1c/0c+w10c/0.5c -I -Ba1 -Bx+l"km" -W0.001 -F+gwhite+p+r+s

gmt end show
