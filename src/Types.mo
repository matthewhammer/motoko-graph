import List "mo:base/List";
import AssocList "mo:base/AssocList";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

module {
  /* The following types are chosen by the user of this library.

   We use (usually short mnemonics of) consistently-named type vars:

    - NodeId (I for short)
    - NodeData (N for short)
    - EdgeData (E for short)

    */

  public type EdgeId = Nat;

  type Shared<I,N,E> = {
    // to do
  };

  type Internal<I,N,E> = {
    // to do
  };

  type Call<I, N, E> = { // Response-type:
    #clear; // ()
    #addNode : (I, N, [(E, I)]); // Iter<EdgeId>
    #addEdge : (I, E, I); // EdgeId
    #insertEdge : ({#after; #before}, EdgeId, I, E, I); // ?EdgeId
    #updateEdge : (EdgeId, I, E, I); // ?(I, E, I)
    #compareEdges : (EdgeId, EdgeId); // ?Order
    #nodes; // Iter<(I, N, Iter<(E, I)>)>
    #edges; // Iter<(I, E, I)>
    #node : I; // ?(N, Iter<(E, I)>)
    #edge : EdgeId; // ?(I, E, I)
    #deleteNode : I; // ?()
    #removeNode : I; // ?(N, Iter<(E, I)>)
    #removeEdge : EdgeId; // ?(I, E, I)

    // graph walk: root graph at a node and algorithmically walk the graph's edges
    // (zero or once each) to each other node (exactly once each).
    #walk : (I, Walk<I, N, E>); // Iter<(EdgeId, E, I, N)>
    });
  };

  type Walk<I, N, E> = {
    #breath;
    #depth;
    #metric : (
      {#min; #max},
      Metric<I, N, E>
    )
  };

  /// metrics for graph edges, and hueristic function for node-node
  /// distance (must be [admissible](https://en.wikipedia.org/wiki/A*_search_algorithm#Admissibility)).
  type Metric<I, N, E> = {
    length : (EdgeId, I, E, I) -> Nat;
    distance : (I, N, I, N) -> Nat;
  };
}
