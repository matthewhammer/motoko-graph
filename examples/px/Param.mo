import Types "Types";

/// Parameter data for graph model
module {

  /// Parameter data for graph construction (gives pre-graphical, seed-data structure)
  
  public type Time = Types.Time;
  public type EntityId = Types.EntityId;
  public type RegionId = Types.RegionId;

  public type Entity = {
    #inventory : Inventory;
    #producer : Producer;
    #retailer : Retailer;
    #route : Route;
    #trucker : Trucker;
  };
  
  public type Producer = {
    id : EntityId;
    region : RegionId;
  };
  
  public type Retailer = {
    id : EntityId;
    region : RegionId;
  };
  
  public type Trucker = {
    id : EntityId;
    // any more info?
  };
  
  public type Route = {
    id : EntityId;
    startRegion : RegionId;
    startTime : Time;
    endRegion : RegionId;
    endTime : Time;
    trucker : EntityId;
    cost : Nat;
  };
  
  public type Inventory = {
    id : EntityId;
    producer : EntityId;
    kind : Text;
    quantity : Nat;
    cost : Nat;
  };
};
