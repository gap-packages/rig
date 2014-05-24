InstallGlobalFunction("BoundaryMap2",
  function(rack)
    local m, n, i, x, y, xy;
    n := Size(rack);
    m := NullMat(n, n^2);
    for x in [1..n] do
      for y in [1..n] do
        i := (x-1)*n+y;
        xy := rack!.matrix[x][y];
        m[y][i] := m[y][i] - 1;
        m[xy][i] := m[xy][i] + 1;
      od;
    od;
    return m;
end);

InstallGlobalFunction("BoundaryMap3",
  function(rack)
    local m, n, i, x, y, z, xy, xz, yz;
    n := Size(rack);
    m := NullMat(n^2, n^3);
    for x in [1..n] do
      for y in [1..n] do
        for z in [1..n] do
          i := (x-1)*n^2+(y-1)*n+z;
          xy := rack!.matrix[x][y];
          xz := rack!.matrix[x][z];
          yz := rack!.matrix[y][z];
          m[(y-1)*n+z][i] := m[(y-1)*n+z][i] - 1;
          m[(xy-1)*n+xz][i] := m[(xy-1)*n+xz][i] + 1;
          m[(x-1)*n+z][i] := m[(x-1)*n+z][i] + 1;
          m[(x-1)*n+yz][i] := m[(x-1)*n+yz][i] - 1;
        od;
      od;
    od;
    return m;
end);

InstallGlobalFunction("BoundaryMap4",
  function(rack)
    local a, b, c, d, ab, ac, ad, bc, bd, cd, i, n, m;
    n := Size(rack);
    m := NullMat(n^3, n^4);
    for a in [1..n] do
      for b in [1..n] do
        for c in [1..n] do
          for d in [1..n] do
            i := (a-1)*n^3+(b-1)*n^2+(c-1)*n+d;
            ab := rack!.matrix[a][b];
            ac := rack!.matrix[a][c];
            ad := rack!.matrix[a][d];
            bc := rack!.matrix[b][c];
            bd := rack!.matrix[b][d];
            cd := rack!.matrix[c][d];
            m[(b-1)*n^2+(c-1)*n+d][i] := m[(b-1)*n^2+(c-1)*n+d][i] - 1;
            m[(ab-1)*n^2+(ac-1)*n+ad][i] := m[(ab-1)*n^2+(ac-1)*n+ad][i] + 1;
            m[(a-1)*n^2+(c-1)*n+d][i] := m[(a-1)*n^2+(c-1)*n+d][i] + 1;
            m[(a-1)*n^2+(bc-1)*n+bd][i] := m[(a-1)*n^2+(bc-1)*n+bd][i] - 1;
            m[(a-1)*n^2+(b-1)*n+d][i] := m[(a-1)*n^2+(b-1)*n+d][i] - 1;
            m[(a-1)*n^2+(b-1)*n+cd][i] := m[(a-1)*n^2+(b-1)*n+cd][i] + 1;
          od;
        od;
      od;
    od;
    return m;
end);

#InstallMethod(RackCohomologyXXX,
#  "Calculates abelian rack cohomology",
#  [IsRack, IsInt],
#  function(rack, n)
#    local a, b, c, t, z, w, betti;
#
#    if not n in [1,2,3] then 
#      return fail;
#    fi;
#
#    a := SmithNormalFormIntegerMat(BoundaryMap2(rack));
#    b := SmithNormalFormIntegerMat(BoundaryMap3(rack));
#
#    if n = 1 then
#      t := Filtered(DiagonalOfMat(a), x->x>1);
#      return [t, Size(rack)-Rank(a)];
#    elif n = 2 then
#      t := Filtered(DiagonalOfMat(b), x->x>1); 
#      return [t, Size(rack)^2 - Rank(a) - Rank(b)]; 
#    elif n = 3 then
#      c := SmithNormalFormIntegerMat(BoundaryMap4(rack));
#      t := Filtered(DiagonalOfMat(c), x->x>1);
#      return [t, Size(rack)^3 - Rank(b) - Rank(c)];
#    fi;
#end);


