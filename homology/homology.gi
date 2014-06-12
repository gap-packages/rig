TWOCOCYCLES := [];

### Quandle [ 1, 1 ]
TWOCOCYCLES[1] := rec( implemented := 1, quandle := [] );
TWOCOCYCLES[1].implemented := 1;
TWOCOCYCLES[1].quandle[1] := rec( 
  factors := [ ], 
  group := Group( [ () ] ), 
  q := [ [ [ () ] ] ]
);

### Quandle [ 2, 1 ]
TWOCOCYCLES[2] := rec( implemented := 0, quandle := [] );

### Quandle [ 3, 1 ]
TWOCOCYCLES[3] := rec( implemented := 1, quandle := [] );
TWOCOCYCLES[3].quandle[1] := rec( implemented := 1 , 
  factors := [], 
  group := Group( [ () ] ), 
  q := [ [ [ (), (), () ], [ (), (), () ], [ (), (), () ] ] ]
);

## size 4
TWOCOCYCLES[4] := rec( implemented := 1, size := 4, quandle := [ ] );
TWOCOCYCLES[4].quandle[1] := rec(
  factors := [ 2 ], generators := [ [ 0, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0 ] ]
);

## size 6
TWOCOCYCLES[6] := rec( implemented := 2, size := 6, quandle := [ ] );
TWOCOCYCLES[6].quandle[1] := rec(
  factors := [ 2 ], generators := [ [ 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0 ] ]
);

TWOCOCYCLES[6].quandle[2] := rec(
  factors := [ 4 ], generators := [ [ 0, 1, 2, 2, 1, 3, 1, 0, 2, 0, 3, 3, 2, 1, 0, 1, 2, 3, 3, 2, 1, 0, 0, 3, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0 ] ]
);

## size 8
TWOCOCYCLES[8] := rec( implemented := 3, size := 8, quandle := [ ] );
TWOCOCYCLES[8].quandle[1] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[8].quandle[2] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[8].quandle[3] := rec(
  factors := [ ], generators := [  ]
);

## size 9
TWOCOCYCLES[9] := rec( implemented := 8, size := 9, quandle := [ ] );
TWOCOCYCLES[9].quandle[1] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[9].quandle[2] := rec(
  factors := [ 3 ], generators := [ [ 0, 2, 1, 2, 2, 0, 1, 0, 1, 1, 0, 2, 1, 2, 1, 2, 1, 2, 2, 1, 0, 1, 0, 0, 0, 2, 0, 2, 1, 1, 0, 1, 2, 
      1, 2, 2, 2, 2, 0, 2, 0, 1, 0, 1, 1, 0, 1, 0, 1, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]
);

TWOCOCYCLES[9].quandle[3] := rec(
  factors := [ 3 ], generators := [ [ 0, 2, 1, 2, 1, 0, 1, 1, 1, 2, 0, 1, 1, 2, 1, 0, 1, 1, 1, 0, 0, 2, 2, 2, 1, 1, 0, 2, 1, 1, 0, 2, 1, 
      1, 0, 1, 1, 2, 0, 2, 0, 1, 1, 1, 1, 2, 2, 2, 0, 1, 0, 1, 1, 0, 0, 2, 1, 1, 2, 1, 0, 2, 0, 2, 1, 1, 2, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]
);

TWOCOCYCLES[9].quandle[4] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[9].quandle[5] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[9].quandle[6] := rec(
  factors := [ 3 ], generators := [ [ 0, 2, 1, 2, 1, 2, 1, 0, 0, 1, 0, 2, 1, 2, 2, 1, 0, 0, 2, 1, 0, 2, 2, 1, 1, 0, 0, 2, 1, 2, 0, 1, 2, 
      0, 1, 0, 1, 2, 2, 2, 0, 1, 0, 1, 0, 2, 2, 1, 1, 2, 0, 0, 1, 0, 1, 1, 1, 2, 2, 2, 0, 2, 1, 2, 2, 2, 1, 1, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ]
);

TWOCOCYCLES[9].quandle[7] := rec(
  factors := [ ], generators := [  ]
);

TWOCOCYCLES[9].quandle[8] := rec(
  factors := [ ], generators := [  ]
);


### This function returns the generators of the 2nd quandle homology
### group of SmallQuandle(size, number)
InstallGlobalFunction("2ndQuandleHomology", function(size, number)
  local known, implemented, dir, filename;

  # If n is prime then the 2nd homology is trivial
  if IsPrime(size) then
    return rec( factors := [ ], generators := [ List([1..size^2], x->0) ]);
  fi;

  # there are no indecomposable quandles of size 2p (p prime)
  if size mod 2 = 0 and IsPrime(size/2) and size > 10 then
    return fail;
  fi;

  known := IsBound(TWOCOCYCLES[size]);
  if not known then
    dir := DirectoriesPackageLibrary("rig", "homology")[1];
    filename := Filename(dir, Concatenation("size", String(size), ".g"));
    if IsReadableFile(filename) then
      Read(filename);
    else
      Error("Not implemented!");
    fi;
  fi;
  if number <= TWOCOCYCLES[size].implemented then
    return TWOCOCYCLES[size].quandle[number];
  else
    Error("there are just ", NrSmallQuandles(size), " indecomposable quandles of size ", size);
  fi;
end);

### This function returns the generators of the generators of the 2nd quandle homology group of SmallQuandle(n, i)
### The database was computed with the function TorsionGenerators
InstallGlobalFunction("2ndQuandleCohomology", function(size, number)
  local k, l, v, q, hom, gens;

  # If n is prime then the 2nd homology is trivial
  if IsPrime(size) then
    return rec( factors := [ ], generators := [ List([1..size^2], x->0) ]);
  fi;

  hom := 2ndQuandleHomologyGenerators(size, number);
  gens := [];

  for k in [1..Size(hom.generators)] do
    q := NullMat(size, size);
    for l in [1..Size(hom.generators[k])] do
      v := NumberToBasisVector(l, 2, size);
      q[v[1]][v[2]] := AbelianGroup(IsPermGroup, [hom.factors[k]]).1^hom.generators[k][l];
      #q[v[1]][v[2]] := GeneratorsOfGroup(AbelianGroup(IsPermGroup, hom.factors))[k]^hom.generators[k][l];
    od;
    Add(gens, q);
  od;
  return rec( desc := Concatenation("second quandle cohomology group of SmallQuandle(", String(size), ",", String(number), ")"), 
              factors := hom.factors, generators := gens);
end);


