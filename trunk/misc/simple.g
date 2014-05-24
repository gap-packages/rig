LoadPackage("rig");

#InstallGlobalFunction("IsomorphismRacks", function(rack1, rack2)
#  local i, basis, f, s, pi, p; 
#
#  if Size(rack1) <> Size(rack2) then
#    return false;
#  fi;
#
#  ### compute a minimal generating set 
#  basis := MinimalGeneratingSubset(rack1);
#
#  for f in Combinations([1..Size(rack1)], Size(basis)) do
#    for s in PermutationsList(f) do
#      pi := [1..Size(rack1)] * 0; 
#      for i in [1..Size(basis)] do
#        pi[basis[i]] := s[i];
#      od;
#      p := ExtendMorphism(rack1, rack2, pi);
#      if p <> false and PermList(p) <> fail then 
#        if IsIsomorphicByPermutation(rack1, rack2, PermList(p)) = true then
#          return PermList(p);
#        fi;
#      fi;
#    od;
#  od;
#  return fail;
#end);

is_morphism := function(f, r, s)
  local i, j;
  for i in [1..Size(r)] do
    for j in [1..Size(r)] do
      if not f[RackAction(r, i, j)] = RackAction(s, f[i], f[j]) then
        return false;
      fi;
    od;
  od;
  return true;
end;

is_nontrivial_quotient := function(r, s)
  local f, h; 
  h := Hom(r, s);
  for f in h do
    if not Size(Unique(f)) = 1 then
      return true;
    fi;
  od;
  return false;
end;


# This function computes the transvection group of a rack 
transvections_group := function(rack)
  local x, y, gens, p;
  gens := [];
  p := Permutations(rack);
  for x in [1..Size(rack)] do
    for y in [1..Size(rack)] do
      Add(gens, Inverse(p[x])*p[y]);
    od;
  od;
  return Group(gens);
end;

# This function checks if the rack is simple
is_simple := function(rack)
  local inn, trans, sizes;
  inn := InnerGroup(rack);

  if not IsQuandle(rack) then
    Print("Only for quandles!\n");
    return fail;
  fi;

  # If Q is simple then Q has more than two elements
  if Size(rack) < 3 then
    return false;
  fi;

  if not IsFaithful(rack) then
    Print("nofiel");
    return false;
  fi;

  # A simple quandle Q satisfies that Z(Inn(Q)) is trivial
  if Size(Center(inn)) <> 1 then
    Print("centro");
    return false;
  fi;

  # If Q is a simple quandle and G=Inn(Q) then G/[G,G] is cyclic
  trans := TransvectionsGroup(rack);
  if not IsCyclic(inn/trans) then
    Print("cocientenociclico");
    return false;
  fi;

  # If Q is a simple quandle then [G,G] is the smallest non-trivial normal subgroup of Inn(Q)
  sizes := List(NormalSubgroups(inn), x->Size(x));
  Display(Size(trans));

  if Position(SortedList(sizes), Size(trans)) <> 2 then
    Print("ladelnormal");
    return false;
  fi;

  return true;
end;

