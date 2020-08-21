import Types "Types";
import Param "Param";
import Model "Model";
import SeedData "SeedData";

import GraphSearch "../../src/Search";
import GraphBuild "../../src/Build";

import Debug "mo:base/Debug";

import Sequence "mo:sequence/Sequence";

actor {

  var graph : Model.Build.Graph = GraphBuild.empty();
  var search = GraphSearch.Search(graph);

  func reset(ents : [Param.Entity]) {
    graph.clear();
    let b = GraphBuild.Build(graph);
    graph := Model.Build.entities(b, ents);
    search := GraphSearch.Search(graph);
  };

  public func selfInit() {
    reset(SeedData.tiny())
  };

  public func init(ents : [Param.Entity]) {
    reset(ents)
  };

  // to do -- more edits to data as edits to graph, exposed as public API

  public query func retailerQuery(id : Text) : async Nat {
    let paths = search.nodePaths(
      // source node is _any_ inventory
      #pred(
        func(_, d) : Bool {
          switch d {
          case (#inventory(_)) { true };
          case (_) { false }
          }
        }),
      // target node is the retailer in question
      #pred(
        func(j, _) : Bool { j == id }
      ));
    // to do -- give fuller response
    Sequence.size(paths)
    };
}
