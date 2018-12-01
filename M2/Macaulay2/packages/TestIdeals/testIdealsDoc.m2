doc ///
    Key
        QGorensteinGenerator
        (QGorensteinGenerator, ZZ, Ring)
        (QGorensteinGenerator, Ring)
    Headline
        finds an element representing the Frobenius trace map of a Q-Gorenstein ring
    Usage
        QGorensteinGenerator(e, R)
        QGorensteinGenerator(R)
    Inputs
        e: ZZ
        R: Ring
    Outputs
        :RingElement
    Description
        Text
            Suppose that $R$ is a ring such that $(p^e-1)K_R$ is linearly equivalent to zero (for example, if $R$ is $Q$-Gorenstein with index not divisible by $p$).  Then if we write $R = S/I$ where $S$ is a polynomial ring, we have that $I^{[p^e]} : I = u S + I^{[p^e]}$ for some $u \in S$.  By Fedder's criterion, this element $u$ represents the generator of the $R^{1/p^e}$-module $Hom(R^{1/p^e}, R)$.  For example if $I = (f)$ is principal, then $u = f^{p^e-1}$ works.
        Text
            This function produces the element $f$ described above.  If do not specify an integer e, it assumes e = 1.
        Example
            S = ZZ/3[x,y,z];
            f = x^2*y - z^2;
            I = ideal(f);
            R = S/I;
            u = QGorensteinGenerator(1, R)
            u%I^3 == f^2%I^3
        Text
            If Macaulay2 does not recognize that $I^{[p^e]} : I / I^{[p^e]}$ is principal, an error is thrown.  Note in the nongraded case, Macaulay2 is not guaranteed to do this simplification.
///

doc ///
    Key
        testElement
        (testElement, Ring)
    Headline
        finds a test element of a ring
    Usage
        testElement(R)
    Inputs
        R: Ring
    Outputs
        :RingElement
    Description
        Text
            Given $R = S/I$ where $S$ is a polynomial ring, this finds an element of $S$ that restricts to a test element of $R$.  This does this by finding a minor of the Jacobian whose determinant is not in any minimal prime of the defining ideal of $R$.  It looks at random minors until one is found instead of computing all of them.  Thus it will not always produce the same answer.
        Example
            R = ZZ/5[x,y,z]/(x^3+y^3+z^3);
            testElement(R)
            testElement(R)
            testElement(R)
///

doc ///
    Key
        [testElement, AssumeDomain]
    Headline
        assumes the ring is a domain when finding a test element
    Description
        Text
            If {\tt AssumeDomain => true} then testElement doesn't have to compute the minimal primes of the ring.  This can result in a substantial speedup in some cases.  The default value is {\tt false}.
    SeeAlso
        testElement
///

doc ///
    Key
        [testIdeal, AssumeDomain]
        [testModule, AssumeDomain]
    Headline
        assume the ring is a domain
    Description
        Text
            Set {\tt AssumeDomain => true} during the step of finding a test element.  The default value is {\tt false}.
    SeeAlso
        [testElement, AssumeDomain]
///

doc ///
    Key
        AssumeDomain
    Headline
        an option to assume a ring is a domain
///        

