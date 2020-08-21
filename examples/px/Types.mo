module {

  // numeric identifiers for regions
  public type RegionId = Nat;
  
  // to do -- use mo:base/Time.Time
  public type Time = Int;

  // structured, human-readable identifiers
  public type EntityId =
    //{
    #text : Text;
    // To do -- more structure: e.g., #text("prod1-apple1") vs #array([#text("prod1"), #text("apple1")])
    //#array : [EntityId];
    //};


}
