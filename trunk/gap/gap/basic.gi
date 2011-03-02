
InstallGlobalFunction("NewRack", function(n)
	local rack; 
  rack := rec(
    isRack := false,
    matrix := NullMat(n,n),
    labels := [1..n],
    size := n,
    basis := "",				
    comments := "",         
    inn := "",
    aut := "",
    env := ""
  );    
  return rack; 
end);

InstallGlobalFunction("IsRackMatrix", function(matrix)
  local i, j, k;
  for i in [1..Size(matrix)] do
    for j in [1..Size(matrix)] do
      for k in [1..Size(matrix)] do
        if matrix[i][matrix[j][k]] <> matrix[matrix[i][j]][matrix[i][k]] then
          return false;
        fi;
      od;
    od;
  od;
  for i in [1..Size(matrix)] do
    if PermList(matrix[i]) = fail then
      return false;
    fi;
  od;
  return true;
end);

InstallGlobalFunction("RackFromAMatrix", function(matrix)
  local rack;
  if IsRackMatrix(matrix) = true then
    rack := NewRack(Size(matrix));
    rack.isRack := true;
		rack.matrix := matrix;
    return rack;
  else
    Error("This is not a rack");
    return fail;
  fi;
end);

### This function checks if the rack is indeed a rack
### If so, the flag isRack is setted to true
InstallGlobalFunction("IsRack", function(obj)
  if IsRecord(obj) and IsBound(obj.isRack) then
    if IsRackMatrix(obj.matrix) = true then
      obj.isRack := true;
      return true;
    fi;
  fi;
  return false;
end);

### This function computes the alexander rack 
### given by: i>j = si+tj                              
### Condition: s(t+s+-1)=0                            
### REMARK: if s=1-t the result is the Alexander quandle
InstallGlobalFunction("AlexanderRack", function(n,s,t)
  local i,j,m; 
  if (s*(t+s-1) mod n) <> 0 then
    return fail;
  else
    m := NullMat(n,n);
    for i in [1..n] do
      for j in [1..n] do
      	m[i][j] := (s*i+t*j) mod n;
        if m[i][j] = 0 then
          m[i][j] := n;
        fi;
      od;
    od;
    return RackFromAMatrix(m);
  fi;
end);

### Creates an abelian Rack 
InstallGlobalFunction("AbelianRack", function(n)
  return AffineCyclicRack(n, 1);
end);

InstallGlobalFunction("ConjugationRack", function(group, n)
  local m,i,j,e;
  e := Elements(group);
  m := NullMat(Size(e),Size(e));
  for i in [1..Size(e)] do
    for j in [1..Size(e)] do
      m[i][j] := Position(e, e[i]^n*e[j]*Inverse(e[i]^n));
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates a rack object with the list of permutation given by <list>
InstallGlobalFunction("RackFromPermutations", function(list)
  local i,j,n,m,rack;
  
	n := Size(list);
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j] := j^list[i]; 
    od;
  od;
  return RackFromAMatrix(m);
end);

InstallOtherMethod(Size, 
	[IsRecord],
  function(rack)
  	return rack.size;
end);

### Creates a cyclic rack", 
InstallGlobalFunction("CyclicRack", function(n)
  local m, i, j;
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j]:= ((j+1) mod n);
      if m[i][j] = 0 then
        m[i][j] := n;
      fi;
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates a dihedral quandle 
InstallGlobalFunction("DihedralRack", function(n)
  local m, i, j;
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j]:=((2*i-j) mod n);
      if m[i][j] = 0 then
        m[i][j] := n;
      fi;
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates a trivial quandle 
InstallGlobalFunction("TrivialRack", function(n)
  local i, j, m;
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j] := j;
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates an affine quandle associated to (Z_n, g)
InstallGlobalFunction("AffineCyclicRack", function(n, g)
  local i, j, m;
  if Gcd(n,g) <> 1 then
    return fail;
  fi;
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j] := ((1-g)*i + g*j) mod n;
      if m[i][j] = 0 then
        m[i][j] := n;
      fi;
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates an affine quandle over (field, z)
### <field> is a finite field of q elements
### <z> is a non-zero element of <k>
### REMARK: [IsField and IsFinite, IS_FFE],
InstallGlobalFunction("AffineRack", function(field, z)
  local rack, x, y, i, j;
  if not z in field then
    return fail;
  fi;
  rack := NullMat(Size(field), Size(field));
  for x in field do
    for y in field do
      i := Position(Elements(field), x);
      j := Position(Elements(field), y);
      rack[i][j] := Position(Elements(field), (One(field)-z)*x+z*y);
    od;
  od;
  return RackFromAMatrix(rack);
end);

