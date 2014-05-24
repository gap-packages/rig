"""
Racks and quandles

This module implements racks and quandles

AUTHORS:
    -- Mat韆s Gra馻 (matiasg@dm.uba.ar)
    -- Leandro Vendramin (lvendramin@dm.uba.ar)


TODO:
    
 * agregar is_rack()
 * agregar __get_item__ para evitar tantos range
 * agregar quotient()
 * racks from union of conjugacy classes
 * rack category?
 * yd-group?
 * (twisted)homogeneous racks?
 * rank of a rack
 * nelson polynomials
 * labels, especialmente al calcular subracks
 * interface con RIG
 * subracks
 * subracks_up_to_iso
 * cohomolog韆 (racks y quandles)
 * coxeter racks
 * symplectic racks 
 * fundamental quandle of a knot

"""
def is_permutation(p):
    """
    Check if p is a well-defined permutation

    EXAMPLE::
        sage: Permutation([1,1])
        False

    """
    for i in range(1,len(p)+1):
        if not i in list(p):
            return False
    return True

#try:
#        g = PermutationGroupElement(list(p))
#        return True
#    except:
#        return False
#

#########################
### __vector2number__ ###
#########################
def __vector2number__(v, rank):
    """
    INPUT:
        v    -- vector of the form [x1,x2,...,xn]
                x1,x2,...,xn belong to {0,1,...,N}
        rank -- the number of variables 

    EXAMPLE: 
        sage: __vector2number__([0,0,0], 3)
        1
        sage: __vector2number__([0,0,1], 3)
        2
    """
    s = 0 
    for i in [1..len(v)]:
        if not v[i-1] in [1..rank]:
            return -1
        s = s + (v[i-1]-1)*(rank**(len(v)-i))
    return s+1

#########################
### __number2vector__ ###
#########################
def __number2vector__(i, n, rank):
    """
    INPUT:
        i    -- the number of the vector
        n    -- the size of the vector 
        rank -- the number of variables

    EXAMPLE:
        sage: n = __vector2number__([0,0,1], 5)
        sage: __number2vector__(n, 3, 5)==[0,0,1]
        True
    """
    
    if i > rank**n:
        return -1

    v = []
    x = i-1
    while x >= rank:
        y = x % rank
        v.append(y)
        x = (x-y)/rank

    v.append(x)
    #for i in  range(len(v),n):
    for i in [len(v)..n-1]:
        v.append(0)

    v.reverse()
    return [x+1 for x in v] 

#################################
### __check_rack_conditions__ ###
#################################
def __check_rack_conditions__(data):
   """
   Checks the rack conditions

   """
   n = len(data)
   for i in range(n):
       if not is_permutation(Permutation(data[i])):
           return false
   
   for i in [1..size]:
       for j in [1..size]:
           for k in [1..size]:
               pass
               #               if data(r(i,j),k) != r(r(i,k),r(j,k)):
               return false

   return true



#from sage.structure.sage_object import SageObject
##from sage.interfaces.chomp import CHomP

############
### Rack ###
############
class Rack(SageObject):
    r""" 
    Create the rack object.

    INPUT:

    DATA:
        size          -- number of elements of the rack
        permutations  -- list of permutations that defines the rack

    """
    def __init__(self, data, description=None, labels=None): 
        """
        INPUT:
            a matrix?
        """
        self.size = len(data[0]) 

        self.permutations = []
        for p in data:
            self.permutations.append(Permutation(p))

        ### Labels
        if labels == None:
            self.labels = [1..self.size]
        else:
            self.labels = labels

        ### Description
        if description == None:
            self.description = 'Rack of %d elements.' %self.size
        else:
            self.description = description

        self._inn = None
        self._aut = None