doc ///
    Key
        testIdeal
        (testIdeal, Ring)
        (testIdeal, ZZ, RingElement)
        (testIdeal, QQ, RingElement)
        (testIdeal, ZZ, RingElement, Ring)
        (testIdeal, QQ, RingElement, Ring)
        (testIdeal, List, List)
        (testIdeal, List, List, Ring)
    Headline
        computes the test ideal of f^t in a Q-Gorenstein ring
    Usage
        testIdeal(t, f)
        testIdeal(t, f, R)
        testIdeal(Lexp, Lelts)
        testIdeal(Lexp, Lelts, R)        
    Inputs
        R: Ring
        t: QQ
        t: ZZ
        f: RingElement
        Lexp: List
        Lelts: List
    Outputs
        :Ideal
    Description
        Text
            Given a normal Q-Gorenstein ring $R$, passing the ring simply computes the test ideal $\tau(R)$.
        Example
            R = ZZ/5[x,y,z]/ideal(x^3+y^3+z^3);
            testIdeal(R)
        Example
            S = ZZ/5[x,y,z,w];
            T = ZZ/5[a,b];
            f = map(T, S, {a^3, a^2*b, a*b^2, b^3});
            R = S/(ker f);
            testIdeal(R)        
        Text
            Given a normal Q-Gorenstein ring $R$, a rational number $t \geq 0$ and a ring element $f \in R$, we can also compute the test ideal $\tau(R, f^t)$.
        Example
            R = ZZ/5[x,y,z];
            f = y^2 - x^3;
            testIdeal(1/2, f)
            testIdeal(5/6, f)
            testIdeal(4/5, f)
            testIdeal(1, f)
        Example
            R = ZZ/7[x,y,z];
            f = y^2 - x^3;
            testIdeal(1/2, f)
            testIdeal(5/6, f)
            testIdeal(4/5, f)
            testIdeal(1, f)
        Text
            It even works if the ambient ring is not a polynomial ring.
        Example
            R = ZZ/11[x,y,z]/ideal(x^2-y*z);
            f = y;
            testIdeal(1/2, f)
            testIdeal(1/3, f)
        Text
            Alternately, you can instead pass a list of rational numbers $\{t1, t2, ...\}$ and a list of ring elements $\{f1, f2, ...\}$.  In this case it will compute the test ideal $\tau(R, f1^{t1} f2^{t2} ...)$.
        Example
            R = ZZ/7[x,y];
            L = {x,y,(x+y)};
            f = x*y*(x+y);
            testIdeal({1/2,1/2,1/2}, L)
            testIdeal(1/2, f)
            testIdeal({2/3,2/3,2/3}, L)
            testIdeal(2/3, f)
            time testIdeal({3/4,2/3,3/5}, L)            
            time testIdeal(1/60, x^45*y^40*(x+y)^36)
        Text
            As above, frequently passing a list will be faster (as opposed to finding a common denominator and passing a single element) since the {\tt testIdeal} can do things in a more intelligent way for such a list.
///

    

doc ///
    Key
        [testIdeal, MaxCartierIndex]
        [isFregular, MaxCartierIndex]
    Headline
        sets the maximum Gorenstein index to search for when working with a Q-Gorenstein ambient ring
    Usage
        testIdeal(..., MaxCartierIndex=>N)
    Inputs
        N: ZZ
    Outputs
        :Ideal
    Description
        Text
            When working in a Q-Gorenstein ring, and computing the test ideal or whether a pair is F-regular, we find an $N$ such that $N * K_R$ is Cartier.  This option controls the maximum value of $N$ to consider.  The default value is $100$.  If you pass it a ring such that the smallest such $N$ is less that MaxCartierIndex, then the function will throw an error.  This value is ignored if the user specifies the option {\tt QGorensteinIndex}.
    SeeAlso
        [testIdeal, QGorensteinIndex]
///

doc ///
    Key
        [testIdeal, QGorensteinIndex]
        [isFregular, QGorensteinIndex]
    Headline
        specifies the Q-Gorenstein index of the ring
    Usage
        testIdeal(..., QGorenstein=>N)
    Inputs
        N: ZZ
    Outputs
        :Ideal
    Description
        Text
            When working in a Q-Gorenstein ring, and computing the test ideal or whether a pair is F-regular, we find an $N$ such that $N * K_R$ is Cartier.  This option lets the user skip this search if this integer $N$ is already known.  Specifying a value $> 0$ will mean that {\tt MaxCartierIndex} is ignored.
    SeeAlso
        [testIdeal, MaxCartierIndex]
///

doc ///
    Key
        QGorensteinIndex
    Headline
        an option used to specify the Q-Gorenstein index of the ring
    Description
        Text
            When working in a Q-Gorenstein ring frequently we must find an $N$ such that $N * K_R$ is Cartier.  This option lets the user skip this search if this integer $N$ is already known by setting QGorensteinIndex => N.
///

doc ///
    Key
        MaxCartierIndex
    Headline
        an option used to specify the maximum possible Cartier index of a divisor
    Description
        Text
            Some functions need to find the smallest value $N$ such that $N$ times a divisor is Cartier.  By specifying this value, the user controls what the maximal possible Cartier index to consider is.  
///