### This function apply a permutation to a rack 
InstallGlobalFunction("PermuteRack", function(rack, p)
  local tmp, i, j, m;
  m := rack.matrix;
  tmp := NullMat(rack.size, rack.size);
  for i in [1..rack.size] do
    for j in [1..rack.size] do
      tmp[i^p][j^p] := m[i][j]^p;
    od;
  od;
  return RackFromAMatrix(tmp);
end);

### Computes the inner group of a <rack> 
InstallGlobalFunction("InnerGroup", function(rack)
  local i;
	if rack.inn <> "" then
		return rack.inn;
	else
   	rack.inn := Group(Permutations(rack));
    return rack.inn;
  fi;
end);

### This function returns a minimal generating subset for the <rack>
InstallGlobalFunction("MinimalGeneratingSubset", function(rack)
  local i, j, c, tmp;
	if rack.basis = "" then
    for i in [1..Size(rack)] do
      for c in Combinations(rack!.matrix[1], i) do
        tmp := CanonicalSubrack(rack, c);
        if Size(tmp) = Size(rack) then
					rack.basis := c;
          return c;
        fi;
      od;
    od;
	fi;
	return rack.basis;
end);

InstallGlobalFunction("IsIsomorphicByPermutation", function(rack1, rack2, p) 
### Checks if the permutation <p> gives an isomorphism from <rack1> to <rack2>
#  [IsRack, IsRack, IsPerm],
  local size, rack1_ij, rack2_ij, i, j;

  if not Size(rack1) = Size(rack2) then
    return false;
  fi;

  size := Size(rack1);
  for i in [1..size] do
    for j in [1..size] do
      rack1_ij := rack1!.matrix[i][j]^p;
      rack2_ij := rack2!.matrix[i^p][j^p];
      if not rack1_ij = rack2_ij then
	      return false;
      fi;
    od;
  od;
  return true;
end);

InstallGlobalFunction("IsQuotient", function(rack1, rack2)
  local a, f, g, i, gen;
  gen := MinimalGeneratingSubset(rack1);
  for a in Arrangements([1..Size(rack2)], Size(gen)) do
    f := [1..Size(rack1)]*0;
    for i in [1..Size(gen)] do
      f[gen[i]] := a[i];
    od;
    g := ExtendMorphism(rack1, rack2, f);
    if g <> false then
      return g;
    fi;
  od;
  return fail;
end);

InstallGlobalFunction("ExtendMorphism", function(rack1, rack2, f)
  local c, done, i, j;

  c := true;
  done := true;

  while c = true do
    c := false;
    for i in [1..Size(rack1)] do
      for j in [1..Size(rack1)] do
        if f[i]*f[j] <> 0 then
          ###if f[rack1!.matrix[i][j]] = 0 and rack1!.matrix[i][j] <> 0 then
          if f[rack1!.matrix[i][j]] = 0 then
            f[rack1!.matrix[i][j]] := rack2!.matrix[f[i]][f[j]];
            c := true;
          elif f[rack1!.matrix[i][j]] <> 0 and f[rack1!.matrix[i][j]] <> rack2!.matrix[f[i]][f[j]] then
            done := false;
            c := false;
          fi;
        fi;
      od;
    od;
    if done = true then
      return f;
    else
      return done;
    fi;
  od;
end);

