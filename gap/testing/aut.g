LoadPackage("rig");

### OLD function to compute the automorphism group of a rack
automorphism_group := function(rack)
#  "Returns the automorphism group of <rack>",
#  [IsRecord],
#  function(rack)
  local i, f, s, pi, p, gens; 

  gens := [];

  ### compute a minimal generating set 
        if rack.basis = "" then
    rack.basis := MinimalGeneratingSubset(rack);
        fi;

  for f in Combinations([1..Size(rack)], Size(rack.basis)) do
    for s in PermutationsList(f) do
      pi := [1..Size(rack)] * 0; 
      for i in [1..Size(rack.basis)] do
        pi[rack.basis[i]] := s[i];
      od;
      p := ExtendMorphism(rack, rack, pi);
      if p <> false and PermList(p) <> fail then 
        Add(gens, PermList(p));
      fi;
    od;
  od;
  return Group(gens);
end;

