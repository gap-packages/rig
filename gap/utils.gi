### BasisVectorToNumber
### v=vector in [0...n-1]
### n=rank
InstallGlobalFunction(BasisVectorToNumber,
[IsList, IsInt],
function(v, rank)
  local s, i;
  s := 0;
  for i in [1..Size(v)] do
    if not v[i] in [1..rank] then
      return fail;
    fi;
    s := s+((v[i]-1)*rank^(Size(v)-i));
  od;
  return s+1;
end);

### i = position of the basis vector
### n = vector in degree n
### rank = rank of the nichols algebra
### the letters are 1,2,...,rank
InstallGlobalFunction(NumberToBasisVector,
[IsInt, IsInt, IsInt],
function(i, n, rank)
  local v, x, y;
  v := [];
  x := i-1;

  while x>=rank do
    y := x mod rank;
    Add(v, y);
    x := (x-y)/rank;
  od;
  Add(v, x);
  for i in [Size(v)..n-1] do
    Add(v, 0);
  od;
  return Reversed(v)+1;
end);

InstallGlobalFunction(CheckDegeneracy,
[IsList],
function(v)
  local i;
  for i in [1..Size(v)-1] do
    if v[i]=v[i+1] then
      return true;
    fi;
  od;
  return false;
end);
