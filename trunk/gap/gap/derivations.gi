
# Act with t on monomial in NicholsDatum data

InstallGlobalFunction("ActNP", function(data, u, t)
  local result, j, k, monomial, mres, cres;
  result := [[],[]];
  for j in [1..Size(u[2])] do
    monomial := u[1][j];
    mres := [];
    cres := u[2][j];
    for k in [1..Size(monomial)] do
      mres[k] := data.rack.matrix[t][monomial[k]];
      cres := cres * data.q[t][monomial[k]]; ## TODO: Correct sequence?
    od;  
    result := AddNP(result, [[mres],[cres]], 1, 1);
  od;
  return result;
end);

# Skew-derive the NP-polynomial u with respect to t in NicholsDatum data
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
  #Print(" ... return ", result, "\n");
  return result;
end);

InstallGlobalFunction("DeriveMultipleNP", function(data, u, sequence)
  local result, t;
  result := StructuralCopy(u);
  for t in sequence do
    result := DeriveNP(data, result, t);
  od;
  return result;
end);

# The sequence of degrees of v, seen as polynomial in x_t
InstallGlobalFunction("SignatureNP", function(data, v)
  local result, t, k, notfound, derivation;
  #Print("Signature of ", v, "\n");
  result := [];
  for t in [1..Size(data.rack)] do
    #Print(t, "\n");
    notfound := true;
    k := 0;
    derivation := CleanNP(StructuralCopy(v));
    while Size(derivation[2]) > 0 do
      k := k + 1;
      #Print("...",k," : ", derivation, "\n");
      derivation := DeriveNP(data, derivation, t);
    od;
    result[t] := k;
  od;
  return result - 1;
end);

InstallGlobalFunction("SynBaseNP", function(syntactical_basis)
  local list, a, i,j,k,l,m,n,o,p,q,r, ind, algebra_element;
  list := [];
  for i in [1..Size(syntactical_basis[1])] do
  for j in [1..Size(syntactical_basis[2])] do
  for k in [1..Size(syntactical_basis[3])] do
  for l in [1..Size(syntactical_basis[4])] do
  for m in [1..Size(syntactical_basis[5])] do
  for n in [1..Size(syntactical_basis[6])] do
  for o in [1..Size(syntactical_basis[7])] do
  for p in [1..Size(syntactical_basis[8])] do
  for q in [1..Size(syntactical_basis[9])] do
  for r in [1..Size(syntactical_basis[10])] do
      ind := [i,j,k,l,m,n,o,p,q,r];
      algebra_element := [];
      for a in [1..10] do
          algebra_element := Concatenation(algebra_element, syntactical_basis[a][ind[a]]);
      od;
      Add(list, CleanNP([[algebra_element],[1]]));
  od; od; od; od; od; od; od; od; od; od;
  return list;
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

InstallGlobalFunction("NPIsRecursivelyZero", function(data, m, u)
    local s, v;
    u := NPCleanUpNilpotents(m, u);
    if NPIsFormallyZero(u) then
        #Print("   ... is formally zero. Return true.\n");
        return true;
    fi;
    if NPHasNonZeroConstant(u) then
        #Print("   ... has non-zero constant. Return false.\n");
        return false;
    fi;
    for s in [1..Size(data.rack)] do
        v := DeriveNP(data, u, s);
        if not NPIsRecursivelyZero(data, m, v) then
            #Print("   ... derivation by ", s, " yielded non-zero element. Return false.\n");
            return false;
        fi;
    od;
    #Print("   ... derivation yielded only zeroes. Return true.\n");
    return true;
end);

InstallGlobalFunction("LongestWordWithPrefix", function(data, m, prefix)
    local t, s, c, new_word, sub_word, l;
    #Print("        Called with: ");
    #PrintNPList([prefix]);
    c := true;
    for t in [1..Size(data.rack)] do
        new_word := StructuralCopy(prefix);
        Add(new_word[1][1], t);
        l := Size(new_word[1][1]);
        Print("        (", String(l,2), ")   Test: ");
        PrintNPList([new_word]);
        sub_word := StructuralCopy(new_word);
        if(Size(sub_word[1][1]) > 7) then
            sub_word[1][1] := sub_word[1][1]{[(l-6)..l]};
        fi;
        if (not NPIsRecursivelyZero(data, m, sub_word)) and not NPIsRecursivelyZero(data, m, new_word) then
            c := false;
            LongestWordWithPrefix(data, m, new_word);
        fi;
    od;
    if c then
        PrintNPList([prefix]);
    fi;
end);

InstallGlobalFunction("LongestWord", function(data, m)
    LongestWordWithPrefix(data, m, [[[]], [1]]);
end);



