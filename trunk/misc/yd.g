LoadPackage("rig");

### fabricar los generadores!!!!!!

yd := function(rack, q)
  local i, j, n, m, wr, yd, iso;
  n := Size(rack);
  m := 1;
  for i in [1..n] do
    for j in [1..n] do
      m := Lcm(m, Order(q[i][j]));
    od;
  od;
  wr := WreathProduct(CyclicGroup(m), SymmetricGroup(n));
  yd := YetterDrinfeldGroup(rack, q);
  iso := IsomorphicSubgroups(wr, yd);
  return iso;
end;

r := DihedralRack(8);;
q := NullMat(8,8)+E(3);;

y := YetterDrinfeldGroup(r,q);
# necesito calcular el size de y o no anda
w := WreathProduct(CyclicGroup(IsPermGroup, 8),SymmetricGroup(3));