### This function checks if <rack1> and <rack2> are isomorphic
### For that purpose a minimimal generating subset of <rack1> is computes
InstallGlobalFunction("IsomorphismRacks", function(rack1, rack2)
  local i, basis, f, s, pi, p; 

  if Size(rack1) <> Size(rack2) then
    return false;
  fi;

  ### compute a minimal generating set 
  basis := MinimalGeneratingSubset(rack1);

  for f in Combinations([1..Size(rack1)], Size(basis)) do
    for s in PermutationsList(f) do
      pi := [1..Size(rack1)] * 0; 
      for i in [1..Size(basis)] do
        pi[basis[i]] := s[i];
      od;
      p := ExtendMorphism(rack1, rack2, pi);
      if p <> false and PermList(p) <> fail then 
        if IsIsomorphicByPermutation(rack1, rack2, PermList(p)) = true then
          return PermList(p);
        fi;
      fi;
    od;
  od;
  return fail;
end);

### Apply labels to a matrix and returns the new matrix
InstallGlobalFunction("ApplyLabels", function(matrix, labels)
  local i, j, tmp;
  tmp := NullMat(Size(matrix), Size(matrix));
  for i in [1..Size(matrix)] do
    for j in [1..Size(matrix)] do
      tmp[i][j] := Position(labels, matrix[i][j]);
    od;
  od;
  return tmp;
end);

### Is the rack faithful?
InstallGlobalFunction("IsFaithful", function(rack)
  local i, s, p;
  s := [];
  for i in [1..Size(rack)] do
    p := PermList(rack.matrix[i]);
    if not p in s then
      Add(s, p);
    else
      return false;
    fi;
  od;
  return true;
end);

### Is the rack homogeneous?
### A rack is homogeneous if its automorphism group acts transitively 
InstallGlobalFunction("IsHomogeneous", function(rack)
  return IsTransitive(AutomorphismGroup(rack), [1..Size(rack)]);
end);


### Creates the core rack
InstallGlobalFunction("CoreRack", function(group)
  local m, x, y, i, j;
  m := NullMat(Size(group),Size(group));
  for x in group do
    for y in group do
      i := Position(Elements(group), x);
      j := Position(Elements(group), y);
      m[i][j] := Position(Elements(group), x*Inverse(y)*x);
    od;
  od;
  return RackFromAMatrix(m);
end);

### Creates a Rack object from the conjugacy classes of <g> in the group <group>
InstallGlobalFunction("RackFromAConjugacyClass", function(group, g)
  return RackFromConjugacyClasses(group, [g]);
end);

### This function returns the rack associated to the vertices of
### the tetrahedron, i.e. (1,2,3)^A4 
InstallGlobalFunction("TetrahedronRack", function()
  return RackFromAConjugacyClass(AlternatingGroup(4),(1,2,3));
end);

### This function returns the rack associated to the vertices of
### the tetrahedron, i.e. (1,3,2)^A4 
InstallGlobalFunction("InverseTetrahedronRack", function()
  return RackFromAConjugacyClass(AlternatingGroup(4),(1,3,2));
end);

### Creates a Rack object from the conjugacy classes of <g1,g2,...> in the group <group>
InstallGlobalFunction("RackFromConjugacyClasses", function(group, list)
  local c, z, xx, gg, t, i, j, g, m, tmp;
  gg := [];
  for g in list do
    c := ConjugacyClass(group, g);
    gg := Concatenation(gg, Elements(c));
  od;
  m := NullMat(Size(gg), Size(gg));
  for i in [1..Size(gg)] do
    for j in [1..Size(gg)] do
      m[i][j] := Position(gg, gg[i]*gg[j]*Inverse(gg[i]));
    od;
  od;
	tmp := RackFromAMatrix(m);
	tmp.labels := gg;
  return tmp;
end);

InstallGlobalFunction("RackOrbit", function(rack, i)
  if not i in [1..Size(rack)] then
    return fail;
  else
	  return Orbit(InnerGroup(rack), i);
    #return Set(InnerGroup(rack), g->i^g);
  fi;
end);


