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
  local f, g, q, tmp, x, y, s, t, k, p; 

  ### The map g_i is the bijection between the fiber of i and a set S
  ### If g = [[a,b,c...],[d,e,f,...],...] 
  ### it means that a,b,c... go to 1, and d,e,f... go to 2, and...
  ### The map f is the inverse of g
  f := IsQuotient(rack, quotient);
  g := [];

  for p in [1..Size(quotient)] do
    tmp := [];
    for k in [1..Size(f)] do
      if f[k] = p then
        Add(tmp, k);
      fi;
    od;
    Add(g, tmp);
  od;
  Display(g);
  Display(f);

  if fail in g then
    return fail;
  fi;
  
  q := [];
  tmp := [];
 
  ### Suppose that f_i is the inverse of g_i for all i. Then 
  ### the dynamical cocycle is given by g_{i>j}(f_i(s)>f_j(t))
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
### WRONG!
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
        m[x][y] := Inverse(PermList(List([1..Size(set)], t->value(d, [x,y,s,t]))));
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

quit;
LogTo("clark.log");

cocycles := [];

for m in NonFaithful{[16..Size(NonFaithful)]} do
  r := Rack(TransposedMat(m));

  stop := false;

  k := Size(Set(Permutations(r)));
  if k>35 then
    Print("The quotient is too big!\n");
    continue;
  fi;

  for l in [1..NrSmallQuandles(k)] do
    s := SmallQuandle(k,l);
    d := dynamical(r, s);
    if d <> fail then
      Print("The quandle number ", Position(NonFaithful, m), " of size ", Size(r));
      q := dynamical2constant(d);
      if q <> fail then
        Add(cocycles, [Position(NonFaithful, m), s, q]);
        if is_abelian2cocycle(q) then
          Print(" is an abelian extension of Q(", k, ",", l, ")\n");
          stop := true;
          break;
        else
          Print(" is an non-abelian extension of Q(", k, ",", l, ")\n");
          stop := true;
          break;
        fi;
      else
          Print(" is a dynamical extension of Q(", k, ",", l, ")\n");
          break;
      fi;
    fi;
  od;

#  if stop = true then
#    break;
#  fi;

od;
 
