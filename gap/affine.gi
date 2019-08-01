################################################
### Functions used to work with affine racks ###
### by A. Lochmann                           ###
################################################

InstallGlobalFunction("ContainsCommutingElements", function(rack)
  local j, k;
  for j in [1..Size(rack)] do
    for k in [1..Size(rack)] do
      if j <> k then
        if rack.matrix[j][k] = k then
          return true;
        fi;
      fi;
    od;
  od;
  return false;
end);

InstallGlobalFunction("AffinisationMatrix", function(rack, neutralelement)
  local i, j, m;
  m := NullMat(Size(rack), Size(rack));
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      m[rack.matrix[i][neutralelement]][rack.matrix[neutralelement][j]] := rack.matrix[i][j];
    od;
  od;
  return m;
end);

InstallGlobalFunction("ContainsZero", function(matrix)
  local i, j;
  for i in [1..Size(matrix)] do
    for j in [1..Size(matrix[i])] do
      if matrix[i][j] = 0 then
        return true;
      fi;
    od;
  od;
  return false;
end);

InstallGlobalFunction("AffinisationSubtract", function(matrix, plus, minus)
  local j;
  for j in [1..Size(matrix[minus])] do
    if matrix[minus][j] = plus then
      return j;
    fi;
  od;
  return fail;
end);

### WARNING: It works only for indecomposable quandles
InstallGlobalFunction("IsAffineIndecomposableQuandle", function(rack)
  local a, m, p, j, k, x;
  if not IsIndecomposable(rack) then
    Error("the quandle is decomposable...");
    return fail;
  fi;
  if ContainsCommutingElements(rack) then
    Print("# It contains commuting elements\n");
    return false;
  fi;
  m := AffinisationMatrix(rack, 1);
  if ContainsZero(m) then
    return false;
    #return [false, "Affinisation incomplete."];
  fi;
  a := Affinise(rack, 1);
  if not IsGroup(a) then
    return false;
    #return [false, "Affinisation is not a group."];
  fi;
  if not IsAbelian(a) then
    return false;
    #return [false, "Affinisation is not abelian."];
  fi;
  p := rack.matrix[1];
  for j in [1..Size(rack)] do
    for k in [1..Size(rack)] do
      x := AffinisationSubtract(m, m[j][p[k]], p[j]);
      if x <> rack.matrix[j][k] then
        return false;
        #return [false, "Action is not realised."];
      fi;
    od;
  od;
  return true;
  #return [true, StructureDescription(a)];
end);