### This function computes the direct product of two given racks
InstallGlobalFunction("DirectProductOfRacks", function(rack1, rack2)
  local x,y,m,n1,n2,xy,tmp;
  
  n1 := Size(rack1);
  n2 := Size(rack2);
  xy := Cartesian(rack1.matrix[1], rack2.matrix[1]);

  m := NullMat(n1*n2,n1*n2);
  for x in xy do
    for y in xy do
      tmp := [rack1.matrix[x[1]][y[1]], rack2.matrix[x[2]][y[2]]];
      m[Position(xy,x)][Position(xy,y)] := Position(xy, tmp); 
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function returns the Yetter-Drinfeld group of a rack
InstallGlobalFunction("YetterDrinfeldGroup", function(rack, q)
  local gg, i, x, y, tmp;
  gg := [];
  for i in [1..Size(rack)] do
    tmp := ShallowCopy(PermutationMat(PermList(rack!.matrix[i]), Size(rack)));
    for x in [1..Size(rack)] do
      for y in [1..Size(rack)] do
        if tmp[x][y] = 1 then
          tmp[x][y] := q[x][y];
        fi;
      od;
    od;
    Add(gg, tmp);
  od;
  return Group(gg);
end);

### This function returns the Enveloping group of a rack
InstallGlobalFunction(EnvelopingGroup, function(rack)
	local n, f, x, rels, i, j;
 	n := Size(rack);

	f := FreeGroup(n);
	x := GeneratorsOfGroup(f); 

	rels := [];

	for i in [1..n] do
  	for j in [1..n] do
    	Add(rels, x[i]*x[j]*Inverse(x[rack!.matrix[i][j]]*x[i]));
	  od;
	od;
	return f/rels;
end);

### This function returns the set of orbits of a rack
InstallGlobalFunction("Components", function(rack)
  return Orbits(InnerGroup(rack));
end);

### Checks if the rack is a quandle 
### i>i=i for all i  
InstallGlobalFunction(IsQuandle, function(rack)
  local i;
  for i in [1..Size(rack)] do
    if not RackAction(rack, i, i) = i then 
      return false;
    fi;
  od;
  return true;
end);

### Checks if the rack is a crossed set
### i>j=j if and only if j>i=i
InstallGlobalFunction(IsCrossedSet, function(rack)
  local i,j;
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      if RackAction(rack, i, j) = j and RackAction(rack, j, i) <> i then
        return false;
      fi;
    od;
  od;
  return true;
end);

### This function returns the list of permutations of the rack
InstallGlobalFunction("Permutations", function(rack)
  return List([1..Size(rack)], x->PermList(rack.matrix[x]));
end);

### Is the rack indecomposable?
### REMARK: indecomposable is the same as connected
InstallGlobalFunction("IsIndecomposable", function(rack)
  return IsConnected(rack);
end);

### Is the rack indecomposable?
### REMARK: indecomposable is the same as connected
InstallGlobalFunction("IsConnected", function(rack)
	return IsTransitive(InnerGroup(rack), [1..Size(rack)]);
end);

### Is the rack decomposable?
InstallGlobalFunction("IsDecomposable", function(rack)
  return not IsIndecomposable(rack);
end);

### This function creates a non-commutative affine rack
InstallGlobalFunction("HomogeneousRack", function(group, s)
  local m, x, y, i, j, e;
  m := NullMat(Size(group), Size(group));
  e := Elements(group);
  for x in group do
    for y in group do
      i := Position(e, x);
      j := Position(e, y);
      m[i][j] := Position(e, Image(s, y*Inverse(x))*x);
    od;
  od;
  return RackFromAMatrix(m);
end);

### This function creates a twisted homogeneous rack
### FIXME: we need the orbits!
InstallGlobalFunction("TwistedHomogeneousRack", function(group, s)
  local m, x, y, i, j, e;
  m := NullMat(Size(group), Size(group));
  e := Elements(group);
  for x in group do
    i := Position(e, x);
    for y in group do
      j := Position(e, y);
      m[i][j] := Position(e, x*Image(s, y*Inverse(x)));
    od;
  od;
  return RackFromAMatrix(m);
end);

#####################
### other methods ###
#####################
InstallOtherMethod(AutomorphismGroup, 
  "Returns the automorphism group of <rack>",
  [IsRecord],
  function(rack)
  local i, f, s, pi, p, gens; 

  gens := [];

  ### compute a minimal generating set 
	if rack.basis = "" then
    rack.basis := MinimalGeneratingSubset(rack);
	fi;

  for f in Combinations([1..Size(rack)], Size(rack.basis)) do
    for s in PermutationsList(f) do
      pi := [1..Size(rack)] * 0; 
      for i in [1..Size(rack.basis)] do
        pi[rack.basis[i]] := s[i];
      od;
      p := ExtendMorphism(rack, rack, pi);
      if p <> false and PermList(p) <> fail then 
        Add(gens, PermList(p));
      fi;
    od;
  od;
  return Group(gens);
end);

### This function computes the inverse of the rack 
InstallOtherMethod(Inverse,
  "Returns the inverse rack",
  [IsRecord],
  function(rack)
    return RackFromPermutations(List(Permutations(rack), Inverse));
#    local i,j,m;
#    m := NullMat(Size(rack),Size(rack));
#    for i in [1..Size(rack)] do
#      for j in [1..Size(rack)] do
#        m[i][j] := First([1..Size(rack)], k->rack.matrix[i][k]=j);
#      od;
#    od;
#    return RackFromAMatrix(m);
end);

### This function computes the rank of a rack
InstallOtherMethod(Rank,
  "Computes the rank of a rack", 
  [IsRecord],
  function(rack)
    local i,p;
    p := [];
    for i in [1..Size(rack)] do
      Add(p, rack.matrix[i][i]);
    od;
    return Order(PermList(p));
end);

### This function returns the element k such that i>j=k
InstallGlobalFunction("InverseRackAction", function(rack, i, j)
  return Position(rack.matrix[i], j);
end);

### This function returns the element i>j
InstallGlobalFunction("RackAction", function(rack, i, j)
  return rack.matrix[i][j];
end);

### This function computes the local exponent related to i>j
InstallGlobalFunction("LocalExponent", function(rack, i, j)
  local k,e;
  e := 1;
  k := j;
  while rack.matrix[i][k] <> j do 
    k := rack.matrix[i][k];
    e := e+1;
  od;
  return e;
end);

### Return a list with all the local exponents associated to a given rack
InstallGlobalFunction("LocalExponents", function(rack)
  local i,j,k,e,exp;
  exp := [];
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      e := LocalExponent(rack, i, j);
      if not e in exp then
        Add(exp, e);
      fi;
    od;
  od;
  return exp;
end);

### This function computes the i-th power of the rack
InstallGlobalFunction("Power", function(rack, i)
  local perms;
  perms := Permutations(rack);
  return RackFromPermutations(List([1..Size(rack)], x->perms[x]^i));
end);

### This function computes the set of morphism from one rack to another
InstallOtherMethod(Hom,
  "Computes the set of morphism from <rack1> to <rack2>", 
  [IsRecord, IsRecord],
  function(rack1, rack2)
    local l,o,w,i,j,f,g;
    l := [List([1..Size(rack1)], x->0)];
    o := [];
    while not Size(l) = 0 do
      w := l[1];
      Remove(l,1);
      #if w 
        if not 0 in w then
          Add(o,w);
        else
          i := Position(w,0);
          for j in [1..Size(rack2)] do
            f := ShallowCopy(w);
            f[i] := j;
            g := ExtendMorphism(rack1, rack2, f);
            if not g = false then
              Add(l,f);
            fi;
          od;
        fi;
      od;
  #  fi;
    return o;
end);
    
InstallOtherMethod(Degree,
  "Computes the set of degrees of the <rack>", 
  [IsRecord],
  function(rack)
    local i,d,m;
    d := [];
    for i in [1..Size(rack)] do
      m := Order(PermList(rack.matrix[i]));
      if not m in d then
        Add(d, m);
      fi;
    od;
    return d;
end);

### This function checks if the <rack> is braided
### A rack X is braided if i>(j>i)=j or i>j=j for all i,j in X
InstallGlobalFunction("IsBraided", function(rack)
  local i,j;
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      if not rack.matrix[i][rack.matrix[j][i]] = j and (not rack.matrix[i][j] = j or not rack.matrix[j][i] = i) then
        return false;
      fi;
    od;
  od;
  return true;
end);

### This functions is useful for checking if a given rack is affine
### Written by Andreas Lochmann
InstallGlobalFunction("Affinise", function(rack, neutralelement)
 local i,j,m;
 m := NullMat(Size(rack), Size(rack));
 for i in [1..Size(rack)] do
  for j in [1..Size(rack)] do
    m[rack.matrix[i][neutralelement]][rack.matrix[neutralelement][j]] := rack.matrix[i][j];
  od;
 od;
 return MagmaWithInversesByMultiplicationTable(m);
end);

### General function to constructing racks
###
### EXAMPLES: 
### Construct the rack associated to a conjugacy class of a group
###     gap> Rack(SymmetricGroup(3), (1,2));
###     gap> Rack(SymmetricGroup(3), (), (1,2));
###     gap> Rack(SymmetricGroup(3), [(), (1,2))];
###     gap> Rack(ConjugacyClass(SymmetricGroup(3), (1,2)));
###     gap> Rack(ConjugacyClasses(SymmetricGroup(3));
###
### EXAMPLE: 
### Construct the rack with a given matrix
###     gap> Rack([[1, 3, 2], [3, 2, 1], [2, 1, 3]]); 
###
### EXAMPLE: 
### Contruct the rack given by permutations
###     gap> Rack((2,3), (1,3), (1,2));
###     gap> Rack([(2,3), (1,3), (1,2)]);
InstallGlobalFunction("Rack", function(arg)
  local group, reps;

  # The first argument is a group
  if IsGroup(arg[1]) then
    group := arg[1];
    # remove the group from the argument
    Remove(arg, 1); 
    if IsList(arg[1]) then
      return RackFromConjugacyClasses(group, arg[1]);
    else
      return RackFromConjugacyClasses(group, arg);
    fi;
  fi;

  # The argument is the matrix of the rack
  if IsMatrix(arg[1]) then
    return RackFromAMatrix(arg[1]);
  fi;

  # The argument is a list
  # OPTIONS
  # 1) A list of conjugacy classes (all clases *MUST* have the same acting domain!)
  # 2) A list of permutations
  if IsList(arg[1]) then
    if IsConjugacyClassGroupRep(arg[1][1]) then
      return RackFromConjugacyClasses(ActingDomain(arg[1][1]), List(arg[1], Representative));
    elif IsPerm(arg[1][1]) then
      return RackFromPermutations(arg[1]);
    fi;
  fi;

  # Only conjugacy classes in the argument 
  if IsConjugacyClassGroupRep(arg[1]) then
    return RackFromConjugacyClasses(ActingDomain(arg[1]), List(arg, Representative));
  fi;

  # Permutations
  if IsPerm(arg[1]) then
    return RackFromPermutations(arg);
  fi;
  return Error("wrong parameters!");
end);

InstallGlobalFunction("Quandle", function(arg)
  local r, params;
  r := CallFuncList(Rack, arg);
  if IsQuandle(r) then
    return r;
  else
    Error("The rack is not a quandle");
  fi;
end);

### This function checks if a permutation p of order 1 or 2 
### is a good involution: x>p(x)>y=y and p(x>y)=x>p(y)
InstallGlobalFunction("IsGoodInvolution", function(rack, p)
  local i, j;
  if not Order(p) in [1,2] or not MovedPoints(p) = Size(rack) then
    return false;
  fi;
  for i in [1..Size(rack)] do
    for j in [1..Size(rack)] do
      if not RackAction(rack, i, RackAction(rack, i^p, j)) = j or not RackAction(rack, i, j)^p = RackAction(rack, i, j^p) then
        return false;
      fi;
    od;
  od;
  return true;
end);

# vim: ft=gap: ts=2: sw=2
