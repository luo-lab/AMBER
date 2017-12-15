#!/bin/sh
#
# This will generate prmtop and inpcrd files for both side chain residues
# Make sure to export and source AMBER if you have not done so
# export AMBERHOME="/home/user/amber16"
source $AMBERHOME/amber.sh

tleap -f - <<_EOF
# load the AMBER force fields
source leaprc.protein.ff14SB
source leaprc.gaff2
source leaprc.water.tip3p

# load force field parameters for your modified resiude (Ex is HIP residue)
loadoff MHP.lib

# load the coordinates and create the systems
m1 = loadpdb peptide.pdb
m2 = loadpdb peptide_MHP.pdb
protein = combine {m1 m2}

# create ligands in solution for vdw+bonded transformation
solvatebox protein TIP3PBOX 12.0 0.75
addions protein Na+ 0
addions protein Cl- 0
savepdb m1 m1.pdb
savepdb m2 m2.pdb
savepdb protein protein.pdb
saveamberparm protein protein.prmtop protein.inpcrd

quit
_EOF
