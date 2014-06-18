LoadPackage("rig");

### This function returns the value of the dynamical cocycle <cocycle> at <v>
### Every dynamical cocycle is a list [ v, value ], where v = [x, y, s, t] and value is a number in [1..N]
value := function(d, v)
  return First(d, x->x[1]=v)[2];
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

### This function returns true if the dynamical <cocycle> is constant, i.e. f_{x,y}(s,u)=f_{x,y}(t,u)
### for all x,y in X and s,t,u in S
is_constant := function(d)
  local x, y, s, t, u, rack, set;

  rack := Set(List(d, x->x[1][1]));
  set := Set(List(d, x->x[1][3]));

  for x in [1..Size(rack)] do
    for y in [1..Size(rack)] do
      for s in [1..Size(set)] do
        for t in [1..Size(set)] do
          for u in [1..Size(set)] do
            if value(d, [x, y, s, u]) <> value(d, [x, y, t, u]) then
              return false;
            fi;
          od;
        od;
      od;
    od;
  od;
  return true;
end;

### This function returns (if possible) the constant 2-cocycle <d> as a matrix 
### It returns fail if <d> is not a constant 2-cocycle
dynamical2constant := function(d)
  local rack, set, m, x, y, s;

  if not is_constant(d) then
    return fail;
  fi;

  rack := Set(List(d, x->x[1][1]));
  set := Set(List(d, x->x[1][3]));
  m := NullMat(Size(rack), Size(rack));

  for x in [1..Size(rack)] do
    for y in [1..Size(rack)] do
      for s in [1..Size(set)] do
        m[x][y] := PermList(List([1..Size(set)], t->value(d, [x,y,s,t])));
      od;
    od;
  od;
  return m;
end;

### This function returns true if the constant 2-cocycle <q> is abelian 
is_abelian2cocycle := function(q)
  return IsAbelian(Group(Flat(q)));
end;

Read("NonFaithful2.txt");
LogTo("clark.log");

cocycles := [];

for m in NonFaithful do
  r := Rack(TransposedMat(m));
  for k in Reversed(DivisorsInt(Size(r))) do

    stop := false;

    if k = 1 or k = Size(r) or k>35 then 
      continue;
    fi;

    for l in [1..NrSmallQuandles(k)] do
      s := SmallQuandle(k,l);
      d := dynamical(r, s);
      if d <> fail then
        Print("The quandle number ", Position(NonFaithful, m), " of size ", Size(r));
        q := dynamical2constant(d);
        if q <> fail then
          Add(cocycles, [Position(NonFaithful, m), k, l, q]);
          if is_abelian2cocycle(q) then
            Print(" is an abelian extension Q(", k, ",",l,")\n");
            stop := true;
            break;
          else
            Print(" is an non-abelian extension Q(", k, ",",l,")\n");
            stop := true;
            break;
          fi;
        else
            Print(" is a dynamical extension Q(", k, ",",l,")\n");
            break;
        fi;
      fi;
    od;

    if stop = true then
      break;
    fi;

  od;
od;
 
