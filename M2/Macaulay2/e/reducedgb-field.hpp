// Copyright 2005, Michael E. Stillman

#ifndef _reducedgb_field_
#define _reducedgb_field_

#include "reducedgb.hpp"

/**
    @ingroup reducedgb

    @brief Computation of a reduced GB w.r.t. a term order, over a field
*/
class ReducedGB_Field : public ReducedGB
{
  friend ReducedGB *ReducedGB::create(const PolynomialRing *originalR0,
                                      const FreeModule *F0,
                                      const FreeModule *Fsyz0,
                                      const GBWeight *wt0);

 protected:
  MonomialTable *T;
  const MonomialIdeal *Rideal;

  ReducedGB_Field(GBRing *R0,
                  const PolynomialRing *originalR0,
                  const FreeModule *F0,
                  const FreeModule *Fsyz0);

 public:
  virtual ~ReducedGB_Field();

  virtual void remove_gb() {}
  virtual void set_gb(VECTOR(POLY) & polys0);

  virtual void minimalize(const VECTOR(POLY) & polys0, bool auto_reduced);

  virtual void remainder(POLY &f, bool use_denom, ring_elem &denom);

  virtual void remainder(gbvector *&f, bool use_denom, ring_elem &denom);
};

#endif

// Local Variables:
// compile-command: "make -C $M2BUILDDIR/Macaulay2/e "
// indent-tabs-mode: nil
// End:
