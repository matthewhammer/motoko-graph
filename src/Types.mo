import List "mo:base/List";
import AssocList "mo:base/AssocList";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Iter "mo:base/Iter";

module {
  /* Type vars: Names and short mnemonics:
    - NodeId (I for short),
    - NodeData (D for short),
    - EdgeLabel (L for short)
    */

  type Shared<I,D,L> = {

  };

  type Internal<I,D,L> = {


  };

  type Call<I,D,L> = { // Response-type:
    #addNode : (I, D, [(L, I)]); // ()
    #addEdge : (I, L, I); // ()
    #nodes; // Iter<(I, D, Iter<(L, I)>)>
    #edges; // Iter<(I, L, I)>
    #data : I; // ?D
    #labelsOf : (I, I); // Iter<L>
    #targetOf : (I, Nat); // ?Iter<I>
    #labels : (I, I); // Iter<L>
    #removeNode : I; // ?()
    #removeEdge : (I, I); // ?()
    #removeEdges : (I, I); // Nat
    #removeEdgesFrom : I; // Nat
    #removeEdgesInto : I; // Nat
    #removeEdgeNum : (I, Nat); // ?()
  }

}
