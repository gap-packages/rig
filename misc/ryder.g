LoadPackage("rig");

# Ryder 5.1
rack := function(group, g)
  local x,y,m,i,j,elems;
  
  elems := Elements(group);
  m := NullMat(Size(elems), Size(elems));

  for x in elems do
    for y in elems do
      i := Position(elems, x);
      j := Position(elems, y);
      m[i][j] := Position(elems, y*Inverse(x)*g*x);
    od;
  od;
  return Rack(m);
end;

