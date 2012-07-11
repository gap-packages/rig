InstallGlobalFunction("DeriveNP", function(data, u, t)
  local result, i, j, monomial, coefficient, first, last;
  #Print("Try to derive ", u, " with respect to ", t, "\n");
  result := [[],[]]; # zero-polynomial
  for j in [1..Size(u[2])] do
    monomial := u[1][j];
    coefficient := u[2][j];
    if Size(monomial) = 0 then
      # Monomial is 1, derivation always vanishes. Don't do anything.
    else
      first := monomial[1];
      last := List([1..(Size(monomial)-1)], i -> monomial[i+1]);
      if Size(last) > 0 then
          result := AddNP(result, MulNP([[[first]],[1]], DeriveNP(data, [[last],[coefficient]], t)), 1, 1);
      fi;
      if first = t then
          result := AddNP(result, ActNP(data, [[last],[coefficient]], t), 1, 1);
      fi;
    fi;
  od;
  result := CleanNP(result);
  return result;
end);

InstallGlobalFunction("DeriveMultipleNP", function(data, u, sequence)
  local result, t;
  result := StructuralCopy(u);
  for t in Reversed(sequence) do
    result := DeriveNP(data, result, t);
  od;
  return result;
end);

# Skew-op-derive the NP-polynomial u with respect to t in NicholsDatum data
InstallGlobalFunction("DeriveOpNP", function(data, u, t)
  local result, i, j, monomial, coefficient, first, last, new_t, factor;
  #Print("Try to derive ", u, " with respect to ", t, "\n");
  result := [[],[]]; # zero-polynomial
  for j in [1..Size(u[2])] do
    monomial := u[1][j];
    coefficient := u[2][j];
    if Size(monomial) = 0 then
      # Monomial is 1, derivation always vanishes. Don't do anything.
    else
      first := monomial[1];
      last := List([1..(Size(monomial)-1)], i -> monomial[i+1]);
      if Size(last) > 0 then
          factor := 1/(data.q[first][t]);
          new_t := ListPerm((PermList(data.rack.matrix[first]))^(-1))[t];
          result := AddNP(result, MulNP([[[first]],[factor]], DeriveOpNP(data, [[last],[coefficient]], new_t)), 1, 1);
      fi;
      if first = t then
          result := AddNP(result, [[last],[coefficient]], 1, 1);
      fi;
    fi;
  od;
  result := CleanNP(result);
  #Print(" ... return ", result, "\n");
  return result;
end);

InstallGlobalFunction("DeriveOpMultipleNP", function(data, u, sequence)
  local result, t;
  result := StructuralCopy(u);
  for t in Reversed(sequence) do
    result := DeriveOpNP(data, result, t);
  od;
  return result;
end);

InstallGlobalFunction("NPIsFormallyZero", function(u)
  local a;
  for a in u[2] do
    if not IsZero(a) then
      return false;
    fi;
  od;
  return true;
end);

InstallGlobalFunction("NPHasNonZeroConstant", function(u)
    local a;
    for a in [1..Size(u[2])] do
        if (u[1][a] = []) and not IsZero(u[2][a]) then
            return true;
        fi;
    od;
    return false;
end);

InstallGlobalFunction("NPCleanUpNilpotents", function(m, u)
    local a, b, current, count, delete, v;
    v := [ [], [] ];
    for a in [1..Size(u[1])] do
        current := -1;
        count := 0;
        delete := false;
        for b in [1..Size(u[1][a])] do if not delete then
            if u[1][a][b] = current then
                count := count + 1;
                if count = m then
                    delete := true;
                fi;
            else
                current := u[1][a][b];
                count := 1;
            fi;
        fi; od;
        if not delete then
            Add(v[1], u[1][a]);
            Add(v[2], u[2][a]);
        fi;
    od;
    return v;
end);

# data: Nichols data, m: Nilpotency degree, u: vector in NP-form
InstallGlobalFunction("NPRecursiveDerivationSequence", function(data, m, u)
    local s, v, seq;
    u := NPCleanUpNilpotents(m, u);
    if NPIsFormallyZero(u) then
        return false;
    fi;
    if NPHasNonZeroConstant(u) then
        return [];
    fi;
    for s in [1..Size(data.rack)] do
        v := DeriveNP(data, u, s);
        seq := NPRecursiveDerivationSequence(data, m, v);
        if seq <> false then
            Add(seq, s);
            return seq;
        fi;
    od;
    return false;
end);