#        if not __check_rack_conditions__(self.permutations):
#            return None 
            

    def enveloping_group(self, orders=None):
        """
        Returns a GAP object with (some quotient of) the enveloping group of the rack.

        EXAMPLE::

            sage: r = DihedralRack(3)
            sage: e = r.enveloping_group()
            sage: e.Size()
            infinity

            sage: r = DihedralRack(4)
            sage: e = r.enveloping_group([2,2,2,2])
            sage: e.Size()
            8

        """
        gap.eval('F := FreeGroup(%d);'%self.size)
        gap.eval('gens := GeneratorsOfGroup(F);')
        gap.eval('rels := [];')

        rels = []

        for i in range(1,self.size+1):
            for j in range(1,self.size+1):
                gap.eval('Add(rels, gens[%d]*gens[%d]*Inverse(gens[%d]*gens[%d]));'%(i,j,j,self(i,j)))

        if orders:
            assert len(orders) == self.size
            for i in range(self.size):
                gap.eval('Add(rels, gens[%d]^%d);'%(i+1,orders[i]))

        gap.eval('G := F/rels;'%rels)
        return gap('G')
 
    def inverse(self):
        """
        Returns the inverse rack.

        EXAMPLE::
            sage: r = TetrahedronRack()
            sage: s = r.inverse()
            sage: r.isomorphism_to(s)
            [1, 2, 4, 3]

        """
        p = []
        for i in range(self.size):
            p.append([0 for _ in range(self.size)])
            for j in range(self.size):
                p[i][j] = self.permutations[i].index(j+1)+1
        return Rack(p)


    def is_isomorphic_by_permutation(self, other, p):
        """
        EXAMPLES:

            sage: r = DihedralRack(4)
            sage: r.is_isomorphic_by_permutation(r,[1,2,3,4])
            True

            sage: r.is_isomorphic_by_permutation(r,[3,2,1,4])
            True

            sage: r.is_isomorphic_by_permutation(r,[1,3,2,4]))
            False

        """

        if self.size != other.size:
            return False

        for i in [1..self.size]:
            for j in [1..self.size]: 
                s_ij = p[self(j,i)-1]
                r_ij = other(p[j-1],p[i-1])
                if s_ij != r_ij:
                    return False

        return True

    def hom(self, other):
        """
        Computes all rack morphism from 创self创 two 创other创.

        EXAMPLES::
            sage: 

        """
        l = [[0 for _ in range(self.size)]]
        o = []
        while len(l) != 0:
            w = l[0]
            l[0:1] = []  
            if w:
                if not 0 in w:
                    o.append(w)
                else:
                    i = w.index(0)+1
                    for j in range(1,other.size+1):
                        f = list(w)
                        f[i-1] = j
                        g = self.extend_morphism(other, f)
                        if g:
                            l.append(f)
        return o     

    def isomorphism_to(self, other):
        """
        Returns (if exists) the isomorphism between the racks
        EXAMPLES:
            sage: r = RackFromGAP(SymmetricGroup(6),(1,2))
            sage: s = RackFromGAP(SymmetricGroup(6),(1,2)(3,4)(5,6))
            sage: r.isomorphism_to(s)
            [1, 5, 14, 3, 9, 10, 4, 12, 13, 8, 2, 15, 7, 11, 6]
 
        """
        if self.size != other.size:
            return False

        b = self.minimal_generating_subset()

        for f in Combinations(range(1,self.size+1), len(b)):
            for s in Permutations(f).list():
                p = [0 for x in range(self.size)]
                for i in range(len(b)):
                    p[b[i]-1] = s[i]
                q = self.extend_morphism(other, p)
                if q != False and is_permutation(q) == True:
                    if self.is_isomorphic_by_permutation(other, q) == True:
                        return q

    def extend_morphism(self, other, f):
        """
        Extend (if possible) a given function to a morphism of racks.

        EXAMPLES::

            sage: r = DihedralRack(5)
            sage: r.extend_morphism(r, [1,2,3,4,0])
            [1, 2, 3, 4, 5]
            sage: r.extend_morphism(r, [1,0,0,3,2])
            [1, 5, 4, 3, 2]

        """
        c = True
        d = True
        while c == True:
            c = False
            for i in range(1,self.size+1):
                for j in range(1,self.size+1):
                   if f[i-1] !=0 and f[j-1] != 0:
                        if f[self(i,j)-1] == 0: 
                            f[self(i,j)-1] = other(f[i-1],f[j-1])
                            c = True
                        elif f[self(i,j)-1] != 0 and f[self(i,j)-1] != other(f[i-1],f[j-1]):
                            d = False
                            c = False
        if d == True: 
           return f
        else:
           return d

    def table(self, side='Right', use_labels=False):
        """
        side == 'Right' is for topology (see Nelson). This function returns 
        the table (list of list) of a rack. 
        Notice that RiG uses side == 'Left'. 

        """
        m = []
        for y in range(self.size):
            m.append([0 for x in range(self.size)])

        if side == 'Right':
            for i in range(self.size):
                for j in range(self.size):
                    m[i][j] = self.permutations[j][i]
        else:
            for i in range(self.size):
                for j in range(self.size):
                    m[j][i] = self.permutations[j][i]

        return m
 

    def matrix(self, side='Right'):
        """
        EXAMPLES::

            sage: r = DihedralRack(3)
            sage: r.table()
        """
        return matrix(self.table(side))

    def canonical_subrack(self, subset):
        """
        Returns the subrack generated by <subset>

        EXAMPLE:
            sage: r = DihedralRack(8)
            sage: s = r.canonical_subrack([0,2])
            sage: s
            Rack of 4 elements.

        """
        tmp = subset
        for i in tmp:
            for j in tmp:
                ij = self(i,j)
                if not ij in tmp:
                    tmp.append(ij)

        size = len(tmp)
        tmp.sort()
        
        p = []
        for x in range(size):
            p.append(Permutation([tmp.index(z)+1 for z in [self(tmp[y],tmp[x]) for y in range(size)]]))

        ### FIX: labels!
        return Rack(p,labels=tmp)


    def minimal_generating_subset(self):
        """
        Returns a minimal generating subset of the rack.

        EXAMPLES:

            sage: r = DihedralRack(5)
            sage: r.minimal_generating_subset()
            [0, 1]

            sage: r = TrivialRack(4)
            sage: r.minimal_generating_subset()
            [0, 1, 2, 3]

            sage: r = PermutationRack(4)
            sage: r.minimal_generating_subset()
            [0]

        """
        for k in range(1,self.size+1):
            for c in Combinations(range(1,self.size+1), k):
                tmp = copy(c)
                for i in tmp:
                    for j in tmp:
                        # remember: ji = i<j
                        ij = self(i,j)      
                        if not ij in tmp:
                            tmp.append(ij)
                if len(tmp) == self.size:
                    return c

    def is_faithful(self):
        """
        Checks if the rack is faithful.
        
        EXAMPLES::

            sage: r = DihedralRack(4)
            sage: r.is_faithful()
            False

            sage: r = DihedralRack(3)
            sage: r.is_faithful()
            True

        """
        s = []
        for p in self.permutations:
            if not p in s:
                s.append(p)
            else:
                return False
        return True

    def braided_orbit(self, v):
        """
        The braided orbit: (i,j) --> (j,i<j)
        """
        l = []
        while not v in l:
            l.append(v)
            i = v[0]
            j = v[1]
            v = [j, self(i,j)]
        return l    

    def braided_representatives(self):
        """
        Returns the list of representatives under the braided action
        """
        reps = []
        tmp = []
        for i in [1..self.size]:
            for j in [1..self.size]:
                orb = self.braided_orbit([i,j])
                if [x for x in tmp if x in orb] == []:
                    tmp.append(orb[0])
                    reps.append([orb[0], len(orb)])
        return reps

    def braided_k(self, n):
        """
        ### k(rack,n) is the total number of j such that the orbit of 
        ### (1,j) has length n.
        """
        m = 0
        for j in [1..self.size]:
            if len(self.braided_orbit([1,j])) == n:
                m = m+1
        return m        

    def braided_l(self, n):
        """
        Returns the number of braided orbits of size n
        TODO: self needs to be of group-type
        """
        return self.size*self.braided_k(n)/n

    def direct_product(self, other):
        """
        Returns the direct product of self and other

        EXAMPLE::
            sage: r = dihedral_rack(3)
            sage: s = trivial_rack(2)
            sage: t = r.direct_product(s)
            sage: t.matrix()
            [1 1 5 5 3 3]
            [2 2 6 6 4 4]
            [5 5 3 3 1 1]
            [6 6 4 4 2 2]
            [3 3 1 1 5 5]
            [4 4 2 2 6 6]

        """
        c = CartesianProduct([1..self.size], [1..other.size])
        p = []

        for i in [1..self.size*other.size]:
            p.append([0 for z in [1..other.size*self.size]])

        for i in enumerate(c):
            for j in enumerate(c):
                tmp = [self(i[1][0],j[1][0]), other(i[1][1],j[1][1])]
                p[j[0]][i[0]] = c.list().index(tmp)+1; 

        des = 'Direct product of %s and %s'%(self, other)
        return Rack(p, description=des)

    def braiding(self):
        """
        Returns the matrix of the braiding associated to the rack self

        EXAMPLES::

            sage: r = DihedralRack(3)
            sage: c = r.braiding()
            sage: s = c.tensor_product(identity_matrix(3))
            sage: t = (identity_matrix(3)).tensor_product(c)
            sage: s*t*s==t*s*t
            True

        """
        m = matrix(ZZ, self.size^2, self.size^2)
        for i in range(1,self.size^2+1):
            v = __number2vector__(i, 2, self.size)
            r = copy(v)
            r[0] = v[1]
            r[1] = self(v[0],v[1])
            k = __vector2number__(r, self.size)-1
            l = __vector2number__(v, self.size)-1
            m[k,l] = m[k,l] + 1
        return m

    def nr_components(self):
        """
        Return the number of $inn(X)$-orbits of the rack.

        EXAMPLE::

            sage: r = TrivialRack(5)
            sage: r.nr_components()
            5

        """
        return len(self.orbits())

    def inner_group(self):
        """
        Compute the inner group of the rack (the group generated by the permutations of the rack)

        EXAMPLES::

            sage: r = DihedralRack(3)
            sage: r.inner_group()
            Permutation Group with generators [(2,3), (1,2), (1,3)]

        """
        if self._inn == None:
            self._inn = PermutationGroup(self.permutations)
        return self._inn    

    def permutation(self, i):
        """ 
        Returns the permutation resulting from the rack action of i
        TODO: usar un diccionario para la lista de permutaciones

        EXAMPLES::
            sage: r = dihedral_rack(3)
            sage: r.permutation(1)
            [1, 3, 2]
            sage: r.permutation(2)
            [3, 2, 1]
            sage: r.permutation(3)
            [2, 1, 3]

        """
        return self.permutations[i-1]

    def boundary_map(self, n, transpose=False):
        """
        Returns the n-th boundary map d : X^(n+1) --> X^n.
    
        TODO:

        INPUT:
            rack --
            n    --
    
        EXAMPLES:
            sage:

        """
        if n<0: return 0
        m = matrix(self.size**n, self.size**(n+1))
        for i in range(0,(self.size**(n+1))):
            u = __number2vector__(i+1, n+1, self.size)
            for j in range(0,n+1):
                v = copy(u)
                v.pop(j)
                w = [self(x,u[j]) for x in u[0:j]] + u[j+1:len(u)]
                a = __vector2number__(v, self.size)-1
                b = __vector2number__(w, self.size)-1
                m[a,i] = m[a,i] + (-1)**(j+1)
                m[b,i] = m[b,i] + (-1)**(j)

        if transpose:
            return m.transpose()
        else:
            return m

    def second_cohomology_torsion_generators(self):
        """ 
        Returns the generators of the 2nd cohomology group (over ZZ) of the rack
        NOTE: works only for characteristic 0
        """
        
        t = self.torsion(2, generators=True)
        gens = []

        for x in range(len(t[0])):
            q = [[gap('E(%d)^%d;'%(t[0][x],t[1][x][i+self.size*j])) for i in range(self.size)] for j in range(self.size)]
            gens.append(q) 

        return gens

    def cayley_graph(self, subset):
        """
        Returns the directed weighted Cayley multigraph of the rack
        """

        e = {}
        for i in range(1,self.size+1):
            e[i] = {}

        for s in subset:
            for i in range(1,self.size+1):
                e[i][self(i,s)] = []
                e[i][self(i,s)].append('%d'%s)

        return DiGraph(e)


    def automorphism_group(self, direct=True):
        """
        Computes the automorphism group of a rack.
        INPUT::
            direct

        EXAMPLES::

            sage: r = DihedralRack(4)
            sage: r.automorphism_group()
            Permutation Group with generators [(), (2,4), (1,2)(3,4), (1,2,3,4), (1,3), (1,3)(2,4), (1,4,3,2), (1,4)(2,3)]

        """
        if self._aut:
            return self._aut

        # Direct computation of the automorphism group
        if direct:
            aut = []
            for f in self.hom(self):
                if is_permutation(f):
                    aut.append(f)
            return PermutationGroup(aut)        

        gens = []
        b = self.minimal_generating_subset()
