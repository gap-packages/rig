######################################
### functions used to define racks ###
######################################
DeclareGlobalFunction("Rack");
DeclareGlobalFunction("RackFromPermutations");
DeclareGlobalFunction("AffineCyclicRack");
DeclareGlobalFunction("TrivialRack");
DeclareGlobalFunction("CyclicRack");
DeclareGlobalFunction("AbelianRack");
DeclareGlobalFunction("ConjugationRack");
DeclareGlobalFunction("DihedralRack");
DeclareGlobalFunction("AlexanderRack");
DeclareGlobalFunction("AffineRack");
DeclareGlobalFunction("RackFromAConjugacyClass");
DeclareGlobalFunction("RackFromConjugacyClasses");
DeclareGlobalFunction("CoreRack");
DeclareGlobalFunction("HomogeneousRack");
DeclareGlobalFunction("TetrahedronRack");
DeclareGlobalFunction("InverseTetrahedronRack");
DeclareGlobalFunction("TwistedHomogeneousRack");

DeclareGlobalFunction("LocalExponent");
DeclareGlobalFunction("LocalExponents");

DeclareGlobalFunction("InverseRackAction");
DeclareGlobalFunction("RackAction");

####################
### internal use ###
####################
DeclareGlobalFunction("IsRack");
DeclareGlobalFunction("IsCrossedSet");
DeclareGlobalFunction("IsRackMatrix");
DeclareGlobalFunction("ApplyLabels");
DeclareGlobalFunction("NewRack");

#########################
### rack isomorphisms ###
#########################
DeclareGlobalFunction("MinimalGeneratingSubset");
DeclareGlobalFunction("IsomorphismRacks");
DeclareGlobalFunction("IsQuotient");
DeclareGlobalFunction("IsIsomorphicByPermutation");
DeclareGlobalFunction("ExtendMorphism");

################################
### about the rack structure ###
################################
DeclareGlobalFunction("Components");
DeclareGlobalFunction("Permutations");
DeclareGlobalFunction("InnerGroup");
DeclareGlobalFunction("RackOrbit");
DeclareGlobalFunction("EnvelopingGroup");
DeclareGlobalFunction("YDGroup");
DeclareGlobalFunction("IsFaithful");
DeclareGlobalFunction("IsHomogeneous");
DeclareGlobalFunction("IsDecomposable");
DeclareGlobalFunction("IsIndecomposable");
DeclareGlobalFunction("IsConnected");
DeclareGlobalFunction("IsBraided");
DeclareGlobalFunction("Affinise");

##################
### operations ###
##################
DeclareGlobalFunction("DirectProductOfRacks");
DeclareGlobalFunction("PermuteRack");
DeclareGlobalFunction("Power");
