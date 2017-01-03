-- -*- coding: utf-8 -*-
newPackage(
	"ReactionNetworks",
    	Version => "1.0", 
    	Date => "June, 2016",
    	Authors => {
	     {Name => "Anton Leykin", Email => "doe@math.uiuc.edu"},
	     {Name => "Timothy Duff", Email => "doe@math.uiuc.edu"},
	     {Name => "Kisun Lee", Email => "doe@math.uiuc.edu"},
	     {Name => "Cvetelina Hill", Email => "doe@math.uiuc.edu"}
	     },
    	HomePage => "http://www.math.uiuc.edu/~doe/",
    	Headline => "Reaction networks",
	PackageImports => {"Graphs"},
	AuxiliaryFiles => true, -- set to true if package comes with auxiliary files
    	DebuggingMode => true		 -- set to true only during development
    	)

-- Any symbols or functions that the user is to have access to
-- must be placed in one of the following two lists

export {"reactionNetwork", 
    "ReactionNetwork", 
    "Species", 
    "Complexes", 
    "ReactionRing", 
    "NullSymbol", 
    "NullIndex", 
    "ReactionGraph",
    "stoichiometricSubspace", 
    "stoichSubspaceKer", 
    "createRing", 
 --   "ParameterRing",
    "steadyStateEquations", 
    "conservationEquations",  
    "FullEdges", 
    "NullEdges", 
    "glue",
    "displayComplexes", 
    "isDeficient", 
    "isWeaklyReversible",
    "injectivityTest", 
    "InitialValues",
    "ReactionRates",
    "ConcentrationRates",
    "specializeReactionRates", 
    "specializeInitialValues", 
    "createReactionRates", 
    "createInitialValues",
    "createConcentrationRates",
    "stoichiometricMatrix",
    "reactionMatrix",
    "reactantMatrix",
    "negativeLaplacian" --, "netComplex", "networkToHRF", "kk"
    }
exportMutable {}

-- helper functions for string parsing: better to move these and other non-exports to bottom of file?

removeWhitespace = s -> s = replace(" ", "", s)

-- returns species component of a summand

