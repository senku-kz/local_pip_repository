pip download --only-binary :all: numpy pandas

# Setting up a local PEP 503 compatible pip repository

## Download packages
```bash
# Create base directory
mkdir -p pip-repo
cd pip-repo

# Download packages with all dependencies
pip3 download numpy --no-deps
pip3 download pandas --no-deps
pip3 download requests --no-deps
pip3 download flask --no-deps

# Create simple repository structure
mkdir -p simple/numpy simple/pandas simple/requests simple/flask

# Move files to their package directories
mv numpy-*.whl simple/numpy/
mv pandas-*.whl simple/pandas/
mv requests-*.whl simple/requests/
mv flask-*.whl simple/flask/

# Create index.html files for each package
for pkg in numpy pandas requests flask; do
    echo "<html><head><title>Links for ${pkg}</title></head><body><h1>Links for ${pkg}</h1>" > simple/${pkg}/index.html
    for wheel in simple/${pkg}/*.whl; do
        filename=$(basename $wheel)
        echo "<a href=\"${filename}\">${filename}</a><br/>" >> simple/${pkg}/index.html
    done
    echo "</body></html>" >> simple/${pkg}/index.html
done

# Create main index.html
echo "<html><head><title>Simple Index</title></head><body><h1>Simple Index</h1>" > simple/index.html
for pkg in numpy pandas requests flask; do
    echo "<a href=\"${pkg}\">${pkg}</a><br/>" >> simple/index.html
done
echo "</body></html>" >> simple/index.html

cd ..
```

## Run the repository server
```bash
docker-compose up -d
```

## Test the repository
```bash
# Check if the index is accessible
curl http://localhost:8080/simple/

# Check a specific package
curl http://localhost:8080/simple/numpy/
```

## Create a Python virtual environment
```bash
python3 -m venv myenv
source myenv/bin/activate
```

## Install packages
```bash
# Install a package from the local repository
pip install --index-url http://pip_repository:80/simple/ --trusted-host 0.0.0.0 numpy --no-deps
```

```bash
docker run -it --rm -v ./pip.conf:/etc/pip.conf python:3.9 bash -c "pip install numpy --no-deps"


docker run -it --rm -v ./pip.conf:/etc/pip.conf --network pip-repository_pip_network python:3.13 bash -c "echo '0.0.0.0 pip_repository' >> /etc/hosts && pip install numpy --no-deps"
```

