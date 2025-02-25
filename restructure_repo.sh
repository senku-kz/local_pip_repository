#!/bin/bash

# Navigate to the simple directory
cd pip-repo/simple || exit 1

# Find all single-letter directories and process their contents
for letter_dir in [a-z]/; do
    if [ -d "$letter_dir" ]; then
        echo "Processing directory: $letter_dir"
        
        # Move all package directories up one level
        for pkg_dir in "$letter_dir"*/; do
            if [ -d "$pkg_dir" ]; then
                pkg_name=$(basename "$pkg_dir")
                echo "Moving package: $pkg_name"
                
                # Move the package directory to the simple root
                mv "$pkg_dir" ./
            fi
        done
        
        # Remove the empty letter directory
        rmdir "$letter_dir"
        echo "Removed directory: $letter_dir"
        echo "---"
    fi
done

# # Update main index.html to remove letter-based paths
# if [ -f "index.html" ]; then
#     echo "Updating main index.html..."
#     for pkg in */; do
#         if [ -d "$pkg" ]; then
#             pkg_name=$(basename "$pkg")
#             # Create temporary index with updated links
#             echo "<html><head><title>Simple Index</title></head><body><h1>Simple Index</h1>" > index.html.tmp
#             for p in */; do
#                 p_name=$(basename "$p")
#                 echo "<a href=\"${p_name}\">${p_name}</a><br/>" >> index.html.tmp
#             done
#             echo "</body></html>" >> index.html.tmp
#             mv index.html.tmp index.html
#             break
#         fi
#     done
# fi

echo "Repository restructuring complete!" 