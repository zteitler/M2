
TEST ///
-*
    restart
    loadPackage("IntegralClosure", Reload =>true)
*-
S = QQ[a,b,c,d,e,f]

ideal1 = ideal(
   a*b*d,
   a*c*e,
   b*c*f,
   d*e*f,
   a*b*d*f,
   a*b*d*e
   )

ideal2 = ideal(
   a*b*c*d*e*f,
   a^2*b^2*d^2,
   a^2*b*c*d*e,
   a*b^2*c*d*f,
   a*b*d^2*e*f,
   a^2*b^2*d^2*f,
   a^2*b^2*d^2*e,
   a^2*c^2*e^2,
   a*b*c^2*e*f,
   a*c*d*e^2*f,
   a^2*b*c*d*e*f,
   a^2*b*c*d*e^2,
   b^2*c^2*f^2,
   b*c*d*e*f^2,
   a*b^2*c*d*f^2,
   a*b^2*c*d*e*f,
   d^2*e^2*f^2,
   a*b*d^2*e*f^2,
   a*b*d^2*e^2*f,
   a^2*b^2*d^2*f^2,
   a^2*b^2*d^2*e*f,
   a^2*b^2*d^2*e^2
   )

ideal3 = ideal(
   a^2*b^2*c*d^2*e*f,
   a^3*b^3*d^3,
   a^3*b^2*c*d^2*e,
   a^2*b^3*c*d^2*f,
   a^2*b^2*d^3*e*f,
   a^3*b^3*d^3*f,
   a^3*b^3*d^3*e,
   a^3*b*c^2*d*e^2,
   a^2*b^2*c^2*d*e*f,
   a^2*b*c*d^2*e^2*f,
   a^3*b^2*c*d^2*e*f,
   a^3*b^2*c*d^2*e^2,
   a*b^3*c^2*d*f^2,
   a*b^2*c*d^2*e*f^2,
   a^2*b^3*c*d^2*f^2,
   a^2*b^3*c*d^2*e*f,
   a*b*d^3*e^2*f^2,
   a^2*b^2*d^3*e*f^2,
   a^2*b^2*d^3*e^2*f,
   a^3*b^3*d^3*f^2,
   a^3*b^3*d^3*e*f,
   a^3*b^3*d^3*e^2,
   a^2*b*c^2*d*e^2*f,
   a^3*c^3*e^3,
   a^2*b*c^3*e^2*f,
   a^2*c^2*d*e^3*f,
   a^3*b*c^2*d*e^2*f,
   a^3*b*c^2*d*e^3,
   a*b^2*c^3*e*f^2,
   a*b*c^2*d*e^2*f^2,
   a^2*b^2*c^2*d*e*f^2,
   a^2*b^2*c^2*d*e^2*f,
   a*c*d^2*e^3*f^2,
   a^2*b*c*d^2*e^2*f^2,
   a^2*b*c*d^2*e^3*f,
   a^3*b^2*c*d^2*e*f^2,
   a^3*b^2*c*d^2*e^2*f,
   a^3*b^2*c*d^2*e^3,
   a*b^2*c^2*d*e*f^2,
   b^3*c^3*f^3,
   b^2*c^2*d*e*f^3,
   a*b^3*c^2*d*f^3,
   a*b^3*c^2*d*e*f^2,
   b*c*d^2*e^2*f^3,
   a*b^2*c*d^2*e*f^3,
   a*b^2*c*d^2*e^2*f^2,
   a^2*b^3*c*d^2*f^3,
   a^2*b^3*c*d^2*e*f^2,
   a^2*b^3*c*d^2*e^2*f,
   a*b*c*d^2*e^2*f^2,
   d^3*e^3*f^3,
   a*b*d^3*e^2*f^3,
   a*b*d^3*e^3*f^2,
   a^2*b^2*d^3*e*f^3,
   a^2*b^2*d^3*e^2*f^2,
   a^2*b^2*d^3*e^3*f,
   a^2*b^2*c*d^2*e*f^2,
   a^3*b^3*d^3*f^3,
   a^3*b^3*d^3*e*f^2,
   a^3*b^3*d^3*e^2*f,
   a^2*b^2*c*d^2*e^2*f,
   a^3*b^3*d^3*e^3
   )

