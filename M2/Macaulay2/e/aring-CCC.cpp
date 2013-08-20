#include "aring-CCC.hpp"
#include "text-io.hpp"

namespace M2 {

  void ARingCCC::text_out(buffer &o) const
  {
    o << "ACCC_" << mPrecision;
  }

  void ARingCCC::elem_text_out(buffer &o,
			       ElementType &f,
			       bool p_one,
			       bool p_plus,
			       bool p_parens) const
  {
    gmp_CC_struct g;
    g.re = &f.re;
    g.im = &f.im;
    M2_string s = p_parens ? 
      (*gmp_tonetCCparenpointer)(&g) : (*gmp_tonetCCpointer)(&g);
 
    // if: first char is a "-", and p_plus, o << "+"
    // if: an internal "+" or "-", then put parens around it.
    //   otherwise: if the string is "1" or "-1", and !p_one
    //              then leave out the last character.

    bool prepend_plus = p_plus && (s->array[0] != '-');
    bool strip_last = !p_one && (
				 (s->len == 1 && s->array[0] == '1')
				 || (s->len == 2 && s->array[1] == '1' && s->array[0] == '-'));

    if (prepend_plus) o << "+";
    if (strip_last)
      o.put(s->array, s->len-1);
    else
      o.put(s->array, s->len);
  }
  
}
