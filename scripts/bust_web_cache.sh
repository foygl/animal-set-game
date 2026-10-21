#!/bin/bash

NAME=animal_set

echo "Cache busting"

# Save a date stamp string of numbers
TIMESTAMP=$(date +%s)

# Go to the folder where the project is exported to
cd exported/web || exit

# Remove the OLD renamed files from last time since Godot won't overwrite them.
rm ${NAME}-*.*

# Rename all files to add the date stamp
for file in ${NAME}.*
do
  mv "$file" "${file/${NAME}/${NAME}-$TIMESTAMP}"
done

# Name the ${NAME}.html file BACK to just ${NAME}.html
mv ${NAME}-${TIMESTAMP}.html ${NAME}.html

# Replace all instances of ${NAME} with ${NAME}-TIMESTAMP in the ${NAME}.html
sed -i "" "s/${NAME}\./${NAME}-${TIMESTAMP}\./g; s/\"${NAME}\"/\"${NAME}-${TIMESTAMP}\"/g" ${NAME}.html
