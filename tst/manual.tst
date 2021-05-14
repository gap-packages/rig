##  This test contains examples from the package manual
gap> START_TEST("rig package: manual.tst");

# IsAffineIndecomposableQuandle( <quandle> );
gap> r := SmallQuandle(5,1);;
gap> IsAffineIndecomposableQuandle(r);
true
gap> s := SmallQuandle(6,1);;
gap> IsAffineIndecomposableQuandle(s);
# It contains commuting elements
false

# TrivialRack( <n> );
gap> r := TrivialRack(3);;
gap> Display(r);
rec(
  aut := "",
  basis := "",
  comments := "",
  env := "",
  inn := "",
  isRack := true,
  labels := [ 1 .. 3 ],
  matrix := [ [ 1, 2, 3 ], [ 1, 2, 3 ], [ 1, 2, 3 ] ],
  size := 3 )

# AffineCyclicRack( <n>, <x> )
gap> r := AffineCyclicRack(3,2);;
gap> Display(r);
rec(
  aut := "",
  basis := "",
  comments := "",
  env := "",
  inn := "",
  isRack := true,
  labels := [ 1 .. 3 ],
  matrix := [ [ 1, 3, 2 ], [ 3, 2, 1 ], [ 2, 1, 3 ] ],
  size := 3 )

# AffineRack( <field>, <field_element> )
gap> r := AffineRack(GF(3), Z(3));;
gap> Display(r);
rec(
  aut := "",
  basis := "",
  comments := "",
  env := "",
  inn := "",
  isRack := true,
  labels := [ 1 .. 3 ],
  matrix := [ [ 1, 3, 2 ], [ 3, 2, 1 ], [ 2, 1, 3 ] ],
  size := 3 )

# CyclicRack( <n> )
gap> r := CyclicRack(3);;
gap> Display(r);
rec(
  aut := "",
  basis := "",
  comments := "",
  env := "",
  inn := "",
  isRack := true,
  labels := [ 1 .. 3 ],
  matrix := [ [ 2, 3, 1 ], [ 2, 3, 1 ], [ 2, 3, 1 ] ],
  size := 3 )

# CoreRack( <group> )
gap> r := CoreRack(CyclicGroup(3));;
gap> Display(r);
rec(
  aut := "",
  basis := "",
  comments := "",
  env := "",
  inn := "",
  isRack := true,
  labels := [ 1 .. 3 ],
  matrix := [ [ 1, 3, 2 ], [ 3, 2, 1 ], [ 2, 1, 3 ] ],
  size := 3 )

# DihedralRack( <n> ) 
gap> r := DihedralRack(5);;
gap> Display(r.matrix);
[ [  1,  5,  4,  3,  2 ],
  [  3,  2,  1,  5,  4 ],
  [  5,  4,  3,  2,  1 ],
  [  2,  1,  5,  4,  3 ],
  [  4,  3,  2,  1,  5 ] ]

# DirectProductOfRack( <rack1>, <rack2> )
gap> r := DirectProductOfRacks(DihedralRack(3), TrivialRack(2));;
gap> Display(r.matrix);
[ [  1,  2,  5,  6,  3,  4 ],
  [  1,  2,  5,  6,  3,  4 ],
  [  5,  6,  3,  4,  1,  2 ],
  [  5,  6,  3,  4,  1,  2 ],
  [  3,  4,  1,  2,  5,  6 ],
  [  3,  4,  1,  2,  5,  6 ] ]

# HomogeneousRack( <group>, <automorphism> )
gap> f := ConjugatorAutomorphism(SymmetricGroup(3), (1,2));;
gap> r := HomogeneousRack(SymmetricGroup(3), f);;
gap> Display(r.matrix);
[ [  1,  6,  3,  5,  4,  2 ],
  [  4,  2,  6,  1,  5,  3 ],
  [  1,  6,  3,  5,  4,  2 ],
  [  5,  3,  2,  4,  1,  6 ],
  [  4,  2,  6,  1,  5,  3 ],
  [  5,  3,  2,  4,  1,  6 ] ]

# RackFromPermutations( <list> )
gap> r := RackFromPermutations([(2,3),(1,3),(1,2)]);;
gap> Display(r.matrix);
[ [  1,  3,  2 ],
  [  3,  2,  1 ],
  [  2,  1,  3 ] ]

# AutomorphismGroup( <rack> )
gap> AutomorphismGroup(TrivialRack(3));
Group([ (), (2,3), (1,2), (1,2,3), (1,3,2), (1,3) ])

# InnerGroup( <rack> )
gap> InnerGroup(DihedralRack(3));
Group([ (2,3), (1,3), (1,2) ])
gap> InnerGroup(TrivialRack(5));
Group(())

