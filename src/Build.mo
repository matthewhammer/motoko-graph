import Types "Types";

module {

  public type G<I, N, E> = Types.GraphObject<I, N, E>;

  public class Build<I, N, E>(g : G<I, N, E>) {

    public func node(id : I, data : N) {
      switch (g.createNode(id, data, [])) {
        case null { assert false }; // to do -- error about id
        case _ { };
      }
    };

    public func edge(src : I, tgt : I, d : E) {
      ignore g.createEdge({source = src; target = tgt; data = d})
    };

    public func graph() : G<I, N, E> = g;

  };
}
