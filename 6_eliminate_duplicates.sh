#!/bin/sh
# We need to peform TI merge again to fix our recharge
# and decharge prmtop and inpcrd files
#

parmed peptide_recharge.prmtop <<_EOF
loadRestrt peptide_recharge.inpcrd
setOverwrite True
tiMerge :1-3 :4-6 :2 :5
outparm merged_peptide_recharge.prmtop merged_peptide_recharge.inpcrd
quit
_EOF

parmed peptide_decharge.prmtop <<_EOF
loadRestrt peptide_decharge.inpcrd
setOverwrite True
tiMerge :1-3 :4-6 :2 :5
outparm merged_peptide_decharge.prmtop merged_peptide_decharge.inpcrd
quit
_EOF
