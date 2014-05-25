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

### This function replaces <old> by <new> in <list>
InstallGlobalFunction("ReplacedList", function(list, old, new)
  local j, r;
  r := [];
  for j in list do
    if j = old then
      Add(r, new);
    else
      Add(r, j);
    fi;
  od;
  return r;
end);


### This function computes the fundamental quandle of a knot given by a planar diagram <pd>
InstallGlobalFunction("FundamentalQuandle", function(pd)
  local j, c, d, s, diagram, fq, f;

  s := Signs(pd);
  fq := [];

  diagram := ShallowCopy(pd);

  for c in diagram do
    for j in [1..Size(diagram)] do
      diagram[j] := ReplacedList(diagram[j], c[2], c[4]);
    od;
  od;

  ### This is to normalize the arcs
  f := Set(Flat(diagram));

  for j in [1..Size(diagram)] do
    if s[j] > 0 then
      Add(fq, [Position(f, diagram[j][4]), Position(f, diagram[j][1]), Position(f, diagram[j][3]), 1]);
    else
      Add(fq, [Position(f, diagram[j][4]), Position(f, diagram[j][3]), Position(f, diagram[j][1]), -1]);
    fi;
  od;

  return fq;
end);

### This function returns the signs of the crossings of a planar diagram <pd>
### CHECK!
InstallGlobalFunction("Signs", function(pd)
  local c, s, max;

  s := [];
  max := Maximum(Flat(pd));

  for c in pd do
    if c[2] = max and c[4] = 1 then 
      Add(s, 1);
      continue;
    elif c[2] = max and c[4] = max-1 then
      Add(s, -1);
      continue;
    elif c[4] = max and c[2] = 1 then
      Add(s, -1);
      continue;
    elif c[4] = max and c[2] = max-1 then
      Add(s, 1);
      continue;
    elif c[4]>c[2] then
      Add(s, 1);
      continue;
    elif c[4]<c[2] then
      Add(s,-1);
      continue;
    else
      Print("Nothing?\n");
      return fail;
    fi;
  od;
  return s;
end);

### This function computes the mirror image of the planar diagram <pd>
### CHECK!
InstallGlobalFunction("Mirror", function(pd)
  local c, k, s, new;

  new := [];
  s := Signs(pd);

  for k in [1..Size(pd)] do 
    c := pd[k];
    if s[k] > 0 then
      Add(new, [c[2],c[3],c[4],c[1]]);
    else
      Add(new, [c[4],c[1],c[2],c[3]]);
    fi;
  od;
  return new;
end);

### This function returns the Alexander matrix of the <knot> where the coloring
### is given by element of the <field> and <t> is an invertible element 
InstallGlobalFunction("AlexanderMatrix", function(fq, field, t)
  local m, j;
  m := NullMat(Size(fq), Size(fq), field);
  for j in [1..Size(fq)] do
    m[j][fq[j][1]] := One(field)-t;
    m[j][fq[j][2]] := t;
    m[j][fq[j][3]] := -One(field);
  od;
  return m;
end);

### This function return the number of Alexander colorings
InstallGlobalFunction("NrAlexanderColorings", function(fq, field, t)
  return Size(field)^(Size(fq)-Rank(AlexanderMatrix(fq, field, t)));
end);