# IsomorphismRack( <r>, <s> )
gap> a := Rack(AlternatingGroup(4), (1,2,3));;
gap> b := Rack(AlternatingGroup(4), (1,3,2));;
gap> c := AbelianRack(4);;
gap> IsomorphismRacks(a,b);
(3,4)
gap> IsomorphismRacks(a,c);
fail

# IsMorphism ( <f>, <r>, <s> )
gap> r := SmallQuandle(6,1);;
gap> s := DihedralRack(3);;
gap> for f in Hom(r,s) do Print("Is f=", f, ", a rack morphism? ", IsMorphism(f, r, s), "\n"); od;
Is f=[ 1, 1, 1, 1, 1, 1 ], a rack morphism? true
Is f=[ 1, 1, 2, 2, 3, 3 ], a rack morphism? true
Is f=[ 1, 1, 3, 3, 2, 2 ], a rack morphism? true
Is f=[ 2, 2, 1, 1, 3, 3 ], a rack morphism? true
Is f=[ 2, 2, 2, 2, 2, 2 ], a rack morphism? true
Is f=[ 2, 2, 3, 3, 1, 1 ], a rack morphism? true
Is f=[ 3, 3, 1, 1, 2, 2 ], a rack morphism? true
Is f=[ 3, 3, 2, 2, 1, 1 ], a rack morphism? true
Is f=[ 3, 3, 3, 3, 3, 3 ], a rack morphism? true

# IsQuotient ( <r>, <s> )
gap> IsQuotient(SmallQuandle(6,1), DihedralRack(3));
[ 1, 1, 2, 2, 3, 3 ]
gap> IsQuotient(SmallQuandle(6,2), DihedralRack(3));
[ 1, 1, 2, 2, 3, 3 ]
gap> IsQuotient(DihedralRack(4), TrivialRack(2));
[ 1, 2, 1, 2 ]

# Rack( <matrix> ) F
gap> a := AbelianRack(2);;
gap> b := Rack([[1,2],[1,2]]);;
gap> Display(b.matrix);
[ [  1,  2 ],
  [  1,  2 ] ]
gap> a=b;
true

# Rack( <group>, <group_element> ) F
gap> r := Rack(AlternatingGroup(4), (1,2,3));;
gap> Display(r.matrix);
[ [  1,  3,  4,  2 ],
  [  4,  2,  1,  3 ],
  [  2,  4,  3,  1 ],
  [  3,  1,  2,  4 ] ]

# Rack( <set> )
gap> set := Set([(1,2),(2,3),(1,3)]);;
gap> Rack(set) = Rack(SymmetricGroup(3), (1,2));
true

# RackHomology ( <rack>, <order> ) F
# RackCohomology ( <rack>, <order> ) F
gap> RackCohomology(DihedralRack(3),2);
[ 1, [  ] ]
gap> RackCohomology(TrivialRack(3),2);
[ 9, [  ] ]
gap> RackHomology(TrivialRack(2),2);
[ 4, [  ] ]
gap> RackHomology(DihedralRack(4),2);
[ 4, [ 2, 2 ] ]

# Dimension( <nichols_datum>, <n> )
gap> r := DihedralRack(3);;
gap> q := [ [ -1, -1, -1 ], [ -1, -1, -1 ], [ -1, -1, -1 ] ];;
gap> n := NicholsDatum(r, q, Rationals);;
gap> for i in [0..5] do
>   Print("Degree ", i, ", dimension=", Dimension(n,i), "\n");
> od;
Degree 0, dimension=1
Degree 1, dimension=3
Degree 2, dimension=4
Degree 3, dimension=3
Degree 4, dimension=1
Degree 5, dimension=0

# Relations4GAP( <nichols_datum>, <n> )
gap> r := DihedralRack(3);;
gap> q := [ [ -1, -1, -1 ], [ -1, -1, -1 ], [ -1, -1, -1 ] ];;
gap> n := NicholsDatum(r, q, Rationals);;
gap> rels := Relations4GAP(n, 2);;
gap> PrintNPList(rels);
 a^2 
 b^2 
 ab + bc + ca 
 ac + ba + cb 
 c^2 

# RackOrbit( <rack>, <i> )
gap> r := DihedralRack(4);;
gap> RackOrbit(r, 1);
[ 1, 3 ]

# Nr_k ( <rack>, <n> )
gap> Check := function(rack)
> local n,s,d;
> d := Size(rack);
> s := 0;
> for n in [3..d^2] do
>   s := s+(n-2)*Nr_k(rack,n)/(2*n);
> od;
> if s <= 1 then
>   return s;
> else
>   return fail;
> fi;
> end;;
gap> a4 := AlternatingGroup(4);;
gap> s4 := SymmetricGroup(4);;
gap> s5 := SymmetricGroup(5);;
gap> Check(RackFromAConjugacyClass(a4, (1,2,3)));
1/2
gap> Check(RackFromAConjugacyClass(s4, (1,2)));
2/3
gap> Check(RackFromAConjugacyClass(s4, (1,2,3,4)));
2/3
gap> Check(RackFromAConjugacyClass(s5, (1,2)));
1
gap> Check(AffineCyclicRack(5,2));
1
gap> Check(AffineCyclicRack(5,3));
1
gap> Check(AffineCyclicRack(7,5));
1
gap> Check(AffineCyclicRack(7,3));
1
gap> Check(DihedralRack(3));
1/3

