#######################
### braids 
#######################

### This function computes the orbit of the element v=(i,j) 
### under the action of the braiding.
InstallGlobalFunction("BraidedOrbit",
###  "Computes the braided orbit of v",
###  [IsRack, IsList],
  function(rack, v)
  local i,j,l;
  l := [];
  while not v in l do
    Add(l, v);
    i := v[1];
    j := v[2];
    v := [rack!.matrix[i][j], i];
  od;
  return l;
end);

### This function computes all the orbits and return 
### the representatives of classes, with sizes.
InstallGlobalFunction("BraidedRepresentatives",
###  "Returns a list of representatives of classes under the braided action",
###  [IsRack],
  function(rack)
  local reps,tmp,o,i,j;
  reps := [];
  tmp := [];
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      o := BraidedOrbit(rack, [i,j]);
      if Intersection(o,tmp) = [] then
	Add(tmp, o[1]);
	Add(reps, [o[1], Size(o)]);
      fi;
    od;
  od;
  return reps;
end);

### k(rack,n) is the total number of j such that the orbit of 
### (1,j) has length n.
InstallGlobalFunction("Nr_k",
  function(rack, n)
  local j,m;
  m := 0;
  for j in [1..Size(rack)] do
    if Size(BraidedOrbit(rack, [1, j])) = n then
      m := m+1;
    fi;
  od;
  return m;
end);

### l(rack,n) is the number of orbits of size n
### IMPORTANT: <rack> needs to be of group-type
InstallGlobalFunction("Nr_l",
  function(rack, n)
  return Size(rack)*Nr_k(rack,n)/n;
#  local r, f, x;
#  r := representatives(rack);
#  f := Filtered(r, x->x[2] = n);
#  return Size(f);
end);

### This function computes the braiding associated to <rack>
InstallGlobalFunction("Braiding",
  function(rack)
  local m,x;
  x := NullMat(Size(rack),Size(rack))+1;                        
  m := QuantumSymmetrizer(rack, x, 2)-IdentityMat(Size(rack)*Size(rack));;
  return m;
end);

### This function returns the finite quotient of the enveloping group
### IMPORTANTE: only works for indecomposable racks
InstallGlobalFunction("FiniteEnvelopingGroup", function(rack)
  local n, f, x, rels, i, j, p;
  n := Size(rack);
  
  if not IsIndecomposable(rack) then
    return fail;
  fi;

  f := FreeGroup(n);
  x := GeneratorsOfGroup(f); 
  
  rels := [];
  
  for i in [1..n] do
    for j in [1..n] do
      Add(rels, x[i]*x[j]*Inverse(x[rack!.matrix[i][j]]*x[i]));
    od;
  od;
  for i in [1..n] do
    p := PermList(rack!.matrix[i]);
    for j in [1..n] do
      Add(rels, x[i]^Order(p));
    od;
  od;
  return f/rels;
end);


### This function applies c_(i,i+1) to v=(x1,x2,...,xn)
InstallGlobalFunction("HurwitzAction", function(rack, i, v)
  local w;
  w := StructuralCopy(v);
  if i < Size(v) then
    w[i] := rack.matrix[v[i]][v[i+1]];
    w[i+1] := v[i];
    return w;
  fi;
end);

### This function computes the orbit of B_n acting on v
InstallGlobalFunction("HurwitzOrbit", function(rack, v)
  local o, l, t, i, w,  x, stop; 
  o := [v];
  l := [v];
  stop := false;
  while not stop do
    stop := true;
    for x in o do
      for i in [1..Size (v)-1] do
        w := HurwitzAction(rack, i, x);
        if not w in o then
          stop := false;
          Add(o, w);
        fi;
      od;
    od;
  od;
  return o;
end);

### This function computes all the orbits of the braid group B_n acting on the set X^n
InstallGlobalFunction("HurwitzOrbits", function(rack, n)
  local a,x,y,o,l;
  a := [];
  l := [];
  for x in Tuples([1..Size(rack)], n) do 
    if not x in a then
      o := HurwitzOrbit(rack, x);
      Add(l,o);
      for y in o do
        Add(a, y);
      od;
    fi;
  od;
  return l;
end);

### This function counts the number of n-Hurwitz orbits of size m
InstallGlobalFunction("NrHurwitzOrbits", function(rack, n, m)
  local all,x,i; 
  i:=0;
  all:=HurwitzOrbits(rack, n);
  for x in all do
    if Size(x) = m then
      i := i+1;
    fi;
  od;    
  return i;
end);

### This function returns the sizes of the Hurwitz orbits 
InstallGlobalFunction("SizesHurwitzOrbits", function(rack, n)
  local all,x,s; 
  s := [];
  all := HurwitzOrbits(rack, n);
  for x in all do
    if not Size(x) in s then
      Add(s, Size(x));
    fi;
  od;    
  return s; 
end);

### This function returns a list with one representative per orbit
InstallGlobalFunction("HurwitzOrbitsRepresentatives", function(rack, n)
  local all, x, reps;
  reps := [];
  all := HurwitzOrbits(rack, n);
  for x in all do
    Add(reps, x[1]);
  od;
  return reps;
end);

### This function returns a list with one representative per orbit and its size
InstallGlobalFunction("HurwitzOrbitsRepresentativesWS", function(rack, n)
  local all, x, reps;
  reps := [];
  all := HurwitzOrbits(rack, n);
  for x in all do
    Add(reps, [x[1], Size(x)]);
  od;
  return reps;
end);

