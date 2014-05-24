class TwoCocycle(SageObject):
    r"""
    A 2-cocycle object
    DATA:
        matrix
    """
    def __init__(self, data):
        self.size = len(data)
        self.matrix = data
        self.description = 'A 2-cocycle'

    def __repr__(self):
        return self.description

    def __call__(self, *args):
        i = args[0]
        j = args[1]
        return self.matrix[j][i]
        
def ConstantTwoCocycle(n, q):
    """
    Returns a constant 2-cocycle of size n 
    """
    return TwoCocycle([[q for _ in range(n)] for _ in range(n)])

class NicholsAlgebra(SageObject):
    r"""
    A Nichols algebra object
    DATA:
        rank            --
        diagonal_type   --
        weyl_groupoid   --
        rack            --
        q               --
        hilbert_series  --
        field           --

    """
    def __init__(self, field, rack, q):
        self.rack = rack
        self.rank = rack.size
        self.q = q
        self.field = field

    def __repr__(self):
        return 'Nichols algebra of rank %d' % self.rank

    def is_of_diagonal_type(self):
        pass

    def restricted_braiding(self, p, n):
        # p = [i,j]
        x = p[0]-1
        y = p[1]-1
        m = matrix(self.field, self.rank^n, self.rank^n)
        for i in range(1,self.rank^n+1):
            v = __number2vector__(i, n, self.rank)
            r = copy(v)
            r[x] = v[y]
            r[y] = self.rack(v[x],v[y])
            k = __vector2number__(r, self.rank)-1
            l = __vector2number__(v, self.rank)-1
            m[k,l] = m[k,l] + self.q[v[x]-1][v[y]-1]

        return m

    def print_relations(self, n):
        rels = gap(self.relations(n))
        print gap.eval('PrintNPList(%s);'%rels.name())

    def relations(self, n, verbose=False):
        """
        Returns relations in degree n in gbnp format 
        TODO: check if gbnp is installed

        """
        m = self.quantum_symmetrizer(n).transpose()
        k = m.kernel_matrix()
        r = []
        for i in [1..k.nrows()]:
            a = []
            b = []
            for j in [1..len(k[0])]:
                if k[i-1][j-1] != 0:
                    a.append(__number2vector__(j, n, self.rank))
                    b.append(k[i-1][j-1])

            r.append([a,b])

        if verbose:
            rels = gap(r)
            print gap.eval('PrintNPList(%s);'%rels.name())

        return r    

    def quantum_symmetrizer(self, n):
        """
        Returns the n-th quantum symmetrizer
        """
        if n == 2:
            return identity_matrix(self.field, self.rank^n)+self.restricted_braiding([1,2], n)

        p = []
        c = []
        m = identity_matrix(self.field, self.rank^n)
        for i in [1..n-1]:
            p.append([i,i+1])

        for i in [1..n-1]:
            c.append(self.restricted_braiding(p[n-i-1], n))

        for i in [1..n-1]:
            m = m+prod(c)
            c.pop(0)
        
        return m*identity_matrix(self.field, self.rank).tensor_product(self.quantum_symmetrizer(n-1))

    def __quantum_symmetrizer__(self, n):
        """
        Returns the n-th quantum symmetrizer
        Not recursive!
        """
        s = identity_matrix(self.field, self.rank^2)+self.restricted_braiding([1,2], 2)

        for j in [3..n]:

            p = []
            c = []
            m = identity_matrix(self.field, self.rank^j)
            for i in [1..j-1]:
                p.append([i,i+1])

            for i in [1..j-1]:
                c.append(self.restricted_braiding(p[j-i-1], j))

            for i in [1..j-1]:
                m = m+prod(c)
                c.pop(0)
       
            s = m*identity_matrix(self.field, self.rank).tensor_product(s)

        return s
   

    def dimension(self, n):
        """ 
        Returns the dimension of the Nichols algebra at degree n 
        """
        if n == 0:
            return 1
        if n == 1:
            return self.rank
        m = self.quantum_symmetrizer(n)
        return m.rank()

class NicholsAlgebraElement(SageObject):
    pass
