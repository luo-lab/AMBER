#!/bin/sh
#
# Perform minimisation and MD simulation to prepare the simulation box
# for TI simulation. This is done primarily to adjust the density of the
# system because leap will create a water box with far too low density.
#

basedir=$(pwd)

cd peptide_prepare
./run_all_md.sh
cd $basedir

