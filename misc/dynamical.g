LoadPackage("rig");

### This function returns the value of the dynamical cocycle <cocycle> at <v>
### Every dynamical cocycle is a list [ v, value ], where v = [x, y, s, t] and value is a number in [1..N]
value := function(cocycle, v)
  return First(cocycle, x->x[1]=v)[2];
end;

### This function returns the fiber of p with respect to the epimorphism from <rack> onto <quotient>
fiber := function(rack, quotient, p)
  local k, map, list;
  
  map := IsQuotient(rack, quotient);
  if map = false then
    return fail;
  fi;
  list := [];

  for k in [1..Size(map)] do
    if map[k] = p then
      Add(list, k);
    fi;
  od;
  return list;
end;

### This function returns the dynamical 2-cocycle that allows us to construct
### the extension <rack> of <quotient>
dynamical := function(rack, quotient)
  local g, q, tmp, x, y, s, t; 
  g := List([1..Size(quotient)], x->fiber(rack, quotient, x));

  if fail in g then
    return fail;
  fi;
  
  q := [];
  tmp := [];
  
  for x in [1..Size(quotient)] do
    for y in [1..Size(quotient)] do
      for s in [1..Size(g[1])] do
        for t in [1..Size(g[1])] do
          tmp := Position(g[RackAction(quotient, x, y)], RackAction(rack, g[x][s], g[y][t]));
          Add(q, [[x, y, s, t], tmp]);
        od;
      od;
    od;
  od;
  return q;
end;

### This function returns the extension of <rack> constructed with the dynamical cocycle <q>
### (x,s)>(y,t)=(x>y,q_{x,y}(s,t)) for x,y in <rack> and s,t in the image of <q>
extension := function(rack, q)
  local m, a, b, c, u, v, x, y, set;

  set := [1..Maximum(List(q, x->x[2]))];

  m := NullMat(Size(set)*Size(rack), Size(set)*Size(set));
  c := Cartesian([1..Size(rack)], set);
  for u in c do
    for v in c do
      a := u[2];
      b := v[2];
      x := u[1];
      y := v[1];
      m[Position(c, u)][Position(c, v)] := Position(c, [RackAction(rack, x, y), value(q, [x, y, a, b])]);
    od;
  od;
  return Rack(m);
end;
  