ideal4 = ideal(
   a^3*b^3*c*d^3*e*f,
   a^4*b^4*d^4,
   a^4*b^3*c*d^3*e,
   a^3*b^4*c*d^3*f,
   a^3*b^3*d^4*e*f,
   a^4*b^4*d^4*f,
   a^4*b^4*d^4*e,
   a^4*b^2*c^2*d^2*e^2,
   a^3*b^3*c^2*d^2*e*f,
   a^3*b^2*c*d^3*e^2*f,
   a^4*b^3*c*d^3*e*f,
   a^4*b^3*c*d^3*e^2,
   a^2*b^4*c^2*d^2*f^2,
   a^2*b^3*c*d^3*e*f^2,
   a^3*b^4*c*d^3*f^2,
   a^3*b^4*c*d^3*e*f,
   a^2*b^2*d^4*e^2*f^2,
   a^3*b^3*d^4*e*f^2,
   a^3*b^3*d^4*e^2*f,
   a^4*b^4*d^4*f^2,
   a^4*b^4*d^4*e*f,
   a^4*b^4*d^4*e^2,
   a^3*b^2*c^2*d^2*e^2*f,
   a^4*b*c^3*d*e^3,
   a^3*b^2*c^3*d*e^2*f,
   a^3*b*c^2*d^2*e^3*f,
   a^4*b^2*c^2*d^2*e^2*f,
   a^4*b^2*c^2*d^2*e^3,
   a^2*b^3*c^3*d*e*f^2,
   a^2*b^2*c^2*d^2*e^2*f^2,
   a^3*b^3*c^2*d^2*e*f^2,
   a^3*b^3*c^2*d^2*e^2*f,
   a^2*b*c*d^3*e^3*f^2,
   a^3*b^2*c*d^3*e^2*f^2,
   a^3*b^2*c*d^3*e^3*f,
   a^4*b^3*c*d^3*e*f^2,
   a^4*b^3*c*d^3*e^2*f,
   a^4*b^3*c*d^3*e^3,
   a^2*b^3*c^2*d^2*e*f^2,
   a*b^4*c^3*d*f^3,
   a*b^3*c^2*d^2*e*f^3,
   a^2*b^4*c^2*d^2*f^3,
   a^2*b^4*c^2*d^2*e*f^2,
   a*b^2*c*d^3*e^2*f^3,
   a^2*b^3*c*d^3*e*f^3,
   a^2*b^3*c*d^3*e^2*f^2,
   a^3*b^4*c*d^3*f^3,
   a^3*b^4*c*d^3*e*f^2,
   a^3*b^4*c*d^3*e^2*f,
   a^2*b^2*c*d^3*e^2*f^2,
   a*b*d^4*e^3*f^3,
   a^2*b^2*d^4*e^2*f^3,
   a^2*b^2*d^4*e^3*f^2,
   a^3*b^3*d^4*e*f^3,
   a^3*b^3*d^4*e^2*f^2,
   a^3*b^3*d^4*e^3*f,
   a^3*b^3*c*d^3*e*f^2,
   a^4*b^4*d^4*f^3,
   a^4*b^4*d^4*e*f^2,
   a^4*b^4*d^4*e^2*f,
   a^3*b^3*c*d^3*e^2*f,
   a^4*b^4*d^4*e^3,
   a^3*b*c^3*d*e^3*f,
   a^4*c^4*e^4,
   a^3*b*c^4*e^3*f,
   a^3*c^3*d*e^4*f,
   a^4*b*c^3*d*e^3*f,
   a^4*b*c^3*d*e^4,
   a^2*b^2*c^4*e^2*f^2,
   a^2*b*c^3*d*e^3*f^2,
   a^3*b^2*c^3*d*e^2*f^2,
   a^3*b^2*c^3*d*e^3*f,
   a^2*c^2*d^2*e^4*f^2,
   a^3*b*c^2*d^2*e^3*f^2,
   a^3*b*c^2*d^2*e^4*f,
   a^4*b^2*c^2*d^2*e^2*f^2,
   a^4*b^2*c^2*d^2*e^3*f,
   a^4*b^2*c^2*d^2*e^4,
   a^2*b^2*c^3*d*e^2*f^2,
   a*b^3*c^4*e*f^3,
   a*b^2*c^3*d*e^2*f^3,
   a^2*b^3*c^3*d*e*f^3,
   a^2*b^3*c^3*d*e^2*f^2,
   a*b*c^2*d^2*e^3*f^3,
   a^2*b^2*c^2*d^2*e^2*f^3,
   a^2*b^2*c^2*d^2*e^3*f^2,
   a^3*b^3*c^2*d^2*e*f^3,
   a^3*b^3*c^2*d^2*e^2*f^2,
   a^3*b^3*c^2*d^2*e^3*f,
   a^2*b*c^2*d^2*e^3*f^2,
   a*c*d^3*e^4*f^3,
   a^2*b*c*d^3*e^3*f^3,
   a^2*b*c*d^3*e^4*f^2,
   a^3*b^2*c*d^3*e^2*f^3,
   a^3*b^2*c*d^3*e^3*f^2,
   a^3*b^2*c*d^3*e^4*f,
   a^3*b^2*c^2*d^2*e^2*f^2,
   a^4*b^3*c*d^3*e*f^3,
   a^4*b^3*c*d^3*e^2*f^2,
   a^4*b^3*c*d^3*e^3*f,
   a^3*b^2*c^2*d^2*e^3*f,
   a^4*b^3*c*d^3*e^4,
   a*b^3*c^3*d*e*f^3,
   b^4*c^4*f^4,
   b^3*c^3*d*e*f^4,
   a*b^4*c^3*d*f^4,
   a*b^4*c^3*d*e*f^3,
   b^2*c^2*d^2*e^2*f^4,
   a*b^3*c^2*d^2*e*f^4,
   a*b^3*c^2*d^2*e^2*f^3,
   a^2*b^4*c^2*d^2*f^4,
   a^2*b^4*c^2*d^2*e*f^3,
   a^2*b^4*c^2*d^2*e^2*f^2,
   a*b^2*c^2*d^2*e^2*f^3,
   b*c*d^3*e^3*f^4,
   a*b^2*c*d^3*e^2*f^4,
   a*b^2*c*d^3*e^3*f^3,
   a^2*b^3*c*d^3*e*f^4,
   a^2*b^3*c*d^3*e^2*f^3,
   a^2*b^3*c*d^3*e^3*f^2,
   a^2*b^3*c^2*d^2*e*f^3,
   a^3*b^4*c*d^3*f^4,
   a^3*b^4*c*d^3*e*f^3,
   a^3*b^4*c*d^3*e^2*f^2,
   a^2*b^3*c^2*d^2*e^2*f^2,
   a^3*b^4*c*d^3*e^3*f,
   a*b*c*d^3*e^3*f^3,
   d^4*e^4*f^4,
   a*b*d^4*e^3*f^4,
   a*b*d^4*e^4*f^3,
   a^2*b^2*d^4*e^2*f^4,
   a^2*b^2*d^4*e^3*f^3,
   a^2*b^2*d^4*e^4*f^2,
   a^2*b^2*c*d^3*e^2*f^3,
   a^3*b^3*d^4*e*f^4,
   a^3*b^3*d^4*e^2*f^3,
   a^3*b^3*d^4*e^3*f^2,
   a^2*b^2*c*d^3*e^3*f^2,
   a^3*b^3*d^4*e^4*f,
   a^3*b^3*c*d^3*e*f^3,
   a^4*b^4*d^4*f^4,
   a^4*b^4*d^4*e*f^3,
   a^4*b^4*d^4*e^2*f^2,
   a^3*b^3*c*d^3*e^2*f^2,
   a^4*b^4*d^4*e^3*f,
   a^3*b^3*c*d^3*e^3*f,
   a^4*b^4*d^4*e^4
   )

