rebuild:
	rm -rf build .venv dubins/dubins.c __pycache__
	uv venv --python 3.10
	uv pip install --no-cache --verbose .
