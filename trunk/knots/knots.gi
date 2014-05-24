### This function returns the coloring matrix of the <knot> 
### <knot> is the fundamental quandle of a knot
### At each crossing one has the equations 2a-b-c=0, where a is the over-arc and b and c are the under-arcs
InstallGlobalFunction("ColoringMatrix", function(fq)
  local j, m;
  m := NullMat(Size(fq), Size(fq));
  for j in [1..Size(fq)] do
    m[j][fq[j][1]] := 2;
    m[j][fq[j][2]] := -1;
    m[j][fq[j][3]] := -1;
  od;
  return m;
end);

### This function returns the number of <p> coloring of the fundamental
### quandle <fq> of the knot
InstallGlobalFunction("NrFoxColorings", function(fd, p)
  local m;
  m := ColoringMatrix(fd);
  return p^(Size(fd)-Rank(m*Z(p)^0));
end);

### this function computes the <quandle>-colorings of the fundamental quandle <fq> of a knot 
InstallGlobalFunction("QuandleColorings", function(fq, quandle)
  local e, i, crossing, p, set, c;

  e := [1..Size(quandle)];
  i := 0;

  c := [];
  crossing := true;

  for set in IteratorOfTuples(e, Maximum(Flat(fq))) do
    if ForAny(fq, c->CheckQuandleEquation(c, set, quandle)=false) then
      continue;
    else
      Add(c, set);
    fi;
  od;
  return c;
end);

### This function returns the number of <quandle>-colorings the fundamental
### quandle <fq> of a knot
InstallGlobalFunction("NrQuandleColorings", function(fq, quandle)
  return Size(QuandleColorings(fq, quandle));
end);

InstallGlobalFunction("CheckQuandleEquation", function(equation, set, quandle)
  if RackAction(quandle, set[equation[1]], set[equation[2]]) = set[equation[3]] then
    return true;
  else
    return false;
  fi;
end);

### This function returns the Bolztmann weight at the crossing <c>
InstallGlobalFunction("BoltzmannWeight", function(c, coloring, quandle, group, q)
  if c[4] > 0 then
    return q[coloring[c[1]]][coloring[c[2]]];
  else
    return q[coloring[c[1]]][coloring[c[2]]]^(-1);
  fi;
end);

### This function computes the cocycle invariant of <knot> 
### given by the <quandle> 2-cocycle <q> with coefficients in <group>
InstallGlobalFunction("2CocycleInvariant", function(fq, quandle, group, q)
  local e, i, crossing, p, coloring, sum, product, c, gring;

  e := [1..Size(quandle)];
  i := 0;
 
  gring := GroupRing(Integers, group);
  sum := Zero(gring);

  crossing := true;

  for coloring in IteratorOfTuples(e, Size(fq)) do 
    if ForAny(fq, c->CheckQuandleEquation(c, coloring, quandle)=false) then
      continue;
    else
      i := i+1;
    #  Print("Coloring: ", coloring, "\n");

      product := One(gring);
      for c in fq do
#       Print("a=", coloring[c[1]], ", b=", coloring[c[2]], ", sign=", AbsInt(c[4])/c[4], ", ");
        product := product*BoltzmannWeight(c, coloring, quandle, group, q);
      od;
      sum := sum + product;
    fi;
  od;
  return sum;
end);