### This function computes the abelian rack cohomology
InstallGlobalFunction("RackCohomology",
  function(rack, n)
    local a, b, t, m, M;

    if not n > 0 then 
      return fail;
    fi;

    # ok?
    b := TransposedMat(SmithNormalFormIntegerMat(BoundaryMap(rack, n-1)));
    a := BoundaryMap(rack, n);
#    a := TransposedMat(SmithNormalFormIntegerMat(BoundaryMap(rack, n)));

    # null columns of the matrix a, the (n-1)-th boundary map
    M := Size(rack)^n-Rank(a);

    # non-zero rows of the matrix b, the n-th boundary map
    m := Rank(b);

    t := Filtered(DiagonalOfMat(b), x->x>1);
    return [M-m, t];
end);

### This function computes the abelian rack homology
InstallGlobalFunction("RackHomology",
  function(rack, n)
    local a, b, t, m, M;

    if not n > 0 then 
      return fail;
    fi;

    a := BoundaryMap(rack, n-1);
    b := SmithNormalFormIntegerMat(BoundaryMap(rack, n));

    # null columns of the matrix a, the (n-1)-th boundary map
    M := Size(rack)^n-Rank(a);

    # non-zero rows of the matrix b, the n-th boundary map
    m := Rank(b);

    t := Filtered(DiagonalOfMat(b), x->x>1);
    return [M-m, t];
end);


### This function returns de n-th boundary map matrix:
### d : X^(n+1) --> X^n 
InstallGlobalFunction("BoundaryMap",
function(rack, n)
  local m, u, v, w, i, j;

  m := NullMat(Size(rack)^n, Size(rack)^(n+1));
  for i in [1..Size(rack)^(n+1)] do
    u := NumberToBasisVector(i, n+1, Size(rack));
    for j in [1..n] do
      v := ShallowCopy(u);
      Remove(v, j);
      w := Concatenation(u{[1..(j-1)]}, List([j+1..n+1], x->rack!.matrix[u[j]][u[x]]));
      m[BasisVectorToNumber(v, Size(rack))][i] := m[BasisVectorToNumber(v, Size(rack))][i] + (-1)^(j+1); 
      m[BasisVectorToNumber(w, Size(rack))][i] := m[BasisVectorToNumber(w, Size(rack))][i] + (-1)^j; 
    od;
  od;
  return m;
end);

### This function returns de n-th boundary map matrix for the quandle cohomology
InstallGlobalFunction("QuandleBoundaryMap",
function(rack, n)
  local m, u, v, w, i, j;
  m := NullMat(Size(rack)^n, Size(rack)^(n+1));
  for i in [1..Size(rack)^(n+1)] do
    u := NumberToBasisVector(i, n+1, Size(rack));
    if not CheckDegeneracy(u) = true then
      for j in [1..n] do
        v := ShallowCopy(u);
        Remove(v, j);
        w := Concatenation(u{[1..(j-1)]}, List([j+1..n+1], x->rack!.matrix[u[j]][u[x]]));
        if not CheckDegeneracy(v) = true then
          m[BasisVectorToNumber(v, Size(rack))][i] := m[BasisVectorToNumber(v, Size(rack))][i] + (-1)^(j+1); 
        fi;
        if not CheckDegeneracy(w) = true then
          m[BasisVectorToNumber(w, Size(rack))][i] := m[BasisVectorToNumber(w, Size(rack))][i] + (-1)^j; 
        fi;
      od;
    fi;
  od;
  return m;
end);


### This function computes the abelian quandle homology
InstallGlobalFunction("QuandleHomology",
  function(rack, n)
    local a, b, t, m, M;

    if not n > 0 then 
      return fail;
    fi;

    a := SmithNormalFormIntegerMat(QuandleBoundaryMap(rack, n-1));
    b := SmithNormalFormIntegerMat(QuandleBoundaryMap(rack, n));

    # null columns of the matrix a, the (n-1)-th boundary map
    M := Size(rack)^n-Rank(a);

    # non-zero rows of the matrix b, the n-th boundary map
    m := Rank(b);

    t := Filtered(DiagonalOfMat(b), x->x>1);
	return [M-m+Size(rack)*(Size(rack)-1)^(n-1)-(Size(rack))^n, t];
end);

