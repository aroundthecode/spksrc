#!/bin/bash
make clean | grep "Leaving directory" 2>&1
make setup | grep "Leaving directory" 2>&1
make -C spk/python3 arch-armada370  | grep "Leaving directory" 2>&1
tar -xvf packages/python3_armada370-6.1_3.6.8-9.spk -C packages/
tar -zxvf packages/package.tgz -C packages/
for i in $(ls packages/share/wheelhouse/*.whl)
do
  echo $i
  curl -F package=@${i} https://${GEMFIRE_TOKEN}@push.fury.io/aroundthecode/
done