#       for f in Combinations(range(1,self.size+1), len(b)):
        ci = combinations_iterator(range(1,self.size+1), len(b))
        for f in ci:
            pi = permutations_iterator(f)
#            for s in Permutations(f).list():
            for s in pi:
                p = [0 for x in range(self.size)]
                for i in range(len(b)):
                    p[b[i]-1] = s[i]

                q = self.extend_morphism(self, p)
                if q != False:
                    if is_permutation(q) == True:
                        gens.append(q)

        self._aut = PermutationGroup(gens)
        return self._aut 

    def is_homogeneous(self):
        """ 
        Returns True if the automorphism group of the rack acts transitively in [1..n]

        """
        return self.automorphism_group().is_transitive()

    def chain_complex(self, n):
        r"""
        Returns the rack chain complex from degree 0 to degree n
        WARNING: no funciona!

        EXAMPLE::
            sage: r = TetrahedronRack()
            sage: C = r.chain_complex(2)
            sage: C.homology(1)
            Z x C2

        """
        d = dict([(k,self.boundary_map(k)) for k in [1,n]])
        C = ChainComplex(d, degree=-1)
        return C

    def homology(self, n):
        """
        Return the <n> rack homology group of <rack>
        TODO: this function is slower than mine!
    
        INPUT:
            rack --
            n    --
            ring --
    
        EXAMPLES::


        TODO: alternativa con ChainComplex 
            sage: d = dict([(i,r.boundary_map(i)) for i in [0,1,2,3]])
            sage: C = ChainComplex(d, degree=-1)

        """

        a = self.boundary_map(n-1, transpose=False)

        # computes the smith normal form of this boundary 
        b = self.boundary_map(n, transpose=False).smith_form()[0]

        # null columns of the matrix a, the (n-1)-th boundary map
        M = self.size^n-a.rank();

        # non-zero rows of the matrix b, the n-th boundary map
        m = b.rank()

        # keep the elements of the diagonal that are > 1
        t = [b[i,i] for i in range(0,min(b.nrows(),b.ncols())) if b[i,i]>1]

        return [M-m, t];

    def betti(self, n):
        """
        Returns the n-th Betti number of the rack

        EXAMPLES::
            sage: r = TetrahedronRack()
            sage: r.betti(2)
            1

        """
        a = self.boundary_map(n-1, transpose=False)
        b = self.boundary_map(n, transpose=False)
        return self.size^n-a.rank()-b.rank()

    def torsion(self, n, generators=False):
        """ 
        Returns the torsion part of the n-th homology of the rack

        EXAMPLES::
            sage: r = TetrahedronRack()
            sage: r.torsion(2, generators=True)
            [[2], [[0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0]]]

        """
        
        a = self.boundary_map(n-1)
        b = self.boundary_map(n).smith_form()

        # s is the Smith normal form of the n-th boundary map
        s = b[0]
        r = b[1].transpose() 
        c = b[2]

        # non-zero rows of the matrix b, the n-th boundary map
        M = self.size^n-a.rank()
        m = s.rank()
 
        if generators:
            t = [i for i in range(min(s.nrows(),s.ncols())) if s[i,i]>1]
            q = []
            g = []
            for x in t:
                q = [0 for _ in range(self.size^2)]
                tmp = list(r.column(x))
                for i in range(len(tmp)):
                    q[i] = tmp[i] % s[x,x]
                g.append(q)
            return [[s[i,i] for i in range(min(s.nrows(),s.ncols())) if s[i,i]>1], g]
        else:
            return [s[i,i] for i in range(min(s.nrows(),s.ncols())) if s[i,i]>1]

    def subracks_up_to_iso(self):
        pass

    def subracks(self, n):
        pass

    def subrack(self, subset):
        pass

    def orbit(self, i):
        """
        Return the orbit of the element <i> under the rack action

        INPUT:
            i   -- the element of the rack

        EXAMPLES::

            sage: r = DihedralRack(4)
            sage: r.orbit(1)
            [1, 3]

            sage: r = CyclicRack(3)
            sage: r.orbit(1)
            [1, 2, 3]

        """
        return self.inner_group().orbit(i)
    
    def orbits(self):
        """
        Returns the $inn(X)$-orbits of the rack.

        EXAMPLE::

            sage: r = DihedralRack(4)
            sage: r.orbits()
            [[1, 3], [2, 4]]

        """
        return self.inner_group().orbits()

    def is_indecomposable(self):
        """
        Checks if the rack is indecomposable.

        EXAMPLE::

            sage: r = DihedralRack(4)
            sage: r.is_indecomposable()
            False

            sage: r = DihedralRack(3)
            sage: r.is_indecomposable()
            True 

        """
        return self.inner_group().is_transitive()

    def is_decomposable(self):
        """
        Checks if the rack is decomposable.

        EXAMPLE::

            sage: r = DihedralRack(4)
            sage: r.is_decomposable()
            True

            sage: r = DihedralRack(3)
            sage: r.is_decomposable()
            False

        """
        return not self.is_indecomposable()

    def __call__(self, *args):
        """
        Returns the elements i<j of the rack.

        EXAMPLES::

            sage: r = TrivialRack(4)
            sage: r(1,1)
            1
            sage: r(2,3)
            2
            sage: r = DihedralRack(5)
            sage: # the elements 3=1<2
            sage: r(1,2) 
            3
        """
        i = args[0]
        j = args[1]
        return self.permutations[j-1][i-1]

    def __getitem__(self, *args): 
        pass

    def __check__(self):
        """
        Checks the rack conditions

        """
        for i in range(self.size):
            p = self.permutations[i]
            if not is_permutation(Permutation(self.permutations[i])):
                return false
            
        for i in [1..self.size]:
            for j in [1..self.size]:
                for k in [1..self.size]:
                    if r(r(i,j),k) != r(r(i,k),r(j,k)):
                        return false

        return true

    def __cmp__(self, other):
        """
        Return true if and only if this rack is the same as other: that is if
        and only if the matrices of the two are the same.
        
        """
        pass

    def extension(self, group, f=None):
        """ 
        This method is for computing extension of racks. Let X be a rack, A be
        an abelian group and f:XxX->A be a function 
        
        (a,x)<(b,y)=(af(x,y),x<y)

        defines a rack structure en AxX if and only if f is a 2-cocycle. 

        EXAMPLES::

            sage: r = dihedral_rack(3)
            sage: s = r.extension(CyclicPermutationGroup(2))
            sage: s.matrix()
            [1 3 2 1 3 2]
            [3 2 1 3 2 1]
            [2 1 3 2 1 3]
            [4 6 5 4 6 5]
            [6 5 4 6 5 4]
            [5 4 6 5 4 6]

            sage: r = trivial_rack(2)
            sage: s = r.extension(CyclicPermutationGroup(2), [[0,1],[1,0]])
            sage: s.matrix()
            [1 3 1 3]
            [4 2 4 2]
            [3 1 3 1]
            [2 4 2 4]

            sage: f = [[0,1,1],[0,0,1],[0,0,0]]
            sage: t = trivial_rack(3)
            sage: r = t.extension(CyclicPermutationGroup(2), f)
            sage: r.matrix()
            [1 4 4 1 4 4]
            [2 2 5 2 2 5]
            [3 3 3 3 3 3]
            [4 1 1 4 1 1]
            [5 5 2 5 5 2]
            [6 6 6 6 6 6]

            sage: # reference: arXiv:010702
            sage: f = [[0,0,1,1],[1,0,0,1],[1,0,0,1],[1,1,0,0]]
            sage: r = dihedral_rack(4)
            sage: s = r.extension(CyclicPermutationGroup(2), f)
            sage: s.matrix()
            [1 3 5 7 1 3 5 7]
            [8 2 4 6 8 2 4 6]
            [7 1 3 5 7 1 3 5]
            [6 8 2 4 6 8 2 4]
            [5 7 1 3 5 7 1 3]
            [4 6 8 2 4 6 8 2]
            [3 5 7 1 3 5 7 1]
            [2 4 6 8 2 4 6 8]

        """
        p = []
        n = group.order()
        gap.eval('G := Elements(%s);'%group._gap_())

        for a in [1..n]:
            for x in [1..self.size]:
                p.append([0 for z in [1..n*self.size]])

        for a in [1..n]:
            for x in [1..self.size]:
                for y in [1..self.size]:
                    c = int(gap('Position(G, G[%d]*G[%d]);'%(a,f[x-1][y-1]+1)))
                    #c = int(gap('Position(G, G[%d]);'%(a)))
                    z = self(x,y)
                    for b in [1..n]:
                        p[self.size*(b-1)+y-1][self.size*(a-1)+x-1] = self.size*(c-1)+z

        des = 'An extension of %s and %s'%(group, self)
        return Rack(p, description=des)

    def is_quandle(self):
        """
        Check if the rack is a quandle

        EXAMPLES::

            sage: r = CyclicRack(4)
            sage: r.is_quandle()
            False

            sage: s = DihedralRack(5)
            sage: s.is_quandle()
            True

        """
        for i in [1..self.size]:
            if self(i,i) != i:
                return False 

        return True

    def s(self, x, y):
        """ 
        Returns (if possible) an element of the inner group (as a GAP object)
        that connects x and y

        EXAMPLES::    
            sage: r = dihedral_rack(3)
            sage: r.s(1,2)
            (1,2,3)

            sage: r = dihedral_rack(4)
            sage: r.s(1,2)
            fail

        """
        inn = self.inner_group()
        return gap('RepresentativeAction(%s,%s,%s);'%(inn._gap_(), x, y))

    def is_crossed_set(self):
        """
        Is the rack a crossed set?

        EXAMPLE::

            sage: r = Rack([[1,2,3],[1,2,3],[2,1,3]])
            sage: r.is_quandle()
            True
            sage: r.is_crossed_set()
            False

        """
        if self.is_quandle() == False:
            return False
        else:
            for i in [1..self.size]:
                for j in [1..self.size]:
                    if self(i,j)==i and self(j,i) != j:
                        return false 
            return true

    def center(self):
        """ 
        The center of the rack

        EXAMPLE::
            sage: r = trivial_rack(5)
            sage: r.center()
            [1, 2, 3, 4, 5]
        """
        z = []
        for i in [1..self.size]:
            add = True
            for j in [1..self.size]:
                if self(i,j)!=i or self(j,i)!=j:
                    add = False
                    break
            if add:
                z.append(i)
        return z        

    def _repr_(self):
        return self.description

