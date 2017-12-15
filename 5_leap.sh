#!/bin/sh
#
# Create the prmtop and inpcrd files for the decharging and recharging steps.
# The coordinates are taken from the previous vdw+bonded step.
#

tleap=$AMBERHOME/bin/tleap

tleap -f - <<_EOF
# load the AMBER force fields
source leaprc.protein.ff14SB
source leaprc.gaff2
source leaprc.water.tip3p

# load force field parameters for MHP
loadoff MHP.lib

# coordinates for solvated peptide as created previously by MD
w = loadpdb water.pdb
m1 = loadpdb peptide_HIE.pdb
m2 = loadpdb peptide_MHP.pdb

# decharge transformation
decharge = combine { m1 m1 w }
setbox decharge vdw
savepdb decharge peptide_decharge.pdb
saveamberparm decharge peptide_decharge.prmtop peptide_decharge.inpcrd

# recharge transformation
recharge = combine { m2 m2 w }
setbox recharge vdw
savepdb recharge peptide_recharge.pdb
saveamberparm recharge peptide_recharge.prmtop peptide_recharge.inpcrd

quit
_EOF
