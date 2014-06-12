LoadPackage("rig");

fiber := function(rack, quotient, p)
  local k, map, list;
  
  map := IsQuotient(rack, quotient);
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
  q := [];
  
  tmp := [];
  
  for x in [1..Size(quotient)] do
    for y in [1..Size(quotient)] do
      for s in [1..Size(g[1])] do
        for t in [1..Size(g[1])] do
          tmp := Position(g[InverseRackAction(quotient, x, y)], RackAction(rack, g[x][s], g[y][t]));
          Add(q, [[x, y, s, t], tmp]);
        od;
      od;
    od;
  od;
  return q;
end;

extension := function(rack, q)
  local x, y, s, t, m, set;

  set := Set(List(q, x->

  local m, a, b, c, u, v, x, y;
  m := NullMat(Size(set)*Size(rack), Size(group)*Size(set));
  c := Cartesian(group, [1..Size(rack)]);
  for u in c do
    for v in c do
      a := u[1];
      b := v[1];
      x := u[2];
      y := v[2];
      m[Position(c, u)][Position(c, v)] := Position(c, [RackAction(rack, x, y)], ...)
    od;
  od;
  return Rack(m);
end);

end;
  



