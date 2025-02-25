#!/bin/bash

# Create base directory
rm -rf pip-repo
mkdir -p pip-repo
cd pip-repo

# Download packages
pip3 download numpy --no-deps
pip3 download pandas --no-deps
pip3 download requests --no-deps
pip3 download flask --no-deps

# Create simple repository structure
mkdir -p simple/{n,p,r,f}
mkdir -p simple/n/numpy
mkdir -p simple/p/pandas
mkdir -p simple/r/requests
mkdir -p simple/f/flask

# Move files to their package directories
mv numpy-*.whl simple/n/numpy/
mv pandas-*.whl simple/p/pandas/
mv requests-*.whl simple/r/requests/
mv flask-*.whl simple/f/flask/

# # Function to create package index
# create_package_index() {
#     local pkg=$1
#     local letter=${pkg:0:1}
#     local dir="simple/$letter/$pkg"
    
#     echo '<!DOCTYPE html>
# <html>
# <head>
#     <meta name="pypi:repository-version" content="1.0">
#     <title>Links for '"$pkg"'</title>
# </head>
# <body>
#     <h1>Links for '"$pkg"'</h1>' > "$dir/index.html"
    
    # for wheel in "$dir"/*.whl; do
    #     if [ -f "$wheel" ]; then
    #         filename=$(basename "$wheel")
    #         echo '    <a href="'"$filename"'">'"$filename"'</a><br/>' >> "$dir/index.html"
    #     fi
    # done
    
#     echo '</body>
# </html>' >> "$dir/index.html"
# }

# # Create package indexes
# for pkg in numpy pandas requests flask; do
#     create_package_index "$pkg"
# done

# # Create main index
# echo '<!DOCTYPE html>
# <html>
# <head>
#     <meta name="pypi:repository-version" content="1.0">
#     <title>Simple Index</title>
# </head>
# <body>
#     <h1>Simple Index</h1>' > simple/index.html

# for pkg in numpy pandas requests flask; do
#     letter=${pkg:0:1}
#     echo '    <a href="'"$letter"'/'"$pkg"'/">'"$pkg"'</a><br/>' >> simple/index.html
# done

# echo '</body>
# </html>' >> simple/index.html

# # Set permissions
# chmod -R 755 simple
# find simple -type f -exec chmod 644 {} \;

cd .. 