### Construct the list of all indecomposable quandles of order n up to isomorphism
LoadPackage("rig");
LogTo("log");

### Global variables
n := 25;
q := [];
count := 0;
verbose := true;
N := NrTransitiveGroups(n); 

# 0 don't check isomorphism
# 1 check isomorphism by direct computation
# 2 check isomorphism but first check the polynomial invariant
check_iso := 2; 

for t in [1..N] do
  if verbose then
    count := count+1;
    Print("Checking: ", count, "/", N, "\n");
  fi;

  inn := TransitiveGroup(n, t);

  if inn = SymmetricGroup(n) and not n = 3 then
    continue;
  fi;

  if inn = AlternatingGroup(n) and not n = 4 then
    continue;
  fi;

  if IsAbelian(inn) = true then 
    continue;
  fi;

  stb := Stabilizer(inn, 1);
  
  center := Center(stb);
  if IsTrivial(center) = true then 
    continue;
  fi;

  rt := RightTransversal(inn, stb);

  for h in center do
    if h = () then
      continue;
    fi;

    g := [];
    e := [];
    
    for k in rt do
      Add(g, CanonicalRightCosetElement(stb, k));
      Add(e, Inverse(CanonicalRightCosetElement(stb, k))*h*CanonicalRightCosetElement(stb, k));
    od;

    if not Size(Group(e)) = Size(inn) then
      continue;
    fi;
       
    m := NullMat(n,n);
    for i in [1..n] do
      for j in [1..n] do
        m[j][i] := PositionCanonical(rt, g[i]*Inverse(g[j])*h*g[j]);
      od;
    od;
    
    r := Rack(m);
    if not r in q then
      new := true;
      if check_iso = 2 then  
        x := Indeterminate(Rationals, "x");
        y := Indeterminate(Rationals, "y");
        u := Indeterminate(Rationals, "u");
        v := Indeterminate(Rationals, "v");
        for s in q do 
          if PolynomialInvariant(r,x,y,u,v,[1,2,3,4]) = PolynomialInvariant(s,x,y,u,v,[1,2,3,4]) then
            if not IsomorphismRacks(r,s) = fail then
              new := false;
              break;
            fi;
          fi;
        od; 
      elif check_iso = 1 then
        for s in q do
          if not IsomorphismRacks(r, s) = fail then
            new := false;
            break;
          fi;
        od;
      fi;

      if new = true then
        if verbose = true then
          Print("Inn(X) has order ", Size(inn), ", degree=", n, ", \#", t, "\n");
          Print("H has order ", Order(stb), "\n");
          Print("Center(H) has order ", Size(center), "\n");
          Print("h=", h, "\n");
          Display(m);
          Print("--\n");
        fi;
        Add(q, r);
      fi;
    fi;
  od;
od;

i := 1;
Print("## size ", n, "\n");
Print("SMALL_I_QUANDLES[", n, "] := rec( total := -1, implemented := ", Size(q), ", size := ", n, ", rack := [ ] );\n");
for x in q do
  Print("SMALL_I_QUANDLES[", n, "].implemented := ", i, ";\n");
  Print("SMALL_I_QUANDLES[", n, "].rack[", i, "] := rec( size := ", n, ", matrix :=\n");
  Print(x.matrix, ");\n");
  i := i+1;
od;
