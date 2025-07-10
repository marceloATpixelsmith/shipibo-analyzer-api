#!/bin/bash
# Combine all .foma files and compile into morph-shk.fomabin

# Concatenate all Foma source files
cat foma_files/*.foma > combined.foma

# Compile to binary Foma stack
echo 'read combined.foma' | foma -f - > /dev/null
echo 'save stack morph-shk.fomabin' | foma -f - > /dev/null
