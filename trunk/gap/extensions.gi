### This function computes the abelian extension of <rack> by the 
### <group> 2-cocycle defined by the function. The action of the
### extension is defined as: (x,a)>(y,b)=(x>y, bf(x,y))
### EXAMPLE:
###   gap> gap> f := [[(), (1,2)], [(1,2),()]];
###   gap> AbelianExtension(TrivialRack(2), Group((1,2)), f);
InstallGlobalFunction("AbelianExtension", function(rack, group, f)
  local m, a, b, c, u, v, x, y;
  m := NullMat(Size(group)*Size(rack), Size(group)*Size(rack));
  c := Cartesian(group, [1..Size(rack)]);
  for u in c do
    for v in c do
      a := u[1];
      b := v[1];
      x := u[2];
      y := v[2];
      m[Position(c, u)][Position(c, v)] := Position(c, [b*f[x][y], RackAction(rack, x, y)]);
    od;
  od;
  return Rack(m);
end);


