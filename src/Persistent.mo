import Types "Types";
import Trie "mo:base/Trie";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";

import Sequence "mo:sequence/Sequence";

/*
 # Design notes

 ## space-time constraints:

 All graph operations mentioned in type Call are either O(1) or O(log n) time.

 We employ two inductive structures to represent the graph nodes and
edges, respectively:

 1. Node map (with node data)

 2. Edge sequence (with edge data)

 */

module {

  public type EdgeId = Types.EdgeId;
  public type EdgeInfo<I, E> = Types.EdgeInfo<I, E>;

  public type Hash = Hash.Hash;

  /// operations over node ids
  public type NodeId<I> = {
    hash : I -> Hash;
    equal : (I, I) -> Bool;
  };

  /// example implementations for NodeId type
  public module NodeId {
    public func nat() : NodeId<Nat> = {
      hash=Hash.hash;
      equal=Nat.equal
    };
  };

  /// efficient representation (to do -- write down invariants)
  type Graph<I, N, E> = {
    nodeId : NodeId<I>;
    nodes : Trie.Trie<I, N>;
    edges : Sequence.Sequence<EdgeInfo<I, E>>;
  };

  public func empty<I, N, E>(_nodeId : NodeId<I>) : Graph<I, N, E> = {
    {
      nodeId = _nodeId;
      nodes = Trie.empty();
      edges = Sequence.empty();
    }
  };
}
