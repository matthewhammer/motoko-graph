import List "mo:base/List";
import AssocList "mo:base/AssocList";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Order "mo:base/Order";

module {
  /* The following types are chosen by the user of this library.

   We use (usually short mnemonics of) consistently-named type vars:

    - NodeId (I for short)
    - NodeData (N for short)
    - EdgeData (E for short)

    */

  public type EdgeId = Nat;

  public type EdgeInfo<I, E> = {
    source : I;
    target : I;
    data : E;
  };

  type Call<I, N, E> = { // Response-type:
    #clear; // ()
    #readNodes; // Iter<(I, N, Iter<(E, I)>)>
    #readEdges; // Iter<(EdgeId, EdgeInfo)>
    #compareEdges : (EdgeId, EdgeId); // ?Order

    #createNode : (I, N, [(E, I)]); // Iter<EdgeId>
    #readNode : I; // ?(N, Iter<(EdgeId, EdgeInfo)>)
    #updateNode : (I, N); // ?N
    #deleteNode : I; // ()
    #removeNode : I; // ?(N, Iter<(EdgeId, EdgeInfo)>)

    #createEdge : EdgeInfo<I, E>; // EdgeId
    #readEdge : EdgeId; // ?EdgeInfo
    #edgeRank : EdgeId; // ?Nat  (?0 for first)
    #insertEdge : ({#after; #before}, EdgeId, EdgeInfo<I, E>); // ?EdgeId
    #updateEdge : (EdgeId, EdgeInfo<I, E>); // ?EdgeInfo
    #deleteEdge : EdgeId; // ()
    #removeEdge : EdgeId; // ?EdgeInfo

    // graph walk: root graph at a node and algorithmically walk the graph's edges
    // (zero or once each) to each other node (exactly once each).
    #walk : (I, Walk<I, N, E>); // Iter<(EdgeId, EdgeInfo, N)>
  };

  type Walk<I, N, E> = {
    #breath;
    #depth;
    #metric : (
      {#min; #max},
      Metric<I, N, E>
    )
  };

  /// metrics for search:
  /// - null encodes infinite positive magnitudes
  /// - node-node distance function must be [admissible](https://en.wikipedia.org/wiki/A*_search_algorithm#Admissibility).
  type Metric<I, N, E> = {
    length : (EdgeId, I, E, I) -> ?Nat;
    distance : (I, N, I, N) -> ?Nat;
  };

  public type Iter<X> = Iter.Iter<X>;

  /// OO interface for graphs (proposed, RFC)
  public type Object<I, N, E> = object {
    clear : () -> ();
    readNodes : () -> Iter<(I, N, Iter<(E, I)>)>;
    readEdges : () -> Iter<(EdgeId, EdgeInfo<I, E>)>;
    compareEdges : (EdgeId, EdgeId) -> ?Order.Order;

    createNode : (I, N, [(E, I)]) -> Iter<EdgeId>;
    readNode : I -> ?(N, Iter<(EdgeId, EdgeInfo<I, E>)>);
    updateNode : (I, N) -> ?N;
    deleteNode : I -> ();
    removeNode : I -> ?(N, Iter<(EdgeId, EdgeInfo<I, E>)>);

    createEdge : EdgeInfo<I, E> -> EdgeId;
    readEdge : EdgeId -> ?EdgeInfo<I, E>;
    edgeRank : EdgeId -> ?Nat;  // (?0 for first, null for not found)
    insertEdge : ({#after; #before}, EdgeId, EdgeInfo<I, E>) -> ?EdgeId;
    updateEdge : (EdgeId, EdgeInfo<I, E>) -> ?EdgeInfo<I, E>;
    deleteEdge : EdgeId -> ();
    removeEdge : EdgeId -> ?EdgeInfo<I, E>;

    // graph walk: root graph at a node and algorithmically walk the graph's edges
    // (zero or once each) to each other node (exactly once each).
    walk : (I, Walk<I, N, E>) -> Iter<(EdgeId, EdgeInfo<I, E>, N)>;
  }
}
