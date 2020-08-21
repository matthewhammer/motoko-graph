import Types "Types";

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
    #region; // edge target is #region
    #inventory; // edge target is #inventory
    #producer; // edge target is #producer
    #route : RouteData; // edge source/target is #region
  };

  public type Region = {
    id : Nat; // original numeric ID, from Param
  };

  public type Trucker = { };
  public type Retailer = { };

  // out edges: #region and #inventory
  public type Producer = { };

  // route as a graph node
  public type Route = {
    start : Types.Time;
    end : Types.Time;
    cost : Nat;
  };

  // route data as edge data connecting Region nodes
  public type RouteData = {
    id : Types.EntityId; // node id for Route node
    start : Types.Time;
    end : Types.Time;
    cost : Nat;
  };

  // out edge: #producer
  public type Inventory = {
    kind : Text;
    quantity : Nat;
    cost : Nat;
  };

}