#################
### core_rack ###
#################
def core_rack(group, method=0):
    """
    The core rack of a group is given by x<y=xy^{-1}x
    OPTIMIZAR
    """
    p = []
    if method == 0:
        n = group.order()
        for x in [1..n]:
            p.append([0 for z in [1..n]])
            for y in [1..n]:
                gap.eval('G := Elements(%s);'%group._gap_())
                gap.eval('i := Position(G, G[%d]);'%x)
                gap.eval('j := Position(G, G[%d]);'%y)
                k = gap('Position(G, G[%d]*Inverse(G[%d])*G[%d]);'%(x,y,x))
                p[x-1][y-1] = int(k)

    if method == 1:
        l = list(group)
        for x in l:
            p.append([z+1 for z in [l.index(x*y^(-1)*x) for y in l]])
    
    des = 'Core rack associated to the group %s' %group
    return Rack(p, description=des)

########################
### conjugation_rack ###
########################
def conjugation_rack(group, n=1):
    """ 
    The n-conjugation rack 
    OPTIMIZAR
    """
    l = list(group)
    p = []
    for x in l:
        p.append([z+1 for z in [l.index(x^(-1)*y*x) for y in l]])
    des = '%d-folded conjugation rack associated to %s' %(n,group)
    return Rack(p, description=des)

