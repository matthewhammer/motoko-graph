import GraphBuild "../../src/Build";
import GraphTypes "../../src/Types";

import PXTypes "Types";
import PXParam "Param";

import Nat "mo:base/Nat";

/// Graphical data model
module {

  /*

   ### Model versus Param module

   We represent data in pre-graph (Param module) and graphical (Model module) forms:

   1. Param module encodes relationships by fields with unique Ids of associated entities;

   2. Model module encodes (most) inter-entity relationships with labeled graph edges.

   To move from representation 1 to representation 2, we interpret
   some fields as graph edges, and build node data from remaining
   parameter information.

   In general, the entities of each node in Model store strictly less
   information than the parameters that generate them in Param, and the
   missing information appears instead on adjacent edges (or nodes, depending).

   There should be an equivalence between representations 1 and 2,
   permitting us to go back from 2 to 1 again while preserving
   information.  (We conjecture this, but do not explore now).

   Why use the Model graph?

   Representation 2 is better for queries that are highly relational
   since it exposes this relational structure as edges within the graph,
   and generic (domain agnostic) graph-searching logic applies.  (The
   graph library is meant to support all but the most domain-specific
   aspects of exploring these graphical relations.)

   */

  // graph node data
  public type Entity = {
    #inventory : Inventory;
    #producer : Producer;
    #region : Region;
    #retailer : Retailer;
    #route : Route;
    #trucker : Trucker;
  };

  /*
   Note:
   In Model, a Region is an Entity, since we want graph nodes that represent each.
   In Params, a region is "just" a Nat, and not a Param.Entity.
   */

  // graph edge data
  public type Edge = {
    #region; // edge target is #region; source is #producer or #retailer
    #contains; // edge source is #region; target is #producer or #retailer
    #inventory; // edge target is #inventory
    #producer; // edge target is #producer
    #route; // edge target is a #route; source is a #trucker
    #routePath : RouteData; // edge source/target is #region
  };

  public type Region = {
    num : Nat; // original numeric ID, from Param module type
  };

  public type Trucker = { };
  public type Retailer = { };
  public type Producer = { };

  public type Time = PXTypes.Time;
  public type EntityId = PXTypes.EntityId;

  // route as a graph node
  public type Route = {
    start : Time;
    end : Time;
    cost : Nat;
  };

  // route data as edge data connecting Region nodes
  public type RouteData = {
    id : EntityId; // node id for Route node
    start : Time;
    end : Time;
    cost : Nat;
  };

  public type Inventory = {
    kind : Text;
    quantity : Nat;
    cost : Nat;
  };


  /// Build GraphModel from parameter data
  public module Build {

    /// PX graph model
    public type Graph = GraphTypes.GraphObject<EntityId, Entity, Edge>;

    /// abstract graph-building operations
    public type Build = GraphBuild.Build<EntityId, Entity, Edge>;

    /// region Id from region number
    func regionNum(i : Nat) : Text {
      "region-" # (Nat.toText i)
    };
    
    /// build region node (no op if already exists)
    func regionNode(b : Build, num_ : Nat) {
      b.node(regionNum(num_), #region{ num = num_ });
    };

    /// build all entities in the parameter data
    public func entities(b : Build, ents : [PXParam.Entity]) : Graph {
      for (e in ents.vals()) {
        switch e {
          case (#inventory(i)) {
                 b.node(i.id, #inventory({kind = i.kind; quantity = i.quantity; cost = i.cost}));
                 b.edge(i.producer, i.id, #inventory);
                 b.edge(i.id, i.producer, #producer);
               };
          case (#producer(p)) {
                 b.node(p.id, #producer({ }));
                 regionNode(b, p.region);
                 b.edge(p.id, regionNum(p.region), #region);
                 b.edge(regionNum(p.region), p.id, #contains);
               };
          case (#retailer(r)) {
                 b.node(r.id, #retailer({ }));
                 regionNode(b, r.region);
                 b.edge(r.id, regionNum(r.region), #region);
                 b.edge(regionNum(r.region), r.id, #contains);
               };
          case (#trucker(t)) {
                 b.node(t.id, #trucker({ }));
               };
          case (#route(r)) {
                 b.node(r.id, #route({ start = r.startTime; end = r.endTime; cost = r.cost }));
                 regionNode(b, r.startRegion);
                 regionNode(b, r.endRegion);
                 b.edge(r.trucker, r.id, #route);
                 b.edge(regionNum(r.startRegion), 
                        regionNum(r.endRegion),
                        #routePath{ 
                          id = r.id; 
                          start = r.startTime; 
                          end = r.endTime; 
                          cost = r.cost 
                        });
               };
        }
      };
      b.graph()
    };
  }
}