# Braiding ( <rack> )
gap> Display(Braiding(TrivialRack(2)));  
[ [  1,  0,  0,  0 ],
  [  0,  0,  1,  0 ],
  [  0,  1,  0,  0 ],
  [  0,  0,  0,  1 ] ]

# SubracksUpToIso ( <rack>, <subr>, <n> )
gap> r := DihedralRack(8);;
gap> subracks := SubracksUpToIso(r,[1],8);;
gap> for s in subracks do
> Print(Size(s),"\n");
> od;
1
8
4
2

# IsIndecomposable ( <rack> )
gap> r := DihedralRack(3);;
gap> IsIndecomposable(r);
true
gap> s := DihedralRack(4);;
gap> IsIndecomposable(s);
false

# Permutations( <rack> )
gap> r := TetrahedronRack();;
gap> Permutations(r);
[ (2,3,4), (1,4,3), (1,2,4), (1,3,2) ]

# HurwitzOrbit( <rack>, <vector> )
gap> r := DihedralRack(3);;
gap> HurwitzOrbit(r, [1,1,1]);
[ [ 1, 1, 1 ] ]
gap> HurwitzOrbit(r, [1,2,3]);
[ [ 1, 2, 3 ], [ 3, 1, 3 ], [ 1, 1, 2 ], [ 2, 3, 3 ], [ 3, 2, 1 ], 
  [ 1, 3, 1 ], [ 3, 3, 2 ], [ 2, 1, 1 ] ]

# HurwitzOrbits( <rack>, <n> )
gap> r := DihedralRack(3);;
gap> HurwitzOrbits(r, 3);
[ [ [ 1, 1, 1 ] ], 
  [ [ 1, 1, 2 ], [ 1, 3, 1 ], [ 2, 1, 1 ], [ 1, 2, 3 ], [ 3, 2, 1 ], 
      [ 3, 1, 3 ], [ 3, 3, 2 ], [ 2, 3, 3 ] ], 
  [ [ 1, 1, 3 ], [ 1, 2, 1 ], [ 3, 1, 1 ], [ 1, 3, 2 ], [ 2, 3, 1 ], 
      [ 2, 1, 2 ], [ 2, 2, 3 ], [ 3, 2, 2 ] ], 
  [ [ 1, 2, 2 ], [ 3, 1, 2 ], [ 2, 3, 2 ], [ 3, 3, 1 ], [ 2, 1, 3 ], 
      [ 3, 2, 3 ], [ 2, 2, 1 ], [ 1, 3, 3 ] ], [ [ 2, 2, 2 ] ], 
  [ [ 3, 3, 3 ] ] ]

# HurwitzOrbitsRepresentatives( <rack>, <n> )
gap> r := DihedralRack(3);;
gap> HurwitzOrbitsRepresentatives(r, 3);
[ [ 1, 1, 1 ], [ 1, 1, 2 ], [ 1, 1, 3 ], [ 1, 2, 2 ], [ 2, 2, 2 ], 
  [ 3, 3, 3 ] ]

# HurwitzOrbitsRepresentativesWS( <rack>, <n> )
gap> r := DihedralRack(3);;
gap> SizesHurwitzOrbits(r, 3);
[ 1, 8 ]
gap> HurwitzOrbitsRepresentativesWS(r, 3);
[ [ [ 1, 1, 1 ], 1 ], [ [ 1, 1, 2 ], 8 ], [ [ 1, 1, 3 ], 8 ], 
  [ [ 1, 2, 2 ], 8 ], [ [ 2, 2, 2 ], 1 ], [ [ 3, 3, 3 ], 1 ] ]

# NrHurwitzOrbits( <rack>, <n>, <size> )
gap> r := DihedralRack(3);;
gap> NrHurwitzOrbits(r, 3, 8);
3

# SizesHurwitzOrbits( <rack>, <n> )
gap> r := TetrahedronRack();;
gap> SizesHurwitzOrbits(r, 3);
[ 1, 8, 12 ]

# TetrahedronRack()
gap> r := TetrahedronRack();;
gap> Display(r.matrix);
[ [  1,  3,  4,  2 ],
  [  4,  2,  1,  3 ],
  [  2,  4,  3,  1 ],
  [  3,  1,  2,  4 ] ]
gap> STOP_TEST( "manual.tst" );

#############################################################################
##
#E
