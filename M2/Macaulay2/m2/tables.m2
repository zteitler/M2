--		Copyright 1993-2002 by Daniel R. Grayson

table = method()
table (VisibleList,VisibleList,Function) :=
table (ZZ,VisibleList,Function) :=
table (VisibleList,ZZ,Function) :=
table (ZZ,ZZ,Function) := (rows,cols,f) -> apply(rows,i->apply(cols,j->f(i,j)))

applyTable = (m,f) -> apply(m, v -> apply(v,f))

subtable = method()
subtable (VisibleList,VisibleList,List) :=
subtable (VisibleList,VisibleList,HashTable) :=
subtable (ZZ,VisibleList,List) :=
subtable (ZZ,VisibleList,HashTable) :=
subtable (VisibleList,ZZ,List) :=
subtable (VisibleList,ZZ,HashTable) :=
subtable (ZZ,ZZ,List) :=
subtable (ZZ,ZZ,HashTable) := (u,v,m) -> table(u, v, (i,j)->m_i_j)

isTable = m -> (
     instance(m, List) and
     #m > 0 and
     all(m, row -> instance(row, List) and #row === #m#0))

transpose List := List => m -> (
     if isTable m
     then pack(# m,mingle m)
     else if # m === 0
          then {}
	  else error ("expected ", toString m, " to be a table"))

-- Local Variables:
-- compile-command: "make -C $M2BUILDDIR/Macaulay2/m2 "
-- End:
