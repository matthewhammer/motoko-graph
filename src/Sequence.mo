import Trie "mo:base/Trie";
import Iter "mo:base/Iter";

module {

  /// identify positions uniquely
  ///
  /// (generally not sequential numbers)
  public type Id = Nat;

  /// efficient, balanced representation
  ///
  /// See chunky list representation from [Section 5 of this POPL 1989 paper](https://dl.acm.org/doi/10.1145/75277.75305).
  public type Sequence<X> = {
    #binary : Binary<X>;
    #leaf : Leaf<X>;
    #empty;
  };
  
  public type Binary<X> = {
    left : Sequence<X>;
    right : Sequence<X>;
    /// see POPL paper
    level : Nat32;
    /// set of ids (for fast search, put, remove)
    ids : Trie.Trie<Id, ()>;
    /// max id (for fast choice of next id)
    maxId : Id;    
  };

  public type Leaf<X> = {
    id : Id;
    data : X;
  };

  public func empty<X>() : Sequence<X> {
    #empty
  };

  public func make<X>(_data : X) : Sequence<X> {
    #leaf({id=0; data=_data})
  };
  
  public func add<X>(seq : Sequence<X>, data : X) : (Sequence<X>, Id) {
    // to do
    assert false;
    loop { };
  };

  public func find<X>(seq : Sequence<X>, id : Id) : ?X {
    // to do
    assert false;
    loop { };    
  };

  public func put<X>(seq : Sequence<X>, pos : {#after; #before}, id : Id, data : X) : ?(Sequence<X>, Id) {
    // to do
    assert false;
    loop { };    
  };

  public func remove<X>(seq : Sequence<X>, id : Id) : ?X {
    // to do
    assert false;
    loop { };    
  };

  public func delete<X>(seq : Sequence<X>, id : Id) {
    // to do
    assert false;
    loop { };
  };

  public func entries<X>() : Iter.Iter<(Id, X)> {
    // to do
    assert false;
    loop { };
  };

  public func entriesRev<X>() : Iter.Iter<(Id, X)> {
    // to do
    assert false;
    loop { };
  };

  public func iterate<X>(f : (Id, X) -> ()) {
    // to do
    assert false;
    loop { };
  };

}
