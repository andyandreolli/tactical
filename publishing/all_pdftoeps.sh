# this script converts all pdf files in the current working dir to eps
# the produced eps is a vectorial image, unless rasterisation is needed
# (typically, when there are transparencies in the image)

# you can specify files to forcefully rasterize in the list below

############
# SETTINGS #
############

force_raster=""

######################
# SCRIPT BEGINS HERE #
######################

for file_toconv in $(ls *.pdf | xargs)
do
    outfile=$(echo ${file_toconv} | sed 's/.pdf/.eps/')
    pdftops -eps -r 1000 -aaRaster yes -rasterize whenneeded -origpagesizes ${file_toconv}
done

# force rasterisation for select cases
for file_toconv in ${force_raster}
do
    outfile=$(echo ${file_toconv} | sed 's/.pdf/.eps/')
    pdftops -eps -r 1000 -aaRaster yes -rasterize always -origpagesizes ${file_toconv}
done