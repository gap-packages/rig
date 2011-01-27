### This function computes the generators of the torsion subgroup of the homology
### EXAMPLE:
###   gap> r := TetrahedronRack();;
###   gap> q := TorsionGenerators(r,2)[1];
###   [ [ 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0 ] ]
###   gap> AreHomologous(r,q,q);
###   true

InstallGlobalFunction(TorsionGenerators, 
function(rack, n)
  local a, b, r, t, m, M, i, x, d, q, z, pos, tmp, gens;

  a := SmithNormalFormIntegerMat(BoundaryMap(rack, n-1));
  b := SmithNormalFormIntegerMatTransforms(BoundaryMap(rack, n));
 
  M := Size(rack)^n-Rank(a);

  # non-zero rows of the matrix b, the n-th boundary map
  m := Rank(b.normal);
  
  r := TransposedMat(b.rowtrans);

  d := DiagonalOfMat(b.normal);
  t := Filtered([1..Size(d)], x->d[x]>1);

  gens := [];

  for x in t do
    q := [];
    tmp := r{[1..Size(r)]}[x];
    for i in [1..Size(tmp)] do
      pos := NumberToBasisVector(i, n, Size(rack));
      Add(q, tmp[i] mod d[x]);
    od;
    Add(gens, q);
  od;
  return gens;
end);

InstallGlobalFunction(GetRack, function(group, g)
### Rack
  local data, c, z, t, i, j;

  c := ConjugacyClass(group, g);
  z := Centralizer(group, g);

  data := rec(
    g := [],
    x := [],
    m := []
  );

  for t in Elements(RightTransversal(group, z)) do
    Add(data.g, Inverse(t) * g * t);
    Add(data.x, Inverse(t));
  od;

  data.m := NullMat(Size(c), Size(c));

  for i in [1..Size(c)] do
    for j in [1..Size(c)] do
      data.m[i][j] := Position(data.g, data.g[i] * data.g[j] * Inverse(data.g[i]));
    od;
  od;
  return data;
end);

### GammaMatrix
InstallGlobalFunction(GammaMatrix, function(data)
  local m, n, i, j;
  n := Size(data.g);
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j] := Inverse(data.x[data.m[i][j]])*data.g[i]*data.x[j];
    od;
  od;
  return m;

end);

### Is2Cocycle
InstallGlobalFunction(Is2Cocycle, function(rack, q)
  local i, j, k;
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      for k in [1..Size(rack)] do
        if q[i][rack[j][k]]*q[j][k] <> q[rack[i][j]][rack[i][k]]*q[i][k] then
          return fail;
        fi;
      od;
    od;
  od;
  return true;
end);

### CollectAllNicholsData
InstallGlobalFunction("YetterDrinfeldDatum", function(group, g)
  local data, rack_data, gamma, n, gr_z, cc_z, ir_z, p, q, pos, r, i, j;
#  local data, rack_rr, rack, gamma, p, q, gr_z, cc_z, ir_z, m, tmp, pos, i, j, r, n;

  ### Nichols algebras associated to (group, g)
  data := rec(
    group := group,
    representative := g,
    dimension := "",	
    relations := [],
    top_degree := "",		
    comment := "",
    rack := [],	       
    2cocycles := []
  );		 

  rack_data := GetRack(group, g);
  data.rack := Rack(rack_data.m);
  gamma := GammaMatrix(rack_data);

  n := Size(gamma);

  ### Centralizer of <g> in <group>
  gr_z := Centralizer(group, g);
  ### Conjugacy classes of the centralizer
  cc_z := ConjugacyClasses(gr_z);
  ### Irreducible representation of the centralizer
  ir_z := Irr(CharacterTable(gr_z));

  ### The conjugacy class of >g> in <gr_z>
  p := First([1..Size(cc_z)], x->g in cc_z[x]);

  for r in ir_z do
    if r[1]=1 then 
      q := NullMat(n,n);
      for i in [1..n] do
        for j in [1..n] do
          pos := First([1..Length(cc_z)], x->gamma[i][j] in cc_z[x]);
          q[i][j] := r[pos];
        od;
      od;
      Add(data.2cocycles, q);
    else
      Print("### I found a representation of degree >1\n");
    fi;
  od;
  return data;
end);

