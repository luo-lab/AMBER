#!/bin/sh
# Now you will need to merge the two PDB files. Replace the length of your
# protein over mine below. My example is for 3 residues (1-3, 4-6), and my
# residue which is changing is residue 2, and residue 5
#

parmed protein.prmtop <<_EOF
loadRestrt protein.inpcrd
setOverwrite True
tiMerge :1-3 :4-6 :2 :5
outparm merged_protein.prmtop merged_protein.inpcrd
quit
_EOF