ideal5 = ideal(
   a^4*b^4*c*d^4*e*f,
   a^5*b^5*d^5,
   a^5*b^4*c*d^4*e,
   a^4*b^5*c*d^4*f,
   a^4*b^4*d^5*e*f,
   a^5*b^5*d^5*f,
   a^5*b^5*d^5*e,
   a^5*b^3*c^2*d^3*e^2,
   a^4*b^4*c^2*d^3*e*f,
   a^4*b^3*c*d^4*e^2*f,
   a^5*b^4*c*d^4*e*f,
   a^5*b^4*c*d^4*e^2,
   a^3*b^5*c^2*d^3*f^2,
   a^3*b^4*c*d^4*e*f^2,
   a^4*b^5*c*d^4*f^2,
   a^4*b^5*c*d^4*e*f,
   a^3*b^3*d^5*e^2*f^2,
   a^4*b^4*d^5*e*f^2,
   a^4*b^4*d^5*e^2*f,
   a^5*b^5*d^5*f^2,
   a^5*b^5*d^5*e*f,
   a^5*b^5*d^5*e^2,
   a^4*b^3*c^2*d^3*e^2*f,
   a^5*b^2*c^3*d^2*e^3,
   a^4*b^3*c^3*d^2*e^2*f,
   a^4*b^2*c^2*d^3*e^3*f,
   a^5*b^3*c^2*d^3*e^2*f,
   a^5*b^3*c^2*d^3*e^3,
   a^3*b^4*c^3*d^2*e*f^2,
   a^3*b^3*c^2*d^3*e^2*f^2,
   a^4*b^4*c^2*d^3*e*f^2,
   a^4*b^4*c^2*d^3*e^2*f,
   a^3*b^2*c*d^4*e^3*f^2,
   a^4*b^3*c*d^4*e^2*f^2,
   a^4*b^3*c*d^4*e^3*f,
   a^5*b^4*c*d^4*e*f^2,
   a^5*b^4*c*d^4*e^2*f,
   a^5*b^4*c*d^4*e^3,
   a^3*b^4*c^2*d^3*e*f^2,
   a^2*b^5*c^3*d^2*f^3,
   a^2*b^4*c^2*d^3*e*f^3,
   a^3*b^5*c^2*d^3*f^3,
   a^3*b^5*c^2*d^3*e*f^2,
   a^2*b^3*c*d^4*e^2*f^3,
   a^3*b^4*c*d^4*e*f^3,
   a^3*b^4*c*d^4*e^2*f^2,
   a^4*b^5*c*d^4*f^3,
   a^4*b^5*c*d^4*e*f^2,
   a^4*b^5*c*d^4*e^2*f,
   a^3*b^3*c*d^4*e^2*f^2,
   a^2*b^2*d^5*e^3*f^3,
   a^3*b^3*d^5*e^2*f^3,
   a^3*b^3*d^5*e^3*f^2,
   a^4*b^4*d^5*e*f^3,
   a^4*b^4*d^5*e^2*f^2,
   a^4*b^4*d^5*e^3*f,
   a^4*b^4*c*d^4*e*f^2,
   a^5*b^5*d^5*f^3,
   a^5*b^5*d^5*e*f^2,
   a^5*b^5*d^5*e^2*f,
   a^4*b^4*c*d^4*e^2*f,
   a^5*b^5*d^5*e^3,
   a^4*b^2*c^3*d^2*e^3*f,
   a^5*b*c^4*d*e^4,
   a^4*b^2*c^4*d*e^3*f,
   a^4*b*c^3*d^2*e^4*f,
   a^5*b^2*c^3*d^2*e^3*f,
   a^5*b^2*c^3*d^2*e^4,
   a^3*b^3*c^4*d*e^2*f^2,
   a^3*b^2*c^3*d^2*e^3*f^2,
   a^4*b^3*c^3*d^2*e^2*f^2,
   a^4*b^3*c^3*d^2*e^3*f,
   a^3*b*c^2*d^3*e^4*f^2,
   a^4*b^2*c^2*d^3*e^3*f^2,
   a^4*b^2*c^2*d^3*e^4*f,
   a^5*b^3*c^2*d^3*e^2*f^2,
   a^5*b^3*c^2*d^3*e^3*f,
   a^5*b^3*c^2*d^3*e^4,
   a^3*b^3*c^3*d^2*e^2*f^2,
   a^2*b^4*c^4*d*e*f^3,
   a^2*b^3*c^3*d^2*e^2*f^3,
   a^3*b^4*c^3*d^2*e*f^3,
   a^3*b^4*c^3*d^2*e^2*f^2,
   a^2*b^2*c^2*d^3*e^3*f^3,
   a^3*b^3*c^2*d^3*e^2*f^3,
   a^3*b^3*c^2*d^3*e^3*f^2,
   a^4*b^4*c^2*d^3*e*f^3,
   a^4*b^4*c^2*d^3*e^2*f^2,
   a^4*b^4*c^2*d^3*e^3*f,
   a^3*b^2*c^2*d^3*e^3*f^2,
   a^2*b*c*d^4*e^4*f^3,
   a^3*b^2*c*d^4*e^3*f^3,
   a^3*b^2*c*d^4*e^4*f^2,
   a^4*b^3*c*d^4*e^2*f^3,
   a^4*b^3*c*d^4*e^3*f^2,
   a^4*b^3*c*d^4*e^4*f,
   a^4*b^3*c^2*d^3*e^2*f^2,
   a^5*b^4*c*d^4*e*f^3,
   a^5*b^4*c*d^4*e^2*f^2,
   a^5*b^4*c*d^4*e^3*f,
   a^4*b^3*c^2*d^3*e^3*f,
   a^5*b^4*c*d^4*e^4,
   a^2*b^4*c^3*d^2*e*f^3,
   a*b^5*c^4*d*f^4,
   a*b^4*c^3*d^2*e*f^4,
   a^2*b^5*c^3*d^2*f^4,
   a^2*b^5*c^3*d^2*e*f^3,
   a*b^3*c^2*d^3*e^2*f^4,
   a^2*b^4*c^2*d^3*e*f^4,
   a^2*b^4*c^2*d^3*e^2*f^3,
   a^3*b^5*c^2*d^3*f^4,
   a^3*b^5*c^2*d^3*e*f^3,
   a^3*b^5*c^2*d^3*e^2*f^2,
   a^2*b^3*c^2*d^3*e^2*f^3,
   a*b^2*c*d^4*e^3*f^4,
   a^2*b^3*c*d^4*e^2*f^4,
   a^2*b^3*c*d^4*e^3*f^3,
   a^3*b^4*c*d^4*e*f^4,
   a^3*b^4*c*d^4*e^2*f^3,
   a^3*b^4*c*d^4*e^3*f^2,
   a^3*b^4*c^2*d^3*e*f^3,
   a^4*b^5*c*d^4*f^4,
   a^4*b^5*c*d^4*e*f^3,
   a^4*b^5*c*d^4*e^2*f^2,
   a^3*b^4*c^2*d^3*e^2*f^2,
   a^4*b^5*c*d^4*e^3*f,
   a^2*b^2*c*d^4*e^3*f^3,
   a*b*d^5*e^4*f^4,
   a^2*b^2*d^5*e^3*f^4,
   a^2*b^2*d^5*e^4*f^3,
   a^3*b^3*d^5*e^2*f^4,
   a^3*b^3*d^5*e^3*f^3,
   a^3*b^3*d^5*e^4*f^2,
   a^3*b^3*c*d^4*e^2*f^3,
   a^4*b^4*d^5*e*f^4,
   a^4*b^4*d^5*e^2*f^3,
   a^4*b^4*d^5*e^3*f^2,
   a^3*b^3*c*d^4*e^3*f^2,
   a^4*b^4*d^5*e^4*f,
   a^4*b^4*c*d^4*e*f^3,
   a^5*b^5*d^5*f^4,
   a^5*b^5*d^5*e*f^3,
   a^5*b^5*d^5*e^2*f^2,
   a^4*b^4*c*d^4*e^2*f^2,
   a^5*b^5*d^5*e^3*f,
   a^4*b^4*c*d^4*e^3*f,
   a^5*b^5*d^5*e^4,
   a^4*b*c^4*d*e^4*f,
   a^5*c^5*e^5,
   a^4*b*c^5*e^4*f,
   a^4*c^4*d*e^5*f,
   a^5*b*c^4*d*e^4*f,
   a^5*b*c^4*d*e^5,
   a^3*b^2*c^5*e^3*f^2,
   a^3*b*c^4*d*e^4*f^2,
   a^4*b^2*c^4*d*e^3*f^2,
   a^4*b^2*c^4*d*e^4*f,
   a^3*c^3*d^2*e^5*f^2,
   a^4*b*c^3*d^2*e^4*f^2,
   a^4*b*c^3*d^2*e^5*f,
   a^5*b^2*c^3*d^2*e^3*f^2,
   a^5*b^2*c^3*d^2*e^4*f,
   a^5*b^2*c^3*d^2*e^5,
   a^3*b^2*c^4*d*e^3*f^2,
   a^2*b^3*c^5*e^2*f^3,
   a^2*b^2*c^4*d*e^3*f^3,
   a^3*b^3*c^4*d*e^2*f^3,
   a^3*b^3*c^4*d*e^3*f^2,
   a^2*b*c^3*d^2*e^4*f^3,
   a^3*b^2*c^3*d^2*e^3*f^3,
   a^3*b^2*c^3*d^2*e^4*f^2,
   a^4*b^3*c^3*d^2*e^2*f^3,
   a^4*b^3*c^3*d^2*e^3*f^2,
   a^4*b^3*c^3*d^2*e^4*f,
   a^3*b*c^3*d^2*e^4*f^2,
   a^2*c^2*d^3*e^5*f^3,
   a^3*b*c^2*d^3*e^4*f^3,
   a^3*b*c^2*d^3*e^5*f^2,
   a^4*b^2*c^2*d^3*e^3*f^3,
   a^4*b^2*c^2*d^3*e^4*f^2,
   a^4*b^2*c^2*d^3*e^5*f,
   a^4*b^2*c^3*d^2*e^3*f^2,
   a^5*b^3*c^2*d^3*e^2*f^3,
   a^5*b^3*c^2*d^3*e^3*f^2,
   a^5*b^3*c^2*d^3*e^4*f,
   a^4*b^2*c^3*d^2*e^4*f,
   a^5*b^3*c^2*d^3*e^5,
   a^2*b^3*c^4*d*e^2*f^3,
   a*b^4*c^5*e*f^4,
   a*b^3*c^4*d*e^2*f^4,
   a^2*b^4*c^4*d*e*f^4,
   a^2*b^4*c^4*d*e^2*f^3,
   a*b^2*c^3*d^2*e^3*f^4,
   a^2*b^3*c^3*d^2*e^2*f^4,
   a^2*b^3*c^3*d^2*e^3*f^3,
   a^3*b^4*c^3*d^2*e*f^4,
   a^3*b^4*c^3*d^2*e^2*f^3,
   a^3*b^4*c^3*d^2*e^3*f^2,
   a^2*b^2*c^3*d^2*e^3*f^3,
   a*b*c^2*d^3*e^4*f^4,
   a^2*b^2*c^2*d^3*e^3*f^4,
   a^2*b^2*c^2*d^3*e^4*f^3,
   a^3*b^3*c^2*d^3*e^2*f^4,
   a^3*b^3*c^2*d^3*e^3*f^3,
   a^3*b^3*c^2*d^3*e^4*f^2,
   a^3*b^3*c^3*d^2*e^2*f^3,
   a^4*b^4*c^2*d^3*e*f^4,
   a^4*b^4*c^2*d^3*e^2*f^3,
   a^4*b^4*c^2*d^3*e^3*f^2,
   a^3*b^3*c^3*d^2*e^3*f^2,
   a^4*b^4*c^2*d^3*e^4*f,
   a^2*b*c^2*d^3*e^4*f^3,
   a*c*d^4*e^5*f^4,
   a^2*b*c*d^4*e^4*f^4,
   a^2*b*c*d^4*e^5*f^3,
   a^3*b^2*c*d^4*e^3*f^4,
   a^3*b^2*c*d^4*e^4*f^3,
   a^3*b^2*c*d^4*e^5*f^2,
   a^3*b^2*c^2*d^3*e^3*f^3,
   a^4*b^3*c*d^4*e^2*f^4,
   a^4*b^3*c*d^4*e^3*f^3,
   a^4*b^3*c*d^4*e^4*f^2,
   a^3*b^2*c^2*d^3*e^4*f^2,
   a^4*b^3*c*d^4*e^5*f,
   a^4*b^3*c^2*d^3*e^2*f^3,
   a^5*b^4*c*d^4*e*f^4,
   a^5*b^4*c*d^4*e^2*f^3,
   a^5*b^4*c*d^4*e^3*f^2,
   a^4*b^3*c^2*d^3*e^3*f^2,
   a^5*b^4*c*d^4*e^4*f,
   a^4*b^3*c^2*d^3*e^4*f,
   a^5*b^4*c*d^4*e^5,
   a*b^4*c^4*d*e*f^4,
   b^5*c^5*f^5,
   b^4*c^4*d*e*f^5,
   a*b^5*c^4*d*f^5,
   a*b^5*c^4*d*e*f^4,
   b^3*c^3*d^2*e^2*f^5,
   a*b^4*c^3*d^2*e*f^5,
   a*b^4*c^3*d^2*e^2*f^4,
   a^2*b^5*c^3*d^2*f^5,
   a^2*b^5*c^3*d^2*e*f^4,
   a^2*b^5*c^3*d^2*e^2*f^3,
   a*b^3*c^3*d^2*e^2*f^4,
   b^2*c^2*d^3*e^3*f^5,
   a*b^3*c^2*d^3*e^2*f^5,
   a*b^3*c^2*d^3*e^3*f^4,
   a^2*b^4*c^2*d^3*e*f^5,
   a^2*b^4*c^2*d^3*e^2*f^4,
   a^2*b^4*c^2*d^3*e^3*f^3,
   a^2*b^4*c^3*d^2*e*f^4,
   a^3*b^5*c^2*d^3*f^5,
   a^3*b^5*c^2*d^3*e*f^4,
   a^3*b^5*c^2*d^3*e^2*f^3,
   a^2*b^4*c^3*d^2*e^2*f^3,
   a^3*b^5*c^2*d^3*e^3*f^2,
   a*b^2*c^2*d^3*e^3*f^4,
   b*c*d^4*e^4*f^5,
   a*b^2*c*d^4*e^3*f^5,
   a*b^2*c*d^4*e^4*f^4,
   a^2*b^3*c*d^4*e^2*f^5,
   a^2*b^3*c*d^4*e^3*f^4,
   a^2*b^3*c*d^4*e^4*f^3,
   a^2*b^3*c^2*d^3*e^2*f^4,
   a^3*b^4*c*d^4*e*f^5,
   a^3*b^4*c*d^4*e^2*f^4,
   a^3*b^4*c*d^4*e^3*f^3,
   a^2*b^3*c^2*d^3*e^3*f^3,
   a^3*b^4*c*d^4*e^4*f^2,
   a^3*b^4*c^2*d^3*e*f^4,
   a^4*b^5*c*d^4*f^5,
   a^4*b^5*c*d^4*e*f^4,
   a^4*b^5*c*d^4*e^2*f^3,
   a^3*b^4*c^2*d^3*e^2*f^3,
   a^4*b^5*c*d^4*e^3*f^2,
   a^3*b^4*c^2*d^3*e^3*f^2,
   a^4*b^5*c*d^4*e^4*f,
   a*b*c*d^4*e^4*f^4,
   d^5*e^5*f^5,
   a*b*d^5*e^4*f^5,
   a*b*d^5*e^5*f^4,
   a^2*b^2*d^5*e^3*f^5,
   a^2*b^2*d^5*e^4*f^4,
   a^2*b^2*d^5*e^5*f^3,
   a^2*b^2*c*d^4*e^3*f^4,
   a^3*b^3*d^5*e^2*f^5,
   a^3*b^3*d^5*e^3*f^4,
   a^3*b^3*d^5*e^4*f^3,
   a^2*b^2*c*d^4*e^4*f^3,
   a^3*b^3*d^5*e^5*f^2,
   a^3*b^3*c*d^4*e^2*f^4,
   a^4*b^4*d^5*e*f^5,
   a^4*b^4*d^5*e^2*f^4,
   a^4*b^4*d^5*e^3*f^3,
   a^3*b^3*c*d^4*e^3*f^3,
   a^4*b^4*d^5*e^4*f^2,
   a^3*b^3*c*d^4*e^4*f^2,
   a^4*b^4*d^5*e^5*f,
   a^4*b^4*c*d^4*e*f^4,
   a^5*b^5*d^5*f^5,
   a^5*b^5*d^5*e*f^4,
   a^5*b^5*d^5*e^2*f^3,
   a^4*b^4*c*d^4*e^2*f^3,
   a^5*b^5*d^5*e^3*f^2,
   a^4*b^4*c*d^4*e^3*f^2,
   a^5*b^5*d^5*e^4*f,
   a^4*b^4*c*d^4*e^4*f,
   a^5*b^5*d^5*e^5
   )

    I = ideal(a*b*d,a*c*e,b*c*f,d*e*f);
    trim(J = I^2)
    K = integralClosure(I,I_0,2) -- integral closure of J = I^2
    assert(K == J + ideal"abcdef") 
    
--    load (currentDirectory() | "./IntegralClosure/brian-example1-answers.m2")
    assert(ideal1 == elapsedTime integralClosure(I, I_0, 1))
    assert(ideal2 == elapsedTime integralClosure(I, I_0, 2))
    assert(ideal3 == elapsedTime integralClosure(I, I_0, 3))
    assert(ideal4 == elapsedTime integralClosure(I, I_0, 4))
    assert(ideal5 == elapsedTime integralClosure(I, I_0, 5))
///


