// Copyright 2005 Michael E. Stillman.

#include <M2/config.h>
#include "../comp-gb.hpp"
#include "../ZZp.hpp"
#include "../polyring.hpp"
#include "../coeffrings.hpp"
#include "../matrix.hpp"
#include "../matrix-con.hpp"

#include "f4-computation.hpp"
#include "f4-m2-interface.hpp"
#include "f4.hpp"
#include "moninfo.hpp"

GBComputation *createF4GB(const Matrix *m,
                          M2_bool collect_syz,
                          int n_rows_to_keep,
                          M2_arrayint gb_weights,
                          int strategy,
                          M2_bool use_max_degree,
                          int max_degree)
{
  const PolynomialRing *R = m->get_ring()->cast_to_PolynomialRing();
  const Ring *K = R->getCoefficients();
  F4Mem *Mem = new F4Mem;
  Gausser *KK = Gausser::newGausser(K, Mem);
  if (KK == 0)
    {
      ERROR(
          "cannot use Algorithm => LinearAlgebra with this type of coefficient "
          "ring");
      return NULL;
    }

  GBComputation *G;
  G = new F4Computation(KK,
                        Mem,
                        m,
                        collect_syz,
                        n_rows_to_keep,
                        gb_weights,
                        strategy,
                        use_max_degree,
                        max_degree);
  return G;
}

F4Computation::F4Computation(Gausser *K0,
                             F4Mem *Mem0,
                             const Matrix *m,
                             M2_bool collect_syz,
                             int n_rows_to_keep,
                             M2_arrayint gb_weights,
                             int strategy,
                             M2_bool use_max_degree,
                             int max_degree)
{
  // Note: the F4Mem which K0 uses should be Mem.
  KK = K0;
  originalR = m->get_ring()->cast_to_PolynomialRing();
  F = m->rows();
  MI = new MonomialInfo(originalR->n_vars(),
                        originalR->getMonoid()->getMonomialOrdering());
  Mem = Mem0;

  f4 = new F4GB(KK,
                Mem0,
                MI,
                m->rows(),
                collect_syz,
                n_rows_to_keep,
                gb_weights,
                strategy,
                use_max_degree,
                max_degree);

  F4toM2Interface::from_M2_matrix(KK, MI, m, gb_weights, f4->get_generators());
  f4->new_generators(0, m->n_cols() - 1);
}

F4Computation::~F4Computation() { delete Mem; }
/*************************
 ** Top level interface **
 *************************/

void F4Computation::start_computation() { f4->start_computation(stop_); }
Computation /* or null */ *F4Computation::set_hilbert_function(
    const RingElement *hf)
{
  f4->set_hilbert_function(hf);
  return this;
}

const Matrix /* or null */ *F4Computation::get_gb()
{
  const gb_array &gb = f4->get_gb();
  MatrixConstructor result(F, 0);
  for (int i = 0; i < gb.size(); i++)
    {
      vec v = F4toM2Interface::to_M2_vec(KK, MI, gb[i]->f, F);
      result.append(v);
    }
  return result.to_matrix();
}

const Matrix /* or null */ *F4Computation::get_mingens()
{
#if 0
//   MatrixConstructor mat(_F,0);
//   for (VECTOR(gbelem *)::iterator i = gb.begin();
//        i != gb.end();
//        i++)
//     if ((*i)->minlevel == ELEM_POSSIBLE_MINGEN)
//       mat.append(originalR->translate_gbvector_to_vec(_F, (*i)->g.f));
//   return mat.to_matrix();
#endif
  return 0;
}

const Matrix /* or null */ *F4Computation::get_change() { return 0; }
const Matrix /* or null */ *F4Computation::get_syzygies() { return 0; }
const Matrix /* or null */ *F4Computation::get_initial(int nparts) { return 0; }
const Matrix /* or null */ *F4Computation::matrix_remainder(const Matrix *m)
{
  return 0;
}

M2_bool F4Computation::matrix_lift(
    const Matrix *m,
    const Matrix /* or null */ **result_remainder,
    const Matrix /* or null */ **result_quotient)
{
  *result_remainder = 0;
  *result_quotient = 0;
  ERROR("rawGBMatrixLift not implemented for LinearAlgebra GB's yets");
  return false;
}

int F4Computation::contains(const Matrix *m)
// Return -1 if every column of 'm' reduces to zero.
// Otherwise return the index of the first column that
// does not reduce to zero.
{
  return 0;
}

int F4Computation::complete_thru_degree() const
// The computation is complete up through this degree.
{
  return 0;
}

void F4Computation::text_out(buffer &o) const
/* This displays statistical information, and depends on the
   M2_gbTrace value */
{
}

void F4Computation::show() const  // debug display
{
  buffer o;
  stash::stats(o);
  emit(o.str());

  Mem->show();
  // f4->show();
}

// Local Variables:
// compile-command: "make -C $M2BUILDDIR/Macaulay2/e "
// indent-tabs-mode: nil
// End:
