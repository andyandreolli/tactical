# WARNING: this script is not suited for security checks as it is based on MD5.
# It should only be used to compare own files or from trusted sources, i.e. to
# check the integrity of copied files.

# This scripts checks whether all files in the original folder (first argument) 
# exist in the target folder (second as argument) and that they share the same
# MD5 checksum. Syntax:
#
#           /path/to/compare_md5.sh orig_folder targ_folder
#
# All the missing files or different checksums are printed on terminal. If no output
# is seen, then all files have the same checksum.



check_file() { # arguments: 1) file in original directory; 2) original directory; 3) target directory
# example:          check_file original_dir/file.txt original_dir target_dir
    
    # generate file names
    base_name=`echo ${1} | sed s/${2}//` # remove original directory from file name
    target_name=${3}${base_name} # generate target filename (in target directory)
    original_name=${1} # original file is just first input (in original directory)

    
    if [[ -f ${target_name} ]] # inquire existance of file
    then # if file exists
        # calculate hashes
        hash_o=`md5sum ${original_name} | cut -c 1-32`
        hash_t=`md5sum ${target_name} | cut -c 1-32`
        if [ "$hash_o" != "$hash_t" ] # check if hashes differ
        then
            echo "Mismatching hash for file "${base_name}
        fi
    else # if file does not exist
        echo "Unable to find ${target_name}"
    fi

}



# make sure that both input arguments are without / at the end:
# take last character and remove any /
orig_last=`echo "${1: -1}" | sed 's/\///'` 
targ_last=`echo "${2: -1}" | sed 's/\///'`
# take the whole input argument, remove the last character, and substitute it with the processed one
orig_folder=`echo "${1}" | sed 's/.$//'`${orig_last}
targ_folder=`echo "${2}" | sed 's/.$//'`${targ_last}

# generate array with all files in original directory
farray=()
while IFS= read -r -d $'\0'; do
    farray+=("$REPLY")
done < <(find ${orig_folder} -type f -print0)

# now actually for every subfile in input directory call check file
for ii in "${farray[@]}"
do
    check_file ${ii} ${orig_folder} ${targ_folder}
done

# be polite and say goodbye
echo "Done checking ${orig_folder} and ${targ_folder}"