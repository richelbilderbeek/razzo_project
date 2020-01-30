#!/bin/bash
#
# Compares multiple experiments
#
# Usage, must be local: 
#
#   ./scripts/compare.sh
#

# Comparison scripts:
# - Start with a 9 and have a digit before the underscore
# - Are not '99_zip.sh'
scripts=$(ls scripts | sort -g | egrep "^90_.*sh" | egrep -v "99_zip.sh")

for script in $scripts
do
  echo "Running script: "$script
  ./scripts/$script
done

