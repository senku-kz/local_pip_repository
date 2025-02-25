#!/bin/bash
# Create the simple directory structure
mkdir -p pip-repo/simple

# For each package directory in pip-repo
for pkg in pip-repo/*/ ; do
  if [ -d "$pkg" ]; then
    pkg_name=$(basename "$pkg")
    # Create the package directory under simple
    mkdir -p "pip-repo/simple/$pkg_name"
    # Create symlinks to all wheel files
    for wheel in "$pkg"*.whl; do
      if [ -f "$wheel" ]; then
        ln -sf "../../$pkg_name/$(basename "$wheel")" "pip-repo/simple/$pkg_name/"
      fi
    done
    # Create an index.html file with links to all wheels
    echo "<html><body>" > "pip-repo/simple/$pkg_name/index.html"
    for wheel in "$pkg"*.whl; do
      if [ -f "$wheel" ]; then
        wheel_name=$(basename "$wheel")
        echo "<a href=\"$wheel_name\">$wheel_name</a><br/>" >> "pip-repo/simple/$pkg_name/index.html"
      fi
    done
    echo "</body></html>" >> "pip-repo/simple/$pkg_name/index.html"
  fi
done

# Create the main index.html
echo "<html><body>" > "pip-repo/simple/index.html"
for pkg in pip-repo/simple/*/ ; do
  if [ -d "$pkg" ]; then
    pkg_name=$(basename "$pkg")
    echo "<a href=\"$pkg_name\">$pkg_name</a><br/>" >> "pip-repo/simple/index.html"
  fi
done
echo "</body></html>" >> "pip-repo/simple/index.html" 