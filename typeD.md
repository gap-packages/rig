The following function checks if a given rack is of type D.

```
checkD := function(rack)
  local n, i, j, s;
  n := Size(rack);

  for i in [1..n] do
    for j in [i+1..n] do
      s := CanonicalSubrack(rack, [i, j]);
      if IsDecomposable(s) then
        if RackAction(rack, i, RackAction(rack, j, RackAction(rack, i, j))) <> j then
          Print("r=", i, ", s=", j, ", ", Components(s), "\n");
          return true;
        fi;
      fi;
    od;
  od;
  return false;
end;
```