stripCoef = (s) -> (
    i := 0;
    while regex("[0-9]", s#i) =!= null do i = i+1;
    substring(i,length(s),s)
    )


-- returns coefficient component of a summand
specProportion = (s) -> (
    i := 0;
    while regex("[0-9]", s#i) =!= null do i = i+1;
    value substring(0,i,s)    
    )

-- removes any equationally redundant null symbols from reaction string in HR format
repairReaction = (r, nsym) -> (
    l := select(separateRegexp("\\+", removeWhitespace(r)), s -> s != nsym); 
    rr := l#0;
    for i from 1 to length(l)-1 do (
	if match("-|>", last l#(i-1)) then r = concatenate(rr,l#i) else rr = concatenate(rr,concatenate("+", l#i));
    );
    rr
    )

-- todo: add functionality for different delimiters

ReactionNetwork = new Type of MutableHashTable

-- todo: 1) other types of input (eg. stoichiometry matrix)
-- 3) check BNF w/ control people, ask about default nullsymbol

reactionNetwork = method(TypicalValue => ReactionNetwork, Options => {NullSymbol => ""})
reactionNetwork String := String => o -> str -> reactionNetwork(separateRegexp(",", str), o)
reactionNetwork List := String => o -> rs -> (
    Rn := new ReactionNetwork from {Species => {}, Complexes => {}, ReactionGraph => digraph {}, 
	NullSymbol => o.NullSymbol, NullIndex => -1, ReactionRing => null, 
	ReactionRates => null, InitialValues => null, ConcentrationRates => null};
    scan(rs, r -> addReaction(r,Rn));
    Rn
    )

TEST ///
restart
needs "ReactionNetworks.m2"
needsPackage "Graphs"
NN = reactionNetwork("A --> 2B, A + C --> D, D --> 0", NullSymbol => "0")
NN.Complexes
NN.NullSymbol
NN.ReactionGraph
R = createRing(NN, QQ)
createRing(NN, RR)
createRing NN
///

createReactionRates = method()
createReactionRates ReactionNetwork := Rn -> (
    kk := symbol kk;
    rates := apply(edges Rn.ReactionGraph, e->kk_e);
    Rn.ReactionRates = rates;
    Rn.ReactionRates
    )

createInitialValues = method()
createInitialValues ReactionNetwork := Rn -> (
    cc := symbol cc;
    P := apply(Rn.Species,a->(a,0));
    C := apply(P, i->cc_(first i));
    Rn.InitialValues = C;
    Rn.InitialValues
    )

createConcentrationRates = method()
createConcentrationRates ReactionNetwork := Rn -> (
    xx := symbol xx;
    P := apply(Rn.Species,a->(a,0));
    Rn.ConcentrationRates = apply(P,i->xx_(first i));
    Rn.ConcentrationRates
    )

-- todo: do we need to duplicate code in first two methods?
createRing = method()
createRing ReactionNetwork := Rn -> createRing (Rn, QQ);
createRing(ReactionNetwork, Ring) := (Rn, FF) -> (
    createInitialValues Rn;
    createReactionRates Rn;
    createConcentrationRates Rn;
    R := FF[Rn.ConcentrationRates, Rn.InitialValues, Rn.ReactionRates];
    Rn.ReactionRing = R;
    Rn.ReactionRing
    )
createRing(ReactionNetwork, InexactFieldFamily) := (Rn, FF) -> (
    createInitialValues Rn;
    createReactionRates Rn;
    createConcentrationRates Rn;
    R := FF[Rn.ConcentrationRates, Rn.InitialValues, Rn.ReactionRates];
    Rn.ReactionRing = R;
    Rn.ReactionRing
    )

--needs work
specializeInitialValues = method()
specializeInitialValues(ReactionNetwork, Ring, List) := (Rn, FF, L) -> (
    createInitialValues Rn;
    createReactionRates Rn;
    Iv := toList(apply(0..length Rn.InitialValues-1, i-> value(Rn.InitialValues#i)));
    S := toList(apply(0..length Rn.InitialValues-1, i -> value(Rn.InitialValues#i) => L#i));
    T := new HashTable from S;
    Rn.InitialValues = for v in Iv list (if T#?v then T#v else v);
    P := apply(Rn.Species,a->(a,0));
    K := FF[Rn.ReactionRates];
    xx := symbol xx;
    RING := K[apply(P,i->xx_(first i))];
    Rn.ReactionRing = RING;
    Rn.ReactionRing
    )

TEST ///
restart
needsPackage "ReactionNetworks"
N = reactionNetwork("A --> 2B, A + C --> D, D --> 0", NullSymbol => "0")
R = createRing N
--specializeInitialValues(N, QQ, {1, 2, 3, 4})
N.InitialValues
N.ConcentrationRates
N.ReactionRates
steadyStateEquations N
conservationEquations N
///


addSpecies = method()
addSpecies(String, ReactionNetwork) := (s,Rn) -> 
    if not member(s,Rn.Species) then (
	Rn.Species = Rn.Species | {s};
	Rn.Complexes = apply(Rn.Complexes, c -> c | matrix{{0}})
	)

addComplex = method()
addComplex(String, ReactionNetwork) := (c,Rn) -> (
    isNonempty := (c!= Rn.NullSymbol); 
    if isNonempty then (
	species := apply(delete("", separateRegexp("[^((A-Z)|(a-z)_?(0-9)*'?)]", c)), stripCoef);
    	for specie in species do addSpecies(specie, Rn);
	);	
    	-- v is a row vector encoding the monomial corresponding to complex c
    	v := mutableMatrix(ZZ,1,#Rn.Species);
	if isNonempty then (    	
    	    apply(separateRegexp("\\+", c), t -> (
	    	    s:=stripCoef(t);
	    	    a:=specProportion(t);
	    	    if a === null then a = 1;
	    	    i:=position(Rn.Species, s' -> s' == s);
	    	    v_(0,i) = v_(0,i) + a;	  
	    	    ));
    	    );
    v = matrix v;
    if member(v,Rn.Complexes) then position(Rn.Complexes, v' -> v' == v) 
    else (
	Rn.Complexes = Rn.Complexes | {v};
	if not isNonempty then Rn.NullIndex = #Rn.Complexes - 1;
        #Rn.Complexes - 1
	)
    )

addReaction = method()
addReaction(String, ReactionNetwork) := (r,Rn) -> (
    r = repairReaction(removeWhitespace r, Rn.NullSymbol);
    complexes := apply(separateRegexp("(-->)|(<--)|(<-->)|,", r), removeWhitespace);
    if #complexes != 2 then error "Expected two complexes.";
    i := addComplex(first complexes, Rn);
    j := addComplex(last complexes, Rn);
    Rn.ReactionGraph = addVertices(Rn.ReactionGraph, {i,j});
    delim := concatenate separateRegexp(///[A-Z]|[a-z]|[0-9]|,|_|\+| ///, r);
    if delim == "-->" then Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{i,j}})
    else if delim == "<--" then Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{j,i}})
    else if delim == "<-->" then Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{i,j},{j,i}})
    else error "String not in expected format";
    )


netComplex = (Rn,c) -> (
    C := flatten entries Rn.Complexes#c;
    l := apply(#Rn.Species, i -> if C#i == 0 then "" 
	else (if C#i ==1 then "" else toString C#i) | Rn.Species#i);
    l = delete("", l);
    l = between("+", l);
    l = concatenate l;
    if l == "" then l = Rn.NullSymbol;
    l
    )

-- test belows fails when this method inherits from 'merge', not sure why
glue = method()
glue (ReactionNetwork,ReactionNetwork) := (N1, N2) -> (
    assert(N1.NullSymbol == N2.NullSymbol);
    N := copy N1;
    apply(networkToHRF N2, r -> addReaction(r,N));
    N
    );
glue (List, ReactionNetwork) := (L, N) -> glue(reactionNetwork(L, NullSymbol => N.NullSymbol), N)
glue (ReactionNetwork, List) := (N, L) -> glue(N, reactionNetwork(L, NullSymbol => N.NullSymbol))


TEST ///
restart
needsPackage "ReactionNetworks"
NM = reactionNetwork("A <-- 2B, A + C <-- D, B + E --> A + C", NullSymbol => "0")
NN = reactionNetwork("A --> 2B, A + C --> D, D --> B+E", NullSymbol => "0")
glue(NM, NN)
N1 = reactionNetwork("2A --> 0, B --> A, A+C <-- 0", NullSymbol => "0")
N2 = reactionNetwork("2B --> 0, B+C --> 2A, C <-- 0", NullSymbol => "0")
glue(N1, N2)
///



-- L is a list of options of the form "A" => "B"
sub(ReactionNetwork, List) := (N, L) -> (
    T := new HashTable from L;
    N.Species = for s in N.Species list (if T#?s then T#s else s);
    N
    )


TEST ///
restart
needs "ReactionNetworks.m2"
NM = reactionNetwork "A <-- 2B, A + C <-- D, B + E --> A + C"
sub(NM, {"A" => "Y"})
N = oneSiteModificationA()
sub(N, {"S_0" => "A"})
///



networkToHRF = N -> apply(edges N.ReactionGraph, e -> netComplex(N, first e) | "-->" | 
    netComplex(N, last e))

net ReactionNetwork := N -> stack networkToHRF N 

-- Matrices

stoichiometricMatrix = method()
stoichiometricMatrix ReactionNetwork := N -> (
    C := N.Complexes;
    reactions := apply(edges N.ReactionGraph, e -> C#(last e) - C#(first e));
    M := reactions#0;
    for i from 1 to #reactions -1 do M=M||reactions#i;
    transpose M
    )

reactionMatrix = method()
reactionMatrix ReactionNetwork := N -> (
    M := stoichiometricMatrix N;
    - transpose M
    )

reactantMatrix = method()
reactantMatrix ReactionNetwork := N -> (
    C := N.Complexes;
    reactions := apply(edges N.ReactionGraph, e -> C#(first e));
    M := reactions#0;
    for i from 1 to #reactions-1 do M=M||reactions#i;
    M
    )
    
TEST ///
restart
needs "ReactionNetworks.m2"
N = reactionNetwork "A <--> 2B, A+C <--> D, D --> B+E, B+E --> A+C"
stoichiometricMatrix N
reactionMatrix N
reactantMatrix N
///

stoichiometricSubspace = method()
stoichiometricSubspace ReactionNetwork := N -> (
    C := N.Complexes;
    reactions := apply(edges N.ReactionGraph, e -> C#(last e) - C#(first e));
    M:=reactions#0;
    for i from 1 to #reactions - 1 do M=M||reactions#i;
    mingens image transpose M
    )

stoichSubspaceKer = method()
stoichSubspaceKer ReactionNetwork := N -> (
    C := N.Complexes;
    reactions := apply(edges N.ReactionGraph, e -> C#(last e) - C#(first e));
    M:=reactions#0;
    for i from 1 to #reactions - 1 do M=M||reactions#i;
    mingens ker M
    )

TEST ///
restart
needsPackage "ReactionNetworks"
CRN = reactionNetwork "A <--> 2B, A + C <--> D, B + E --> A + C, A+C --> D"
assert(rank(stoichiometricSubspace CRN) == 3)
assert(stoichiometricSubspace CRN == 
    mingens image transpose matrix{{1,-2,0,0,0},{1,-1,1,0,-1},{1,0,1,-1,0}})
assert(stoichSubspaceKer CRN ==
    mingens image transpose matrix{{2,1,-1,1,0},{-2,-1,2,0,1}})
///

concentration = (species,N,R) -> R_(position(N.Species, s->s==species))

--I think this is part of the code that is a problem    
termInp = (a,inp,out,N,R) -> if member(a,inp/first) then (
    xx := symbol xx;     
    p := position(inp/first,x->x==a);
    - last inp#p * product(inp,b->(xx_(first b,N,R))^(last b)) 
    ) else 0
termOut = (a,inp,out,N,R) -> if member(a,out/first) then ( 
    xx := symbol xx;     
    p := position(out/first,x->x==a);
    last out#p * product(inp,b->(xx_(first b,N,R))^(last b)) 
    ) else 0


--maybe useful to fix steadyStateEquations
-- W = for i from 0 to length R-1 list positions(first first R#i, (a,b) -> b=!=0)
-- Z=for i from 0 to #R-1 list (R#i)#1
-- X=for i from 0 to #W-1 list apply(flatten W#i, w-> xx#w)
-- E=for i from 0 to #R-1 list (for j from 0 to #W#i-1 list (last (first first R#i)#((flatten W#i)#j)))
-- P = for i from 0 to #R-1 list product(X#i, E#i, (x,y) -> x^y)
-- Y=for i from 0 to #R-1 list Z#i*P#i
-- M = transpose matrix{Y}
-- S = sub(stoichiometricMatrix N, N.ReactionRing)
-- steadyStateEquations = S*M
--R := apply(edges N.ReactionGraph, e->(
--	    (i,j) := toSequence e;
--	    (
--		apply(N.Species, flatten entries N.Complexes#i, (s,c)->(s,c)) =>
--	    	apply(N.Species, flatten entries N.Complexes#j, (s,c)->(s,c)),
--		kk#(position(edges N.ReactionGraph,e'->e'==e)),0  --the last coordinate of 0 is not necessary
--		)  
--	    ));
--    RING := N.ReactionRing;

steadyStateEquations = method()
steadyStateEquations ReactionNetwork := N -> steadyStateEquations(N,QQ)
steadyStateEquations (ReactionNetwork,Ring) := (N,FF) -> (
    if N.ReactionRing === null then error("You need to invoke createRing(CRN, FF) first!");
    kk := toList(apply(0..length N.ReactionRates-1, i -> value(N.ReactionRates#i)));
    xx := toList(apply(0..length N.ConcentrationRates-1, i -> value(N.ConcentrationRates#i)));
    -- C is a list of pairs (species, input_rate)
    -- C := apply(N.Species,a->(a,0));
    -- R is a list of reaction equations, formatted ({(specie, coefficient), ... } => 
    -- {(specie, coefficient), ...}, fwdrate, bckwd rate)
    RE := apply(edges N.ReactionGraph, e->(
	    (i,j) := toSequence e;
	    (apply(N.Species, flatten entries N.Complexes#i, (s,c)->(s,c)) =>
	     apply(N.Species, flatten entries N.Complexes#j, (s,c)->(s,c)),
	     kk#(position(edges N.ReactionGraph,e'->e'==e)))  
	    ));
    l := length RE-1;
    W := for i from 0 to l list positions(first first RE#i, 
	(a,b) -> b=!=0);
    X := for i from 0 to length W-1 list apply(flatten W#i, w -> xx#w);
    E := for i from 0 to l list (
	for j from 0 to length W#i-1 list (last(first first RE#i)#((flatten W#i)#j))
	);
    P := for i from 0 to l list product(X#i, E#i, (x,e) -> x^e);
    Z := for i from 0 to l list (RE#i)#1;
    Y := for i from 0 to l list Z#i*P#i;
    M := transpose matrix{Y};
    S := sub(stoichiometricMatrix N, N.ReactionRing);
    S*M
    )

TEST ///
restart
needs "ReactionNetworks.m2"
N = reactionNetwork "A <--> 2B, A+C <--> D, D --> B+E, B+E --> A+C"
createRing N
steadyStateEquations N
///


-- helper function for laplacian: partitions ReactionGraph edges according to those which dont contain a null complex
sepEdges = Rn -> (
    seps := new MutableHashTable from {NullEdges => {}, FullEdges => {}};
    apply(edges Rn.ReactionGraph, 
	e -> if (first e =!= Rn.NullIndex) and (last e =!= Rn.NullIndex) then seps.FullEdges = append(seps.FullEdges, e)
	else seps.NullEdges = append(seps.NullEdges,e));
    seps
	)

--laplacian needs to be redone
-- interface can be greatly improved, but this seems to work, and also handles CRNs with NullSymbols
{*
laplacian = (Rn, FF) -> (
    -- step 1) build parameter ring
    n := #Rn.Complexes;
    s := #Rn.Species;
    seps :=  sepEdges Rn;
    kk := symbol kk; 
    K := FF[apply(seps.FullEdges, e -> kk_e)];
    -- step 2) build Y matrix
    Y := (Rn.Complexes)#0;
    for i from 2 to n do  Y = Y || (Rn.Complexes)#(i-1);
    if Rn.NullIndex >= 0 then (
	for i from 0 to n - 1 do (
	     Y = Y_{0..Rn.NullIndex-1 } | matrix(ring Y, {{0}}) | Y_{Rn.NullIndex .. s-1};
	     --tmp := 0;
	     --if member({i, Rn.NullIndex}, seps.NullEdges) then tmp = tmp +1;
	     --Y^{i} = (Y^{i})_{0..Rn.NullIndex -1} | matrix(ring Y, {{tmp}})  | (Y^{i})_{Rn.NullIndex .. s-1}; 
	     );
	);
    -- step 3 buil support monomials
    xx := symbol xx;
    R := K[apply(Rn.Species, s -> xx_(s))];
    x := vars R;
    if Rn.NullIndex >= 0 then x = x_{0..Rn.NullIndex} | {{1}} | x_{Rn.NullIndex + 1 .. numgens R -1};
    mons := apply(1 .. numrows Y, i -> product apply(flatten entries Y^{i-1}, flatten entries x, (a,b) -> b^a));
    mons = substitute(matrix {toList mons}, R);
    Y = substitute(Y, R);
    -- step four, build laplacian matrix
    rates := new MutableList from append(gens K,1);
    tmp := rates#(Rn.NullIndex-1);
    rates#(n-1) = tmp;
    rates#(Rn.NullIndex-1) = 1;
    rates = toList rates;
    L := mutableMatrix(K,n,n);
    for e in seps.FullEdges do L_(toSequence e) = kk_e;
    for e in seps.NullEdges do L_(toSequence e) = 1;
    for i from 0 to n-1 do L_(i,i) = - sum flatten entries matrix L^{i};
    L = substitute(matrix L, R);
    mons*L*Y
    )
*}

--why are initial values showing up here????? 
--cc_{species} show up in place of xx_{species}, have not been able to resolve why


steadyStateEquations (ReactionNetwork,InexactFieldFamily) := (N,FF) -> (
    if N.ReactionRing === null then error("You need to invoke createRing(CRN, FF) first!");
    G := gens coefficientRing N.ReactionRing;
    kk := toList apply(0..(length N.ReactionRates-1), i -> G#i);
    -- C is a list of pairs (species, input_rate)
    C := apply(N.Species,a->(a,0));
    -- R is a list of reaction equations, formatted ({(specie, coefficient), ... } => {(specie, coefficient), ...}, fwdrate, bckwd rate)
    R := apply(edges N.ReactionGraph, e->(
	    (i,j) := toSequence e;
	    (
		apply(N.Species, flatten entries N.Complexes#i, (s,c)->(s,c)) =>
	    	apply(N.Species, flatten entries N.Complexes#j, (s,c)->(s,c))
		,
		kk#(position(edges N.ReactionGraph,e'->e'==e))
		,
		0
		)  
	    ));
    xx := symbol xx;
    RING := N.ReactionRing;
    xx = gens N.ReactionRing;
    F := for i in C list (
	(a,af) := i;
	sum(R,reaction->(
		(inp'out,k1,k2) := reaction;
		r1 := first inp'out;
		r2 := last inp'out;
		k1 * (termInp(a,r1,r2,N,RING) + termOut(a,r1,r2,N,RING)) +
		k2 * (termInp(a,r2,r1,N,RING) + termOut(a,r2,r1,N,RING))
		))  
	)
    )

TEST ///
restart
needsPackage "ReactionNetworks"
CRN = reactionNetwork "A <--> 2B, A + C <--> D, B + E --> A + C, D --> B+E"
CRN.ReactionRing
createRing(CRN, QQ)
F = steadyStateEquations CRN
steadyStateEquations CRN
conservationEquations CRN
matrix{F}
netList F
///


-- Need to allow for parameters, either random or input by user, to translate the 
-- stoichiometric subspace
-- Not sure if this is the right way to do this???
conservationEquations = method()
conservationEquations ReactionNetwork := N -> (
        if N.ReactionRing === null then error("You need to invoke createRing(CRN, FF) first!");
	conservationEquations(N, coefficientRing N.ReactionRing)
	)
conservationEquations (ReactionNetwork,Ring) := (N,FF) -> (
    if N.ReactionRing === null then createRing(N, FF);
    S := stoichSubspaceKer N;
    cc := toList(apply(0..length N.InitialValues-1, i -> value(N.InitialValues#i)));
 --   G := gens coefficientRing N.ReactionRing;
 --   cc := toList apply(
 --	(length N.ReactionRates)..(length N.ReactionRates+length N.InitialValues-1), 
 --	i -> G#i);
    RING := N.ReactionRing;
    xx := toList(apply(0..length N.ConcentrationRates-1, i -> value(N.ConcentrationRates#i)));
    M := matrix{xx}-matrix{cc};
    St := flatten entries (M*sub(S, FF));
    St	  
    )
conservationEquations (ReactionNetwork,InexactFieldFamily) := (N,FF) -> (
    if N.ReactionRing === null then error("You need to invoke createRing(CRN, FF) first!");
    S := stoichSubspaceKer N;
    G := gens coefficientRing N.ReactionRing;
    cc := toList apply(
	(length N.ReactionRates)..(length N.ReactionRates+length N.InitialValues-1), 
	i -> G#i);
    xx := symbol xx;
    RING := N.ReactionRing;
    xx = gens RING;
    M := matrix{xx}-matrix{cc};
    St := flatten entries (M*sub(S, FF));
    St	  
    )

displayComplexes = (Rn, FF) -> (
    R := createRing(Rn, FF);
    A := sub(transpose matrix{toList(0..#Rn.Complexes-1)}, R);
    B := matrix(apply(toList(0..#Rn.Complexes-1),
	    i -> flatten entries((sub(Rn.Complexes#i, R))*(transpose matrix vars R))
	    ));
    A | B
	) 

TEST ///
restart 
needsPackage "ReactionNetworks"
needsPackage "Graphs"
N = reactionNetwork "A <--> 2B, A + C <--> D, B + E --> A + C, D --> B+E"
peek N
displayComplexes(N,QQ)
createRing(N, QQ)
CE = conservationEquations N
SSE = steadyStateEquations N
F = join (CE, SSE)
I = ideal CE 
J = ideal SSE
I+J
///


--New functions to be created
isDeficient = Rn -> (
    d := rank(stoichiometricSubspace Rn);
    G := underlyingGraph(Rn.ReactionGraph);
    l := numberOfComponents G;
    p := #Rn.Complexes;
    delta := p - l - d;
    delta
    )

--Do we want True/False or the actual value?

TEST ///
N = reactionNetwork "A <--> 2B, A + C <--> D, B + E --> A + C, D --> B+E"
assert(isDeficient N == 0)
W = wnt()
assert(isDeficient W == 4)
///

--Weakly reversible if each connected component is strongly connected
isWeaklyReversible = Rn -> (
    D := Rn.ReactionGraph;
    C := connectedComponents(underlyingGraph D);
    L := flatten apply(C, c-> (apply(subsets(c,2), s -> 
		isReachable(D,s#0,s#1) and isReachable(D,s#1, s#0)
		)));
    Q := toList{i:=-1; while i<#L-1 do (
	    i=i+1;
	    l:=L#i;
	    if l==false then break i
	    )
	};
    if Q===toList{null} then true else false
    )

--negative laplacian
negativeLaplacian = method()
negativeLaplacian ReactionNetwork := Rn -> (
    G := underlyingGraph Rn.ReactionGraph;
    L := laplacianMatrix G;
    -L
    )
         

--injectivityTest = Rn ->

TEST ///
restart
needsPackage "ReactionNetworks"
needsPackage "Graphs"
N = reactionNetwork "A <--> 2B, A + C <--> D, B + E --> A + C, D --> B+E"
negativeLaplacian N
assert(isWeaklyReversible N == true)
assert(isWeaklyReversible wnt() == false)
///


load "ReactionNetworks/motifs-Kisun.m2"
load "ReactionNetworks/motifs-Cvetelina.m2"

-- end

beginDocumentation()
scan({
     "CrosslinkingModelCellDeath.m2",
     "OnesiteModificationA.m2",
     "OnesiteModificationB.m2",
     "OnesiteModificationC.m2",
     "OnesiteModificationD.m2",
     "TwolayerCascadeL.m2",
     "TwositeModificationE.m2",
     "TwositeModificationF.m2",
     "DocReactionNetworks.m2"
    },
    motif -> load("./ReactionNetworks/"|motif) 
    )

end

-- Here place M2 code that you find useful while developing this
-- package.  None of it will be executed when the file is loaded,
-- because loading stops when the symbol "end" is encountered.

restart
uninstallPackage "ReactionNetworks"
installPackage "ReactionNetworks"
installPackage("ReactionNetworks", RemakeAllDocumentation=>true)
check "ReactionNetworks"
peek ReactionNetworks
--help "OnesiteModificationA"
--viewHelp "OnesiteModificationA"
--examples "OnesiteModificationA"
viewHelp ReactionNetworks


-- Local Variables:
-- compile-command: "make -C $M2BUILDDIR/Macaulay2/packages PACKAGES=PackageTemplate pre-install"
-- End:
