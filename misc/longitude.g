LoadPackage("rig");

test := [[4,1,2,1],[5,2,3,1],[2,3,4,1],[1,4,5,1],[3,5,1,1]];

### This function returns the longitude of a knot given by <fq>
### The expression for the longitude is taken from [BZ, Remark 3.13]
longitude := function(fq, start)
  local k, c, s, l, path;

  l := [];
  k := 1;
  s := start;

  path := [];

  repeat  
    if fq[k][4]>0 and fq[k][2] = s then 
      Add(path, fq[k]);
      s := fq[k][3];
    elif fq[k][4]<0 and fq[k][3] = s then
      Add(path, fq[k]);
      s := fq[k][2];
    fi;
    k := k+1; 
    if k>Size(fq) then
      k := 1;
    fi;
  until Size(path)>=Size(fq);


  for c in path do
    Add(l, [c[1], -c[4]]);
  od;
  Add(l, [start, -Sum(List(l, x->x[2]))]);

  return l;
end;