### This function returns the list of 2-cocycles that generate tor(H^2(X))
InstallGlobalFunction("SecondCohomologyTorsionGenerators", function(rack)
  local a, b, r, t, m, M, i, x, d, q, z, pos, tmp, gens;#,n;

  a := BoundaryMap(rack, 1);
  b := SmithNormalFormIntegerMatTransforms(BoundaryMap(rack, 2));
 
  M := Size(rack)^2-Rank(a);

  # non-zero rows of the matrix b, the 2-th boundary map
  m := Rank(b.normal);
  
  r := TransposedMat(b.rowtrans);

  d := DiagonalOfMat(b.normal);
  t := Filtered([1..Size(d)], x->d[x]>1);

  gens := [];

  for x in t do
    q := NullMat(Size(rack),Size(rack));
    z := E(d[x]);
    tmp := r{[1..Size(r)]}[x];
    for i in [1..Size(tmp)] do
      pos := NumberToBasisVector(i, 2, Size(rack));
      q[pos[1]][pos[2]] := z^tmp[i];
    od;
    Add(gens, q);
  od;
  return gens;
end);

### This function returns de n-th degenerated boundary map matrix 
InstallGlobalFunction("DegeneratedBoundaryMap",
function(rack, n)
  local m, u, v, w, i, j;
  m := NullMat(Size(rack)^n, Size(rack)^(n+1));
  for i in [1..Size(rack)^(n+1)] do
    u := NumberToBasisVector(i, n+1, Size(rack));
    if CheckDegeneracy(u) = true then
      for j in [1..n] do
        v := ShallowCopy(u);
        Remove(v, j);
        w := Concatenation(u{[1..(j-1)]}, List([j+1..n+1], x->rack!.matrix[u[j]][u[x]]));
        m[BasisVectorToNumber(v, Size(rack))][i] := m[BasisVectorToNumber(v, Size(rack))][i] + (-1)^(j+1); 
        m[BasisVectorToNumber(w, Size(rack))][i] := m[BasisVectorToNumber(w, Size(rack))][i] + (-1)^j; 
      od;
    fi;
  od;
  return m;
end);

### This function computes the degenerated rack homology
InstallGlobalFunction("DegeneratedRackHomology",
  function(rack, n)
    local a, b, t, m, M;

    if not n > 0 then 
      return fail;
    fi;

    a := DegeneratedBoundaryMap(rack, n-1);
    b := SmithNormalFormIntegerMat(DegeneratedBoundaryMap(rack, n));

    # null columns of the matrix a, the (n-1)-th boundary map
    M := Size(rack)^(n-1)-Rank(a);

    # non-zero rows of the matrix b, the n-th boundary map
    m := Rank(b);

    t := Filtered(DiagonalOfMat(b), x->x>1);
    return [M-m, t];
end);

### This function checks if two cycles are homologous.
### EXAMPLE:
###   gap> IsHomologous(DihedralRack(3), [1,0,0,0,1,0,1,1,1], [1,1,1,1,1,1,1,1,1]);
###   true
InstallGlobalFunction("IsHomologous", function(rack, q1, q2)
  local a,b,n,s,r,i,j,t,d,col;

  n := LogInt(Size(q1), Size(rack));
  #Iterated(DimensionsMat(q1), \*), Size(rack));
  a := BoundaryMap(rack, n-1);
  b := SmithNormalFormIntegerMatTransforms(BoundaryMap(rack, n));

  s := b.normal;
  r := TransposedMat(b.rowtrans);

  t := [];
  for i in [1..Minimum(Size(s), Size(s[1]))] do
    if s[i][i] > 1 then
      Add(t, i);
    fi;
  od;

  for i in t do
    ### the i-th column of the matrix r
    col := List([1..Size(r)], x->r[x][i]);
    for j in [1..Size(col)] do
      if not (q1[j]-q2[j]) mod s[i][i] = 0 then
        return false;
      fi;
    od;
  od;
  return true;
end); 

### This function returns the multiplication of the 2-cocycles <q1> and <q2>
InstallGlobalFunction("Mult2Cocycles", function(q1, q2)
  local i, j, n, q;

  if DimensionsMat(q1) <> DimensionsMat(q2) then
    return fail;
  fi;
  n := Size(q1);
  q := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      q[i][j] := q1[i][j]*q2[i][j];
    od;
  od;
  return q;
end);

