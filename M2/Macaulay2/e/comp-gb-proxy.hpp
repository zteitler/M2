// Copyright 2004 Michael E. Stillman.

#ifndef _comp_gb_proxy_hpp_
#define _comp_gb_proxy_hpp_

#include "comp-gb.hpp"

/**
    @ingroup gb

    @brief handle to a GB.  Should be expunged, as full functionality isn't
   used.
*/
class GBProxy : public GBComputation
// This contains a GBComputation, which can be changed.
// For example, we can start with a computation, and then
// after it is done, we can jettison it, and consider only
// the GB object itself.
{
  GBComputation *G;

 protected:
  virtual bool stop_conditions_ok()
  {
    G->stop_ = stop_;
    return G->stop_conditions_ok();
  }
  // If the stop conditions in _Stop are inappropriate,
  // return false, and use ERROR(...) to provide an error message.

 public:
  GBProxy(GBComputation *G0) : G(G0) {}
  virtual ~GBProxy();

  virtual void remove_gb() {}
  GBComputation *replace_GB(GBComputation *G0)
  {
    GBComputation *result = G;
    set_status(G->status());
    G = G0;
    return result;
  }

  virtual GBComputation *cast_to_GBComputation() { return this; }
  virtual const Ring *get_ring() const { return G->get_ring(); }
  virtual Computation /* or null */ *set_hilbert_function(const RingElement *h)
  {
    return G->set_hilbert_function(h);
  }
  // The default version returns an error saying that Hilbert functions cannot
  // be used.

  virtual void start_computation()
  {
    G->start_computation();
    set_status(G->status());
  }

  virtual int complete_thru_degree() const { return G->complete_thru_degree(); }
  // The computation is complete up through this degree.

  // Recall that the status of the computation is maintained by the Computation
  // class,

  ////////////////////////////////
  // Results of the computation //
  ////////////////////////////////
  virtual const Matrix /* or null */ *get_gb() { return G->get_gb(); }
  virtual const Matrix /* or null */ *get_mingens() { return G->get_mingens(); }
  virtual const Matrix /* or null */ *get_change() { return G->get_change(); }
  virtual const Matrix /* or null */ *get_syzygies()
  {
    return G->get_syzygies();
  }

  virtual const Matrix /* or null */ *get_initial(int nparts)
  {
    return G->get_initial(nparts);
  }

  virtual const Matrix /* or null */ *get_parallel_lead_terms(M2_arrayint w)
  {
    return G->get_parallel_lead_terms(w);
  }

  ////////////////////////////////
  // Normal forms and lifting ////
  ////////////////////////////////

  virtual const Matrix /* or null */ *matrix_remainder(const Matrix *m)
  {
    return G->matrix_remainder(m);
  }

  virtual M2_bool matrix_lift(const Matrix *m,
                              const Matrix /* or null */ **result_remainder,
                              const Matrix /* or null */ **result_quotient)
  {
    return G->matrix_lift(m, result_remainder, result_quotient);
  }

  virtual int contains(const Matrix *m) { return G->contains(m); }
  //////////////////////////////////////
  // Statistics and spair information //
  //////////////////////////////////////

  virtual void text_out(buffer &o) const { G->text_out(o); }
  // This displays statistical information, and depends on the
  // M2_gbTrace value.

  virtual void show() const { G->show(); }
};

#endif

// Local Variables:
// compile-command: "make -C $M2BUILDDIR/Macaulay2/e "
// indent-tabs-mode: nil
// End:
