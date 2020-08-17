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

  public type EdgeInfo<I, E> = {
    source : I;
    target : I;
    data : E;
  }

  type Shared<I,N,E> = {
    // to do
  };

  type Internal<I,N,E> = {
    // to do

    /*
     Design


     ## space-time constraints:

     All graph operations mentioned in type Call are either O(1) or O(log n) time.

     We employ two inductive structures to represent the graph nodes and edges, respectively:

     1. Node data (type NodeData)

     - Trie<I, N>

     2. Edge sequence (type EdgeSeq)

     - binary tree representing edge sequence

     - balanced: prob based on level tree alg (hashing unique ids, assigned by counter)

     - edge creation counter based on stateless det alg:
       - max id maintained at each bin node
       - next = max id + 1

     - maintain info at each internal bin node:
       - level : Nat (determined psuedo randomly, from EdgeIds)
       - maxId : Nat
       - edgeMap : Trie<EdgeId, EdgeInfo>
       - nodeMap : Trie<I, EdgeSeq>
       - ...?

       */

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

    #createEdge : EdgeInfo; // EdgeId
    #readEdge : EdgeId; // ?EdgeInfo
    #edgeRank : EdgeId; // ?Nat  (?0 for first)
    #insertEdge : ({#after; #before}, EdgeId, EdgeInfo); // ?EdgeId
    #updateEdge : (EdgeId, EdgeInfo); // ?EdgeInfo
    #deleteEdge : EdgeId; // ()
    #removeEdge : EdgeId; // ?EdgeInfo

    // graph walk: root graph at a node and algorithmically walk the graph's edges
    // (zero or once each) to each other node (exactly once each).
    #walk : (I, Walk<I, N, E>); // Iter<(EdgeId, EdgeInfo, N)>
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
