InstallGlobalFunction("BoundaryMap2",
###  "Returns de 2nd boundary map matrix", 
###  [IsRack],
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
###  "Returns de 3th boundary map matrix", 
###  [IsRack],
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
###  "Returns de 4th boundary map matrix", 
###  [IsRack],
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
    a := TransposedMat(SmithNormalFormIntegerMat(BoundaryMap(rack, n)));

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
  local a, b, r, t, m, M, i, x, d, q, z, pos, tmp, gens,n;

  n := 2;

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
    q := NullMat(Size(rack),Size(rack));
    z := E(d[x]);
    tmp := r{[1..Size(r)]}[x];
    for i in [1..Size(tmp)] do
      pos := NumberToBasisVector(i, n, Size(rack));
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

### This function checks if two cycles are homologous
InstallGlobalFunction("AreHomologous", function(rack, q1, q2)
  local a,b,n,s,r,i,j,t,d,col;

  n := 2;
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

