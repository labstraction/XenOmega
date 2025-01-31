#pip install makelove
#! /usr/bin/bash

makelove lovejs

unzip -o ./makelove-build/lovejs/XenOmega-lovejs.zip -d ./gamepath

python -m http.server --directory ./gamepath/XenOmega