####################
### trivial_rack ###
####################
def trivial_rack(n):
    """
    Returns the trivial (or abelian) rack: i<j=i

    EXAMPLES::

        sage: TrivialRack(5)

    """
    p = []
    for x in range(n):
         p.append(Permutation([z+1 for z in [y%n for y in range(n)]]))
    des = 'Trivial rack with %d elements.' %n
    return Rack(p, description=des)

####################
### abelian_rack ###
####################
def abelian_rack(n):
    return trivial_rack(n)

#####################
### dihedral_rack ###
#####################
def dihedral_rack(n):
    p = []
    for x in range(n):
        #p.append(Permutation([z+1 for z in [(2*x-y)%n for y in range(n)]]))
        p.append([z+1 for z in [(2*x-y)%n for y in range(n)]])
    des = 'Dihedral rack with %d elements.'%n
    return Rack(p, description=des)

######################
### alexander_rack ###
######################
def alexander_rack(t,s,n):
    """
    Constructs the Alexander rack over integers mod n
    given by i<j=ti+sj(mod n) if s(t+s-1)=0(mod n)

    """
    p = []
    if (s*(t+s-1))%n != 0:
        return False

    for y in range(n):
        p.append([z+1 for z in [(t*x+s*y)%n for x in range(n)]])
    des = '(%d,%d)-Alexander rack with %d elements.'%(t,s,n)
    return Rack(p, description=des)

