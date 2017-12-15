#!/bin/sh
# After equil you have the vdw transformation prmtop and restart files
# We need to generate the decharge and recharge files now. This will
# strip the results of our equil, so those can be put in LEAP to
# generate those files.
#

cpptraj=$AMBERHOME/bin/cpptraj

for s in peptide; do
  if [ -f ${s}_prepare/press.rst7 ]; then
    cp ${s}_vdw_bonded.rst7 ${s}_vdw_bonded.rst7.leap
    cp ${s}_prepare/press.inpcrd ${s}_vdw_bonded.inpcrd
  fi

  $cpptraj -p ${s}_vdw_bonded.prmtop <<_EOF
trajin ${s}_prepare/press.rst7

# remove the two ligands and keep the rest
strip ":4-999999"
outtraj ${s}_HIE.pdb onlyframes 1

# remove the MHP dipeptide
unstrip
strip ":2,5-999999"
outtraj ${s}_MHP.pdb onlyframes 1

# extract the solvent
unstrip
strip ":1-4"
outtraj water.pdb onlyframes 1

_EOF
done
