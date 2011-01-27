InstallGlobalFunction("NewRack", function(n)
	local rack; 
  rack := rec(
    isRack := true,
    matrix := NullMat(n,n),
    labels := [1..n],
    size := n,
    basis := "",				
    comments := "",         
  	permutations := "",
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

InstallGlobalFunction("Rack", function(matrix)
  local rack;
  if IsRackMatrix(matrix) = true then
    rack := NewRack(Size(matrix));
		rack.matrix := matrix;
    return rack;
  else
    Error("This is not a rack");
    return fail;
  fi;
end);

InstallGlobalFunction("IsRack", function(obj)
  return IsRecord(obj) and IsBound(obj.isRack) and obj.isRack=true;
end);

##########################################################
### AlexanderRack																			 ###
###                                                    ###
### This function computes the Alexander rack          ###
### given by: i>j = si+tj                              ### 
### Condition: s(t+s+-1)=0                             ###
### Note: if s=1-t the result is the Alexander quandle ###
##########################################################
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
    return Rack(m);
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
  return Rack(m);
end);

### This function creates a rack object with the list of permutation given by <list>
InstallGlobalFunction("RackFromListOfPermutations", function(list)
  local i,j,n,m,rack;
  
	n := Size(list);
  m := NullMat(n,n);
#  rack := rec(
#    isRack := true,
#    matrix := NullMat(n,n),
#    labels := [1..n],     
#    size := n,
#		basis := "",				
#    comments := "",         
#		permutations := list,
#    inn := "",
#    aut := "",
#		env := ""
#  );    

  for i in [1..n] do
    for j in [1..n] do
      #rack.matrix[i][j] := j^list[i]; 
      m[i][j] := j^list[i]; 
    od;
  od;
  return Rack(m);
end);

InstallOtherMethod(Size, 
	[IsRecord],
  function(rack)
	if IsRack(rack) then
  	return rack.size;
	else
		Error("It is not a rack");
	fi;
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
  return Rack(m);
end);

InstallGlobalFunction("DihedralRack", function(n)
### Creates a Dihedral rack", 
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
  return Rack(m);
end);

InstallGlobalFunction("TrivialRack", function(n)
### Creates a trivial rack
  local i, j, m;
  m := NullMat(n,n);
  for i in [1..n] do
    for j in [1..n] do
      m[i][j] := j;
    od;
  od;
  return Rack(m);
end);

InstallGlobalFunction("AffineCyclicRack", function(n, g)
### Creates an affine rack associated to (F_n, g)
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
  return Rack(m);
end);

InstallGlobalFunction("AffineRack", function(k, z)
### Creates an affine rack (k, z)
### <k> is a finite field
### <z> is a non-zero element of <k>
#  [IsField and IsFinite, IS_FFE],
  local rack, x, y, i, j;
  if not z in k then
    return fail;
  fi;
  rack := NullMat(Size(k), Size(k));
  for x in k do
    for y in k do
      i := Position(Elements(k), x);
      j := Position(Elements(k), y);
      rack[i][j] := Position(Elements(k), (One(k)-z)*x+z*y);
    od;
  od;
  return Rack(rack);
end);

InstallGlobalFunction("PermuteRack", function(rack, p)
### Apply a permutation to a rack 
###  [IsRack, IsPerm],
  local tmp, i, j, m;
  m := rack.matrix;
  tmp := NullMat(rack.size, rack.size);
  for i in [1..rack.size] do
    for j in [1..rack.size] do
      tmp[i^p][j^p] := m[i][j]^p;
    od;
  od;
  return Rack(tmp);
end);

### Computes the Inner group of <rack> 
InstallGlobalFunction("InnerGroup", function(rack)
  local i;
	if IsRack(rack) then
		if rack.inn <> "" then
			return rack.inn;
		else
			if rack.permutations = "" then
        rack.permutations := [];
        for i in [1..rack.size] do
          Add(rack.permutations, PermList(rack.matrix[i]));
        od;
		  	rack.inn := Group(rack.permutations);
        return rack.inn;
			else
				return Group(rack.permutations);
			fi;
		fi;
	else
		Error("usage: InnerGroup( <rack> )");
		return fail;
	fi;
end);

InstallGlobalFunction("MinimalGeneratingSubset", function(rack)
### Returns the minimal generating subset for the rack
  local i, j, c, tmp;
	if IsRack(rack) then
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
	else
		Error("usage: MinimalGeneratingSubset(<rack>)");
	fi;
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
###  "",
###  [IsRack, IsRack],
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
###  [IsRack, IsRack, IsList],
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

InstallGlobalFunction("IsomorphismRacks", function(rack1, rack2)
### Checks if <rack1> and <rack2> are isomorphic
###  [IsRack, IsRack],
  local i, basis, f, s, pi, p; 

  if Size(rack1) <> Size(rack2) then
    return false;
  fi;

  ### Minimal generating set 
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

InstallGlobalFunction("ApplyLabels", function(matrix, labels)
### Apply labels to a matrix and returns the new matrix
###  [IsMatrix, IsList], 
  local i, j, tmp;
  tmp := NullMat(Size(matrix), Size(matrix));
  for i in [1..Size(matrix)] do
    for j in [1..Size(matrix)] do
      tmp[i][j] := Position(labels, matrix[i][j]);
    od;
  od;
  return tmp;
end);

InstallGlobalFunction("IsFaithful", function(rack)
### Is the rack faithful?
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

InstallGlobalFunction("IsHomogeneous", function(rack)
  if IsRack(rack) then
		return IsTransitive(AutomorphismGroup(rack), [1..Size(rack)]);
  else
    Error("usage: IsHomogeneous( <rack> )");
  fi;
end);

InstallGlobalFunction("CoreRack", function(group)
### Creates the core rack
###  [IsGroup],
  local m, x, y, i, j;
  m := NullMat(Size(group),Size(group));
  for x in group do
    for y in group do
      i := Position(Elements(group), x);
      j := Position(Elements(group), y);
      m[i][j] := Position(Elements(group), x*Inverse(y)*x);
    od;
  od;
  return Rack(m);
end);


InstallGlobalFunction("RackFromAConjugacyClass", function(group, g)
### Creates a Rack object from the conjugacy classes of <g> in the group <group>
### [IsGroup, IsObject],
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

InstallGlobalFunction("RackFromConjugacyClasses", function(group, list)
### Creates a Rack object from the conjugacy classes of <g1,g2,...> in the group <group>
### [IsGroup, IsCollection] 
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
	tmp := Rack(m);
	tmp.labels := gg;
  return tmp;
	###Rack(m); ### labels: gg
end);

InstallGlobalFunction("RackOrbit", function(rack, i)
	if IsRack(rack) then
    if not i in [1..Size(rack)] then
      return fail;
    else
		  return Orbit(InnerGroup(rack), i);
      #return Set(InnerGroup(rack), g->i^g);
    fi;
	else
		Error("usage: RackOrbit( <rack>, <subset> )");
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
  return Rack(m);
end);

InstallGlobalFunction("YDGroup", function(rack, q)
### Returns the Yetter-Drinfeld group of a rack
###  [IsRack, IsMatrix], 
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

InstallGlobalFunction(EnvelopingGroup, function(rack)
### Returns the Enveloping group of a rack
###  [IsRack], 
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

InstallGlobalFunction("Components", function(rack)
	if IsRack(rack) then
		return Orbits(InnerGroup(rack));
	else
		Error("usage: Components( <rack> )");
	fi;
end);



InstallGlobalFunction("Permutations", function(rack)
	local i, g;
	if IsRack(rack) then
		if rack.permutations = "" then
      g := [];
      for i in [1..rack.size] do
        Add(g, PermList(rack.matrix[i]));
      od;
      rack.permutations := g;
    fi;
	  return rack.permutations;
	else
		Error("Use Permutations(<rack>);");
	fi;
end);

InstallGlobalFunction("IsIndecomposable", function(rack)
  if IsRack(rack) then
		return IsConnected(rack);
#		return Size(RackOrbit(rack, 1)) = Size(rack);
  else
    Error("usage: IsIndecomposable( <rack> )");
  fi;
end);

InstallGlobalFunction("IsConnected", function(rack)
  if IsRack(rack) then
		return IsTransitive(InnerGroup(rack), [1..Size(rack)]);
  else
    Error("usage: IsConnected( <rack> )");
  fi;
end);

InstallGlobalFunction("IsDecomposable", function(rack)
  if IsRack(rack) then
    return not IsIndecomposable(rack);
  else
    Error("usage: IsDecomposable( <rack> )");
  fi;
end);

###  Creates an noncommutative affine rack
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
  return Rack(m);
end);

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
  return Rack(m);
end);

#####################
### other methods ###
#####################
InstallOtherMethod(AutomorphismGroup, 
  "Returns the automorphism group of <rack>",
  [IsRecord],
  function(rack)
  local i, f, s, pi, p, gens; 

	if not IsRack(rack) then
		Error("usage: AutomorphismGroup( <rack> )");
	fi;

  gens := [];

  ### Minimal generating set 
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

InstallOtherMethod(Inverse,
  "Returns the inverse rack",
  [IsRecord],
  function(rack)
    local i,j,m;
  	if not IsRack(rack) then
   		Error("usage: Rank( <rack> )");
  	fi;

    m := NullMat(Size(rack),Size(rack));
    for i in [1..Size(rack)] do
      for j in [1..Size(rack)] do
        m[i][j] := First([1..Size(rack)], k->rack.matrix[i][k]=j);
      od;
    od;
    return Rack(m);
end);

InstallOtherMethod(Rank,
"Computes the rank of a rack", [IsRecord],
function(rack)
  local i,p;
	if not IsRack(rack) then
		Error("usage: Rank( <rack> )");
	fi;

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
  Permutations(rack);
  return RackFromListOfPermutations(List([1..Size(rack)], x->rack.permutations[x]^i));
end);

InstallOtherMethod(Hom,
"Computes the set of morphism from <rack1> to <rack2>", [IsRecord, IsRecord],
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
"Computes the set of degrees of the <rack>", [IsRecord],
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
### This functions is useful for checking if angiven rack is affine
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

# vim: ft=gap: ts=2: sw=2
