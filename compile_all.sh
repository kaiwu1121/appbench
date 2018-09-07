#!/bin/bash
set -x
BASE=$CODEBASE


#create empty file
touch $BASE/dummy.txt

INSTALL_SHAREDLIB() {
  cd $SHARED_LIBS/hoardlib
  ./compile_install_hoard.sh
  cd $SHARED_LIBS/mmap_lib
  make clean && make && sudo make install
}

INSTALL_SHAREDLIB

cd $BASE
cd phoenix-2.0/
make clean && make -j4
cd tests/word_count/
rm -rf results/*experiments*out tmp*.txt && mkdir result
make clean && make -j4
cp $BASE/dummy.txt tmp1.txt


cd $BASE
cd graphchi/graphchi-cpp
make clean && make -j8

cd $BASE
cd redis-3.0.0/src 
make clean && make all -j8

cd $BASE
cd Metis
make clean 
./configure && make -j8

cd $BASE
cd leveldb
make clean
make -j8

exit


