ReadPackage("rig", "gap/basic.gi" );
ReadPackage("rig", "gap/subracks.gi" );
ReadPackage("rig", "gap/nichols.gi" );
ReadPackage("rig", "gap/homology.gi" );
ReadPackage("rig", "gap/utils.gi" );
ReadPackage("rig", "gap/braid.gi" );
ReadPackage("rig", "gap/polynomial.gi" );
ReadPackage("rig", "small/quandles.gi");
ReadPackage("rig", "gap/extensions.gi");
ReadPackage("rig", "gap/affine.gi");
ReadPackage("rig", "knots/knots.gi");
ReadPackage("rig", "knots/upto9crossings.g");
#ReadPackage("rig", "homology/homology.gi");

if LoadPackage("gbnp") <> fail then
  ReadPackage("rig", "gap/derivations.gi");
else
  Print("### gbnp was not found, derivations.gi was not loaded.\n");
fi;