# t=transposition of the form (i,i+1)
# rack=rack
# q=2-cocycle
# n=rank
# The braiding c_(i,j)
InstallGlobalFunction("MatrixOfRestrictedBraiding", function(data, t, n)
  local m, i, v, x, y, r, rank, rack, q;

  rack := data.rack;
  rank := Size(data.rack);
  q := data.q;
  x := MovedPoints(t)[1];
  y := MovedPoints(t)[2];

  if not x in [1..n] or not y in [1..n] or not Order(t)=2 then
    return fail;
  fi;
  m := NullMat(rank^n, rank^n, data.field);

  for i in [1..rank^n] do
    v := NumberToBasisVector(i, n, rank);
    r := ShallowCopy(v);
    r[x] := rack.matrix[v[x]][v[y]];
    r[y] := v[x];
    m[BasisVectorToNumber(r, rank)][BasisVectorToNumber(v, rank)] := m[BasisVectorToNumber(r, rank)][BasisVectorToNumber(v, rank)] + q[v[x]][v[y]]; 
  od;
  return m;
end);

### The quantum symmetrizer
InstallGlobalFunction("QuantumSymmetrizer", function(data, n)
  local rank, p, c, i, m;
  rank := Size(data.rack);
  if n = 2 then
    return IdentityMat(rank^n, data.field)+MatrixOfRestrictedBraiding(data, (1,2), n);
  fi;

  p := []; 
  c := [];
  m := IdentityMat(rank^n, data.field);

  for i in [1..n-1] do
    Add(p, (i,i+1));
  od;
  
  for i in [1..n-1] do
    Add(c, MatrixOfRestrictedBraiding(data, p[n-i], n));
  od;

  for i in [1..n-1] do
    m := m+Product(c);
    Remove(c, 1);
  od;
  return m*KroneckerProduct(IdentityMat(rank, data.field), QuantumSymmetrizer(data, n-1));
end);

### Relations for gbnp package
InstallGlobalFunction("Relations4GAP",
### Returns the relations of the Nichols algebra in degree less or equal than <n>
### [IsRack, IsMatrix, IsInt],
function(data, degree)
  local m, ns, i, j, a, b, res;
  
  m := QuantumSymmetrizer(data, degree);
  TransposedMatDestructive(m);
  ns := NullspaceMatDestructive(m);
  res := [];

  for i in [1..Size(ns)] do
    a := [];
    b := [];
    for j in [1..Size(ns[1])] do
      if ns[i][j] <> 0 then
        Add(a, NumberToBasisVector(j, degree, Size(data.rack)));
        Add(b, ns[i][j]);
      fi;
    od;
    Add(res, [a,b]);
  od;
  return res;
end);

### Dimension of the Nichols algebra in degree <n>
InstallOtherMethod(Dimension,
[IsRecord, IsInt],
function(data, n)
  local m, ns, i, j, a, b, res;
  if n=0 then
    return 1;
  elif n=1 then
    return Size(data.rack);
  fi;
  m := QuantumSymmetrizer(data, n);
  return RankMatDestructive(m);
end);

InstallGlobalFunction("NicholsDatum",
function(rack, q, field)
  return rec( rack := rack, q := q, field := field );
end);

InstallGlobalFunction("_chi", function(sigma, tau)
  local i,j;
  i := MovedPoints(tau)[1];
  j := MovedPoints(tau)[2];
  if i^sigma < j^sigma then
    return 1;
  else
    return -1;
  fi;
end);
 
InstallGlobalFunction("FK2Cocycle", function(n)
  local e,i,j,q;
  e := Elements(ConjugacyClass(SymmetricGroup(n),(1,2)));
  q := NullMat(Size(e),Size(e));
  for i in [1..Size(e)] do
    for j in [1..Size(e)] do
      q[i][j] := _chi(e[i],e[j]);
    od;
  od;
  return q;
end);

InstallGlobalFunction("Constant2Cocycle", function(lambda, n)
  return lambda*(NullMat(n,n)+1);
end);

