
# determine the number of physical cores (not hyperthreads)
# so far only for a single-processor machine setting
PLATFORM=`uname`
if [[ "$PLATFORM" == 'Linux' ]]; then
    NCORES=`grep core\ id /proc/cpuinfo | sort | uniq | wc -l`
    echo Linux detected, on $NCORES physical CPU cores
elif [[ "$PLATFORM" == 'Darwin' ]]; then
    NCORES=`sysctl -n hw.physicalcpu`
    echo Mac OS detected, on $NCORES physical CPU cores
else
    NCORES=1  
    echo 'Unknown platform, cannot determine the number of cores, defulting to one'
fi

# run julia with multiple threads
JULIA_NUM_THREADS=${NCORES} \time julia --color=yes main-inccpa-hw.jl aes128_sb_ciph_deadbeefcafebabe1122334455667788.trs