#########################
### alexander_quandle ###
#########################
def alexander_quandle(t,n):
    return alexander_rack(t,1-t,n)

###################
### cyclic_rack ###
###################
def cyclic_rack(n):
    p = []
    for x in range(n):
        #p.append(Permutation([z+1 for z in [(y+1)%n for y in range(n)]]))
        p.append([z+1 for z in [(y+1)%n for y in range(n)]])
    des = 'Cyclic rack with %d elements.' %n 
    return Rack(p, description=des)
    
########################
### permutation_rack ###
########################
def permutation_rack(pi,n):
    p = []
    for i in range(n):
        p.append([0 for _ in range(n)])    
        for j in range(n):
            p[i][j] = pi[j]

    des = 'Permutation %s-rack of %d elements.'%(pi,n)
    return Rack(p, description=des)
    
########################
### tetrahedron_rack ###
########################
def tetrahedron_rack():
    return Rack([[1, 3, 4, 2], [4, 2, 1, 3], [2, 4, 3, 1], [3, 1, 2, 4]])

##########################
### affine_simple_rack ###
##########################
def affine_simple_rack(q, k):
    """
    Returns the affine simple rack associated to the finite field GF(q) and 
    the action given by the multiplication by Z(q)^k

    EXAMPLES::
        sage: r = affine_simple_rack(5,1)

    """
    p = []
    s = 'GF(%d)'%q
    f = gap(s)
    l = list(f.AsList())
    z = f.PrimitiveElement()^k
    for x in l:
        p.append([0 for _ in range(q)])
        for y in l:
            i = l.index(x)
            j = l.index(y)
            p[i][j] = l.index((f.One()-z)*x+z*y)+1

    return Rack(p);

