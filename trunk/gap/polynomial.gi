_actionL := function(rack, m, i, j)
  if m > 1 then
    return _actionL(rack, m-1, i, rack!.matrix[i][j]);
  else
    return rack!.matrix[i][j];
  fi;
end;

_actionR := function(rack, m, j, i)
  if m > 1 then
    return _actionR(rack, m-1, j, rack!.matrix[i][j]);
  else
    return rack!.matrix[i][j];
  fi;
end;

__rr := function(rack, n, i)
  return Size(Filtered([1..Size(rack)], x->_actionL(rack, n, i, x)=x));
end;

__ss := function(rack, n, i)
  return Size(Filtered([1..Size(rack)], x->_actionR(rack, n, i, x)=x));
end;

__cc := function(rack, n, i)
  return Size(Filtered([1..Size(rack)], x->_actionL(rack, n, x, i)=i));
end;

__dd := function(rack, n, i)
  return Size(Filtered([1..Size(rack)], x->_actionR(rack, n, x, i)=i));
end;

c := function(rack, i, x)
  local z, y, k, j;
  k := 0;
  for y in [1..Size(rack)] do
    j := 0;
    z := x;
    while (j < i) do
      j := j+1;
      z := rack[y][z];
    od;
    if x=z then
      k := k+1;
    fi;
  od;
  return k;
end;

r := function(rack, i, x)
  local y, k, z, j;
  k := 0;
  for y in [1..Size(rack)] do
    j := 0;
    z := y;
    while (j < i) do
      j := j+1;
      z := rack[x][z];
    od;
    if y=z then
      k := k+1;
    fi;
  od;
  return k;
end;

### This function computes the weighted Nelson polynomial invariant
### Data:
### Indeterminates: x := (a,b,c,d)
### Weight: w = (w1,w2,w3,w4)
### Example (computes the classic Nelson polynomial invariant): 
###   gap> x := Indeterminate(Rationals, "x");;
###   gap> y := Indeterminate(Rationals, "y");;
###   gap> PolynomialInvariant(DihedralRack(3), x, y, 1, 1, [1,1,1,1]);
###   3*x*y
PolynomialInvariant := function(rack, a, b, c, d, w)
  local r, p, i;
  p := 0;
  for i in [1..Size(rack)] do
    p := p + a^__rr(rack, w[1], i)*b^__cc(rack, w[2], i)*c^__ss(rack, w[3], i)*d^__dd(rack, w[4], i);
  od;
  return p; 
end;

NelsonInvariant := function(rack, x, y)
  return PolynomialInvariant(rack, x, y, 1, 1, [1,1,1,1]);
end;
#  local i,p;
#  p := 0;
#  for i in [1..Size(rack)] do
#    p := p + (x^r(rack,1,i)*y^c(rack,1,i));
#  od;
#  return p;
#end;


