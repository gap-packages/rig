### Construct the list of all indecomposable quandles of order n up to isomorphism
LoadPackage("rig");

n := 12;

q := [];
t := AllTransitiveGroups(NrMovedPoints, n, IsAbelian, false);

for x in t do
  inn := x;
  if inn = SymmetricGroup(n) and not n = 3 then
    continue;
  fi;

  if inn = AlternatingGroup(n) and not n = 4 then
    continue;
  fi;

  for y in ConjugacyClassesSubgroups(x) do 
    stb := Representative(y); 
    if IsAbelian(inn) = false and IsTransitive(inn) = true and IsSubgroup(inn, stb) = true and Size(inn)/Size(stb) = n then

      center := Center(stb);
      rt := RightTransversal(inn, stb);

      if not IsTrivial(center) then 
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
            for s in q do
              if not IsomorphismRacks(r, s) = fail then
                new := false;
                break;
              fi;
            od;

            if new = true then
              Print("Inn(X) has order ", Size(inn), "\n");
              Print("H has order ", Order(stb), "\n");
              Print("Center(H) has order ", Size(center), "\n");
              Print("h=", h, "\n");
              Display(m);
              Print("--\n");
              Add(q, r);
            fi;

          fi;
        od;
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
