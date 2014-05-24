LoadPackage("rig");

2nd_quandlehomology_generators := function(size, number)
  local known, implemented, dir, filename;

  # If n is prime then the 2nd homology is trivial
  if IsPrime(size) then
    return rec( factors := [ ], generators := [ List([1..size^2], x->0) ]);
  fi;

  known := IsBound(TWOCOCYCLES[size]);
  if not known then
    dir := DirectoriesPackageLibrary("rig", "cohomology")[1];
    filename := Filename(dir, Concatenation("q", String(size), ".g"));
    if IsReadableFile(filename) then
      Read(filename);
    else
      Error("Not implemented!");
    fi;
  fi;
  if number <= TWOCOCYCLES[size].implemented then
    return TWOCOCYCLES[size].quandle[number];
  else
    Error("there are just ", NrSmallQuandles(size), " indecomposable quandles of size ", size);
  fi;
end;

### This function returns the generators of the generators of the 2nd quandle homology group of SmallQuandle(n, i)
### The database was computed with the function TorsionGenerators
2nd_quandlecohomology_generators := function(size, number)
  local k, l, v, q, hom, gens;

  # If n is prime then the 2nd homology is trivial
  if IsPrime(size) then
    return rec( factors := [ ], generators := [ List([1..size^2], x->0) ]);
  fi;

  hom := 2nd_quandlehomology_generators(size, number);
  gens := [];

  for k in [1..Size(hom.generators)] do
    q := NullMat(size, size);
    for l in [1..Size(hom.generators[k])] do
      v := NumberToBasisVector(l, 2, size);
      q[v[1]][v[2]] := AbelianGroup(IsPermGroup, [hom.factors[k]]).1^hom.generators[k][l];
      #q[v[1]][v[2]] := GeneratorsOfGroup(AbelianGroup(IsPermGroup, hom.factors))[k]^hom.generators[k][l];
    od;
    Add(gens, q);
  od;
  return rec( desc := Concatenation("second quandle cohomology group of SmallQuandle(", String(size), ",", String(number), ")"), 
              factors := hom.factors, generators := gens);
end;

is_cohomologous_2cocycle := function(rack, group, f, g)
  local x, y, i, j, gamma, done;
  for gamma in IteratorOfTuples(group, Size(rack)) do
    done := true; 
    for x in [1..Size(rack)] do
      for y in [1..Size(rack)] do
        if f[x][y] = gamma[RackAction(rack, x, y)]*g[x][y]*Inverse(gamma[y]) then
          continue;
        else
          done := false;
        fi;
      od;
      if done then
        return gamma;
      fi;
    od;
  od;
  return done;
end;

