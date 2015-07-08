--		Copyright 1993-1999 by Daniel R. Grayson


simpson := (f,a,b,k) -> (
     count := 0;
     oldf := f;
     f = x -> (
	  count = count + 1;
	  oldf x);
     h := (b-a)/(2*k);
     ff := i -> f(a + i*h);
     int := h/3 (
	  ff 0 
	  + 4 sum(k  , j -> ff(2*j+1)) 
	  + 2 sum(k-1, j -> ff(2*j+2))
	  + ff(2*k)
	  );
     << count << " function evaluations\n";
     int
     )


xx := {
     ,					  -- n==0
     ,					  -- n==1
     {
	  -.577350269189626,
	  .577350269189626},		  -- n==2
     {
	  -.774596669241483,
	  0,
	  .774596669241483},		  -- n==3
     {
	  -.861136311594053,
	  -.339981043584856,
	  .339981043584856,
	  .861136311594053
	  },				  -- n==4
     {
	  -.906179845938664,
	  -.538469310105683,
	  0,
	  .538469310105683,
	  .906179845938664
	  },				  -- n==5
     {
	  -.932469514203152,
	  -.661209386466265,
	  -.238619186083197,
	  .238619186083197,
	  .661209386466265,
	  .932469514203152
	  }				  -- n==6
     }

ww := {
     ,					  -- n==0
     ,					  -- n==1
     {1,1},				  -- n==2
     {5/9.,8/9.,5/9.},			  -- n==3
     {
	  .347854845137454,
	  .652145154862546,
	  .652145154862546,
	  .347854845137454
	  },				  -- n==4
     {
	  .236926885056189,
	  .478628670499366,
	  .568888888888889,
	  .478628670499366,
	  .236926885056189,
	  },				  -- n==5
     {
	  .171324492379170,
	  .360761573048139,
	  .467913934572691,
	  .467913934572691,
	  .360761573048139,
	  .171324492379170
	  }				  -- n==6
     }

gaussian := (f,a,b,n) -> (
     r := (b-a)/2;
     s := (b+a)/2;
     w := ww#n;
     x := xx#n;
     r * sum(n, i -> w#i * f(r * x#i + s)))


gauss := (f,a,b,k,n) -> (
--   count := 0;
--   oldf := f;
--   f = x -> (
--	  count = count + 1;
--	  oldf x);
     h := (b-a)/k;
     int := sum(k, i -> gaussian(f, a + i*h, a + (i+1)*h, n));
--     << count << " function evaluations\n";
     int
     )

integrate = method()
integrate (Function, Number, Number) := (f,a,b) -> (
     if not instance(f, Function) then error (
	  "'integrate' expected argument 1 to be a function");
     try a = a + 0. else error (
	  "'integrate' expected argument 2 to be a number");
     try b = b + 0. else error (
	  "'integrate' expected argument 3 to be a number");
     gauss(f,a,b,4,6))

-- Local Variables:
-- compile-command: "make -C $M2BUILDDIR/Macaulay2/m2 "
-- End:
