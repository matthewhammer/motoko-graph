import Types "Types";
import Sequence "mo:sequence/Sequence";

module {

  public type NodePattern<I, N, E> = {
    #pred : ((I, N) -> Bool);
  }; 
  
  public type Seq<X> = Sequence.Sequence<X>;

  public type Node<I, N> = (I, N);
  public type Nodes<I, N> = Seq<Node<I, N>>;

  public type Edge<I, E> = Types.EdgeInfo<I, E>;
  public type Path<I, E> = Seq<Edge<I, E>>;
  public type Paths<I, E> = Seq<Path<I, E>>;

  public class Search<I, N, E>(g : Types.GraphObject<I, N, E>) {
    
    let appendNodes = Sequence.defaultAppend<Node<I, E>>();
    let appendEdges = Sequence.defaultAppend<Edge<I, E>>();  
    let appendPaths = Sequence.defaultAppend<Path<I, E>>();

    public func paths(src : I, tgt : I) : Paths<I, E> {
      // to do
      Sequence.empty()      
    };

    public func nodes(np : NodePattern<I, N, E>) : Nodes<I, N> {
      // to do
      Sequence.empty()
    };

    /// match node patterns and find all paths between all src/tgt match pairs
    public func nodePaths(
        src : NodePattern<I, N, E>, 
        tgt : NodePattern<I, N, E>) : Paths<I, E>
    {
      var result = Sequence.empty() : Paths<I, E>;
      let srcs = nodes(src);
      let tgts = nodes(tgt);
      for (src in Sequence.iter(srcs, #fwd)) {
        for (tgt in Sequence.iter(tgts, #fwd)) {
          result := appendPaths(result, paths(src.0, tgt.0))
        };
      };
      result
    };
  }
}