doc ///
    Key
        isFregular
        (isFregular, Ring)
        (isFregular, ZZ, RingElement)
        (isFregular, QQ, RingElement)
        (isFregular, List, List)
    Headline
        whether a ring or pair is strongly F-regular
    Usage
        isFregular(R)
        isFregular(t, f)
        isFregular(Lexp, Lelts)
    Inputs
        R: Ring
        t: QQ
        t: ZZ
        f: RingElement
        Lexp: List
        Lelts: List
    Outputs
        :Boolean
    Description
        Text
            Given a normal Q-Gorenstein ring $R$ (or a Gorenstein ring in general), this computes whether the ring is strongly F-regular.
        Example
            R = ZZ/5[x,y,z]/ideal(x^2+y*z);
            isFregular(R)
        Example
            R = ZZ/7[x,y,z]/ideal(x^3+y^3+z^3);
            isFregular(R)
        Text
            It can also do the same computation for a pair.
        Example
            R = ZZ/5[x,y];
            f = y^2-x^3;
            isFregular(1/2, f)
            isFregular(5/6, f)
            isFregular(4/5, f)
            isFregular(4/5-1/100000, f)
///

doc ///
    Key
        [isFregular, IsLocal]
    Headline
        controls whether F-regularity is checked at the origin or everywhere
    Usage
        isFregular(..., IsLocal=>b)
    Inputs
        b: Boolean
    Outputs
        :Boolean
    Description
        Text
            When checking whether a ring or pair is strongly F-regular, the default option is to check this everywhere.  If you set IsLocal=>true (default is false), it will only check this at the origin.
        Example
            R = ZZ/7[x,y,z]/ideal((x-1)^3+(y-2)^3+z^3);
            isFregular(R)
            isFregular(R, IsLocal=>true)
            S = ZZ/13[x,y,z]/ideal(x^3+y^3+z^3);
            isFregular(S)
            isFregular(S, IsLocal=>true)
        Text
            Here is an example of a pair.
        Example
            R = ZZ/13[x,y];
            f = (y-2)^2 - (x-3)^3;
            isFregular(5/6, f)
            isFregular(5/6, f, IsLocal=>true)
            g = y^2 - x^3;
            isFregular(5/6, g)
            isFregular(5/6, g, IsLocal=>true)
///    

doc ///
    Key
        isFpure
        (isFpure, Ring)
        (isFpure, Ideal)        
    Headline
        whether a ring is F-pure
    Usage
        isFpure(R)
        isFpure(I)
    Inputs
        R: Ring
        I: Ideal
    Outputs
        :Boolean
    Description
        Text
            Given a ring $R$, this computes whether the ring is F-pure using Fedder's criterion (by applying @TO frobeniusRoot@ to $I^{[p]} : I$).
        Example
            R = ZZ/5[x,y,z]/ideal(x^2+y*z);
            isFpure(R)
        Example
            R = ZZ/7[x,y,z]/ideal(x^3+y^3+z^3);
            isFpure(R)
        Example
            R = ZZ/5[x,y,z]/ideal(x^3+y^3+z^3);
            isFpure(R)
        Text
            Alternately, one may pass it the defining ideal of a ring.
        Example
            S = ZZ/2[x,y,z];
            isFpure(ideal(y^2-x^3))
            isFpure(ideal(z^2-x*y*z+x*y^2+x^2*y))
///

doc ///
    Key
        [isFpure, IsLocal]
    Headline
        controls whether F-purity is checked at the origin or everywhere
    Usage
        isFpure(..., IsLocal=>b)
    Inputs
        b: Boolean
    Outputs
        :Boolean
    Description
        Text
            When checking whether a ring F-pure, the default option is to check this everywhere.  If you set {\tt IsLocal=>true} (default is {\tt false}), it will only check this at the origin.  
        Example
            R = ZZ/5[x,y,z]/ideal((x-1)^3+(y-2)^3+z^3);
            isFpure(R)
            isFpure(R, IsLocal=>true)
            S = ZZ/13[x,y,z]/ideal(x^3+y^3+z^3);
            isFpure(S)
            isFpure(S, IsLocal=>true)
        Text
            Note there is a difference in the computation done here, and checking it everywhere can sometimes be faster than checking the origin.  If {\tt IsLocal=>false} then the function computes @TO frobeniusRoot@ applied to $I^{[p]} : I$, if {\tt IsLocal=>true} then the function checks wheter or not $I^{[p^e]} : I$ is contained in $m^{[p^e]}$ where $m$ is the maximal ideal generated by the variables.
///    
