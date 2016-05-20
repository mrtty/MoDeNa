#!/bin/bash
# export PKG_CONFIG_PATH=${PKG_CONFIG_PATH:-}:${HOME}/lib/pkgconfig:/usr/local/lib/pkgconfig
# export PYTHONPATH=${PYTHONPATH:-}:${HOME}/lib/python2.7/site-packages/modena
# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:${HOME}/lib/python2.7/site-packages:${HOME}/lib/modena:/usr/local/lib
cp -r ../inputs/* ./
# cp -r ../run/constant ./
# cp -r ../run/system ./
# cp ../run/getMeReady.sh ./
# cp ../run/case.foam ./
./getMeReady.sh
blockMesh
setFields
rm -fv log
echo "MODENAFoam is running..."
${FOAM_USER_APPBIN}/MODENAFoam >& log
echo "Post-processing..."
probeLocations
cd postProcessing/probes/0/
for file in $(ls *);
        do
                sed '/^#/d' $file > $file.txt;
        done
ls > list
egrep -v '*txt' list > list2
mv list2 list
rm -rf $(<list)
cp *.txt ../../../../results/CFD3D/
echo "Done."