import Types "Types";

module {

  public type Graph<I, N, E> = Types.GraphObject<I, N, E>;

  public func empty<I, N, E>() : Graph<I, N, E> {
    // to do

    // to do -- choose a simple, inefficient represetnation for now (while finishing Persistent one); use for tests
    assert false;
    loop { }
  };

  public class Build<I, N, E>(g : Graph<I, N, E>) {

    public func node(id : I, data : N) {
      switch (g.createNode(id, data, [])) {
        case null { assert false }; // to do -- error about id
        case _ { };
      }
    };

    public func edge(src : I, tgt : I, d : E) {
      ignore g.createEdge({source = src; target = tgt; data = d})
    };

    public func graph() : Graph<I, N, E> = g;

  };
}
