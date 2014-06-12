LoadPackage("rig");

check_maps := function(s, t, sigma, tau)
  local i,j,y,z;

  ### Check whether sigma is a rack homomorphism
  for i in [1..Size(s)] do
    for j in [1..Size(s)] do
      if sigma[RackAction(s, i, j)] <> sigma[i]*sigma[j]*Inverse(sigma[i]) then
        return false;
      fi;
    od;
  od;

  ### Check whether tau is a rack homomorphism
  for i in [1..Size(t)] do
    for j in [1..Size(t)] do
      if tau[RackAction(t, i, j)] <> tau[i]*tau[j]*Inverse(tau[i]) then
        return false;
      fi;
    od;
  od;

  for y in [1..Size(s)] do
    for z in [1..Size(t)] do
      if Permutations(t)[z]*sigma[y] <> sigma[y^tau[z]]*Permutations(t)[z] then
        return false;
      fi;
      if Permutations(s)[y]*tau[z] <> tau[z^sigma[y]]*Permutations(s)[y] then
        return false;
      fi;
    od;
  od;
  return true;
end;

### This function returns true if the maps <sigma> and <tau> satisfy
### a) phi_z sigma_y = sigma_{tau_z(y)} phi_z, and 
### b) phi_y tau_z = tau_{sigma_y(z)} phi_y
amalgamated_maps := function(s, t)
  local aut_s, aut_t, sigma, tau, maps;
  
  maps := [];

  for sigma in IteratorOfTuples(AutomorphismGroup(t), Size(s)) do
    for tau in IteratorOfTuples(AutomorphismGroup(s), Size(t)) do
      if check_maps(s, t, sigma, tau) = true then 
        Add(maps, [sigma, tau]);
      fi;
    od;
  od;
  return maps;
end;  
  
### [AG, Lemma 1.18]
amalgamated_sum := function(s, t, sigma, tau)
  local n, m, i, j;

  n := Size(s)+Size(t);
  m := NullMat(n,n);

  if check_maps(s, t, sigma, tau) = false then
    return fail;
  fi;

  for i in [1..n] do
    for j in [1..n] do
      if i in [1..Size(s)] and j in [1..Size(s)] then
        m[i][j] := RackAction(s, i, j);
      elif i in [1..Size(s)] and j in [Size(s)+1..n] then
        m[i][j] := Size(s)+((j-Size(s))^sigma[i]);
      elif i in [Size(s)+1..n] and j in [1..Size(s)] then
        m[i][j] := j^tau[i-Size(s)];
      elif i in [Size(s)+1..n] and j in [Size(s)+1..n] then
        m[i][j] := Size(s)+RackAction(t, i-Size(s), j-Size(s));
      else
        Print("????");
      fi;
    od;
  od;
  return Rack(m);
end;
