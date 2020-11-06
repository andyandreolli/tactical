# Compiles an ebox provided as a standalone .tikz file (outputs a .pdf). Usage:
#       ./mkebox.sh output_directory files
# where:
# - output_directory is the directory in which pdf files will be generated
# - files is a regular expression indicating one or more .tikz files



makesinglebox() {

    # create temp folder if it doesn't exist
    if [[ -d /tmp/mktikzfig ]]
    then
        true # this does nothing
    else
        mkdir /tmp/mktikzfig
    fi

    filenamewext=$(basename -- ${1}) # with extension
    filename=${filenamewext%.*} # without extension

    # compile
    # notice that command is grepped; output is printed only if (at least) a line starting with "!" is present
    # 200 lines are printed after "!" is found; they are colored in red
    # https://tex.stackexchange.com/a/459470
    : | pdflatex -interaction=batchmode -output-directory /tmp/mktikzfig ${1} | grep '^!.*' -A200 --color=always
    # pdflatex -halt-on-error

    mv /tmp/mktikzfig/$filename.pdf $2/$filename.pdf # move file
    rm -rf /tmp/mktikzfig # remove temp folder

}



#################
# ACTUAL SCRIPT #
#################

# check existence of input files
if ls $2 1> /dev/null 2>&1; then # tries to list files; if no file is listed, then it casts an error
    true # this does nothing
else
    echo "ERROR: specified input files do not exist."
    exit 1
fi

# check existance of output directory
if [[ -d $1 ]]
then
    true # this does nothing
else
    echo "ERROR: specified output directory does not exist."
    exit 1
fi

# generate images one by one
counter=1
for file
do
    if [ "$counter" -ge 2 ]; then
        makesinglebox $file $1
    fi
    counter=$((counter+1))
done
