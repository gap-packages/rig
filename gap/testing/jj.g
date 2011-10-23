LoadPackage("rig");
LogTo("jj.log");

IdQuandle := function(rack)
  local i;
  for i in [1..NrSmallQuandles(Size(rack))] do
    if not IsomorphismRacks(rack, SmallQuandle(Size(rack), i)) = fail then
      return [Size(rack), i];
    fi;
  od;
  return fail;
end;

for n in [1..35] do
  for i in [1..NrSmallQuandles(n)] do
    r := SmallQuandle(n, i);
    Display(IdQuandle(r));
  od;
od;

quit;
 


for n in [1..35] do
  for i in [1..NrSmallQuandles(n)] do
    r := SmallQuandle(n, i);
    inn := InnerGroup(r);
    Print("n=", n, ", i=", i, ", ");
    Print(AllBlocks(inn), "\n");
    for b in AllBlocks(inn) do
      s := CanonicalSubrack(r, b);
      if Size(s) = Size(b) then
        Print("!");
      fi;
    od;

    #Print("n=", n, ", i=", i, ", ");
    #if IsSimple(r) then
    #  Print("simple, ");
    #else
    #  Print("not simple, ");
    #fi;
    #if IsPrimitive(inn) then
    #  Print("primitive, ");
    #fi;
    #Print("degree=", Transitivity(inn, [1..Size(r)]), "\n");
  od;
od;