###################
### RackFromGAP ###
###################
def RackFromGAP(group, g):
    """
    Returns the rack given by the conjugacy class of g in group 
    TODO:
    """
    gap.eval('e := Elements(ConjugacyClass(%s,%s));'%(group,g))
    n = int(gap('Size(e);'))
    p = []

    for i in range(n): 
        p.append([0 for _ in range(n)])    
        for j in range(n):
            p[i][j] = int(gap('Position(e,e[%d]*e[%d]*Inverse(e[%d]));'%(i+1,j+1,i+1)))

    des = 'Rack of %d elements associated to the class of %s in %s.'%(n,g,group)
    lab = list(gap('e'))
    return Rack(p, description=des, labels=lab)
 
###################################
### rack_from_conjugacy_classes ###
###################################
#def rack_from_conjugacy_classes:
#    pass

################################
### check_2cocycle_condition ###
################################
def check_2cocycle_condition(rack, q):
    """ 
    Checks the 2-cocycle condition.
    Let (X,*) be a rack. Then q is a 2-cocycle if and only if 
    q(x,z)*q(x*z,y*z)=q(x*y,z)*q(x,y) for all x,y,z in X.

    """
        
    for i in range(rack.size):
        for j in range(rack.size):
            for k in range(rack.size):
                if q[i][k]*q[rack(i+1,k+1)-1][rack(j+1,k+1)-1] != q[i][j]*q[rack(i+1,j+1)-1][k]:
                    return false

    return true            

