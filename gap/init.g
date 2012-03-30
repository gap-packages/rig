ReadPackage("rig", "gap/basic.gd");
ReadPackage("rig", "gap/subracks.gd");
ReadPackage("rig", "gap/nichols.gd");
ReadPackage("rig", "gap/utils.gd");
ReadPackage("rig", "gap/homology.gd");
ReadPackage("rig", "gap/polynomial.gd");
ReadPackage("rig", "gap/braid.gd");
ReadPackage("rig", "small/quandles.gd");
ReadPackage("rig", "gap/extensions.gd");
ReadPackage("rig", "gap/affine.gd");
ReadPackage("rig", "gap/derivations.gd");

#if LoadPackage("gbnp") <> fail then
#  ReadPackage("rig", "gap/derivations.gd");
#else
#  Print("### gbnp was not found, derivations.gd was not loaded.\n");
#fi;
