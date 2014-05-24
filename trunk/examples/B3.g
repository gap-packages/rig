##################
### file: B3.g ###
##################

### DESCRIPTION
###
### 1) HurwitzOrbit2DOT: Write the Hurwitz braid orbit graph in graphiviz format
### 2) StrongIsomorphismHurwitzOrbits: Checks if two Hurwitz orbits are strongly isomorphic
### 3) CheckStrongIsomorphismsOfHurwitzOrbits: Checks if all orbits of a given size are strongly isomorphic
###
### REMARKS
### * This file contains some special functions that only works for the braid group B3
### * The io package is required for writing the Hurwitz graph to a file

LoadPackage("rig");
LoadPackage("io");

### HurwitzOrbit2DOT
### This function returns the graph of the orbit of B_3 associated to v
### REMARK: Only works for B_3
HurwitzOrbit2DOT := function(rack, v, filename)
  local i, o, str, f;
  
  if not Size(v) = 3 then
    return fail;
  fi;

  o := HurwitzOrbit(rack, v);
  if LoadPackage("io") = fail then
    Print("digraph test {\n");
    for i in [1..Size(o)] do
      Print(i, " -> ", Position(o, HurwitzAction(rack, 1, o[i])), " [color=black];\n");
      Print(i, " -> ", Position(o, HurwitzAction(rack, 2, o[i])), " [color=red];\n");
    od;
    Print("}\n");
    return;
  fi;

  f := IO_File(Concatenation(filename, ".dot"), "w");
  IO_WriteLine(f,"// Rack of size ", Size(rack), " and degre ", Degree(rack));
  IO_WriteLine(f,"digraph test {");
  for i in [1..Size(o)] do
    IO_WriteLine(f, "\"", o[i], "\" -> \"", HurwitzAction(rack, 1, o[i]), "\" [color=black];");
    IO_WriteLine(f, "\"", o[i], "\" -> \"", HurwitzAction(rack, 2, o[i]), "\" [color=red];");
  od;
  IO_WriteLine(f, "}");
  IO_Flush(f);
  IO_Close(f);
end;

### This function checks if the orbits of v and w are strongly isomorphic
### Two orbits are strongly if they are isomorphic by (f,f,f), where f is a rack inner automorphism 
### REMARK: Only works for B_3
StrongIsomorphismHurwitzOrbits := function(rack, ov, ow)
  local aut, f, new;
  if not Size(ov) = Size(ow) then
    return fail;
  fi;
  aut := InnerGroup(rack);#AutomorphismGroup(rack);
  for f in aut do
    new := List([1..Size(ov)], x->[ov[x][1]^f, ov[x][2]^f, ov[x][3]^f]);
    if Set(new) = Set(ow) then
      return f;
    fi;
  od;
  return fail;
end;

### This function checks if any two orbits of size m are isomorphic
### It returns true if they are isomorphic. Otherwise it returns some [v, w]
### An isomorphism of Hurwitz orbits is a permutation that commutes with the generators of B_n
### REMARK: Only works for B_3
CheckStrongIsomorphismsOfHurwitzOrbits := function(rack, m)
  local all, x, y;

  all := Filtered(HurwitzOrbits(rack, 3), x->Size(x)=m);
  if all = [] then
    return fail;
  fi;

  x := all[1];
  for y in all do
    if not x = y then
      if StrongIsomorphismHurwitzOrbits(rack, x, y) = fail then
        return [x[1], y[1]];
      fi;
    fi;
  od;
  return true;
end;
