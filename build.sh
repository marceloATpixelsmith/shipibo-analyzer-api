#!/bin/bash
# Combine all .foma files and compile into morph-shk.fomabin

# Concatenate all Foma source files
cat foma_files/*.foma > combined.foma

# Compile combined.foma to binary stack morph-shk.fomabin
foma -f combined.foma << EOF
save stack morph-shk.fomabin
quit
EOF