def are_homologous(rack, q1, q2):
    """
    Returns True if the cicles q1 and q2 are homologous and False otherwise

    EXAMPLES::

        sage: q2 = [1,1,1,1,1,1,1,1,1]
        sage: q1 = [1,0,1,0,1,0,0,0,1]  
        sage: r = DihedralRack(3)
        sage: are_homologous(r,q1,q2)
        True

        sage: q1 = [1 for _ in range(100)]
        sage: q2 = [
        1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 
        0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 
        0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 
        0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 
        0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 
        0, 0, 0, 1, 1, 1, 0, 0, 1, 0, 
        0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 
        0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 
        0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
        sage: perms = [ 
        [ 1, 3, 2, 5, 4, 6, 8, 7, 9, 10 ], 
        [ 3, 2, 1, 6, 5, 4, 9, 8, 7, 10 ], 
        [ 2, 1, 3, 4, 6, 5, 7, 9, 8, 10 ], 
        [ 5, 6, 3, 4, 1, 2, 10, 8, 9, 7 ], 
        [ 4, 2, 6, 1, 5, 3, 7, 10, 9, 8 ], 
        [ 1, 4, 5, 2, 3, 6, 7, 8, 10, 9 ], 
        [ 8, 9, 3, 10, 5, 6, 7, 1, 2, 4 ], 
        [ 7, 2, 9, 4, 10, 6, 1, 8, 3, 5 ], 
        [ 1, 7, 8, 4, 5, 10, 2, 3, 9, 6 ], 
        [ 1, 2, 3, 7, 8, 9, 4, 5, 6, 10 ] ]
        sage: r = Rack(perms)   
        sage: are_homologous(r,q1,q2)
        False

    """
    n = 2 
    a = rack.boundary_map(n-1)
    b = rack.boundary_map(n).smith_form()

    s = b[0]
    r = b[1].transpose() 
#    c = b[2]

    t = [i for i in range(min(s.nrows(),s.ncols())) if s[i,i]>1]
    for x in t:
        tmp = list(r.column(x))
        for i in range(len(tmp)):
            if q1[i]-q2[i] % s[x,x] != 0:
                return false

    return true
    
###############
### example ### 
###############
def example(p, a):
    """
    returns the indecomposable rack (3.3) given in [G].
    """
    pass
#    c = CartesianProduct([0..p-1], [0..p-1])
#    m = []
#
#    for i in [1..p^2]:
#        m.append([0 for z in [1..p^2]])
#
#    for y in range(n):
#        p.append([z+1 for z in [(t*x+(1-t)*y)%n for x in range(n)]])
#    des = '(%d,%d)-Alexander rack with %d elements.'%(t,s,n)
#    return Rack(p, description=des)
#
#
#    for i in c:
#        for j in c:
#            tmp = [( (1-a)*j[1]+a*i[1]+i[0]-j[0] ) % p, ((1-a)*i[0]+a*j[1] ) % p ]
#            m[j[0]][i[0]] = c.list().index(tmp)+1; 
#
#    des = '(3.3)'
#    return Rack(m, description=des)

def natural_2cocycle(rack, i, j):
    if rack.is_decomposable():
        return 

    s = rack.s(1,i)
    G = rack.inner_group()
    H = gap('Stabilizer(%s, %s);'%(G._gap_(), 1))
    p = rack.permutation(j).to_permutation_group_element()
    g = gap('%s*%s*%s;'%(s, p, rack.s(1,rack(i,j)).Inverse()))
    return g