### This function computes the Betti numbers 


### This function computes the torsion and its generators
InstallGlobalFunction("TorsionGenerators", function(rack, n)
  local a, b, d, t, x, gens, q, s, r, c, m, i, tmp;
  a := BoundaryMap(rack, n-1);
  b := SmithNormalFormIntegerMatTransforms(BoundaryMap(rack, n));

  r := TransposedMat(b.rowtrans);
  s := b.normal;

  # non-zero rows of the matrix b, the n-th boundary map
  m := Rank(b.normal);

  d := DiagonalOfMat(b.normal);
  t := Filtered([1..Size(d)], x->d[x]>1);

  gens := [];
  for x in t do
    q := 0*List([1..Size(rack)^2]);
    tmp := r{[1..Size(r)]}[x];
    for i in [1..Size(tmp)] do
      q[i] := tmp[i] mod s[x][x];
    od;
    Add(gens, q);
  od;
  return gens;
end);

#InstallGlobalFunction(TorsionGenerators, 
#function(rack, n)
#  local a, b, r, t, m, M, i, x, d, q, z, pos, tmp, gens;
#
#  a := #SmithNormalFormIntegerMat(BoundaryMap(rack, n-1));
#  a := BoundaryMap(rack, n-1);
#  b := SmithNormalFormIntegerMatTransforms(BoundaryMap(rack, n));
# 
#  M := Size(rack)^n-Rank(a);
#
#  # non-zero rows of the matrix b, the n-th boundary map
#  m := Rank(b.normal);
#  
#  r := TransposedMat(b.rowtrans);
#
#  d := DiagonalOfMat(b.normal);
#  t := Filtered([1..Size(d)], x->d[x]>1);
#
#  gens := [];
#
#  for x in t do
#    q := [];
#    tmp := r{[1..Size(r)]}[x];
#    for i in [1..Size(tmp)] do
#      pos := NumberToBasisVector(i, n, Size(rack));
#      Add(q, tmp[i] mod d[x]);
#    od;
#    Add(gens, q);
#  od;
#  return gens;
#end);

### This function checks if the matrix is a rack 2-cocycle 
InstallGlobalFunction("Is2Cocycle", function(rack, q)
  local i, j, k;
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      for k in [1..Size(rack)] do
        if q[i][RackAction(rack, j, k)]*q[j][k] <> q[RackAction(rack, i, j)][RackAction(rack, i, k)]*q[i][k] then
          return false;
        fi;
      od;
    od;
  od;
  return true;
end);

### This function computes the Betti numbers of the rack homology
InstallGlobalFunction("Betti", function(rack, n)
  local a, b;
  a := BoundaryMap(rack, n-1);
  b := BoundaryMap(rack, n);
  return Size(rack)^n-Rank(a)-Rank(b);
end);

### This function computes the torsion subgroup of the homology
InstallGlobalFunction("Torsion", function(rack, n)
  local x, b;
  b := SmithNormalFormIntegerMat(BoundaryMap(rack, n));
  return Filtered(DiagonalOfMat(b), x->x>1);
end);

### This function checks if the list <c> is a cycle 
InstallGlobalFunction("IsCycle", function(rack, c) 
  local n;
  n := LogInt(Size(c), Size(rack));
  return IsZero(BoundaryMap(rack, n-1)*c);
end);

### This function checks if two 2-cocycles are cohomologous
### IMPORTANT: These are additive 2-cocycles! 
### EXAMPLES:
###   gap> r := Rack(SymmetricGroup(4),(1,2));;
###   gap> IsCohomologous2Cocycle(r, (1+FK2Cocycle(4))/2, NullMat(6,6));  
###   false
###   gap> IsCohomologous2Cocycle(r, (1+FK2Cocycle(3))/2, NullMat(3,3));
###   true
InstallGlobalFunction("IsCohomologous2Cocycle", function(rack, q1, q2)
  local c1, c2, i, j;
  c1 := [];
  c2 := [];
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      Add(c1, q1[i][j]); 
      Add(c2, q2[i][j]); 
    od;
  od;
  return IsHomologous(rack, c1, c2);
end);
