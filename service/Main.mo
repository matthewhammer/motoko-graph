/* temp: boiler plate service
*/
import Debug "mo:base/Debug";

import Persis "../src/Persistent";

actor {
      
  // node ids, node data and edge data
  // 
  flexible var graph = Persis.empty<Nat, Nat, Nat>(Persis.NodeId.nat());

  // temp
  stable var count = 0;

  public func doNextCall() : async Bool {
    count += 1;
    if (count > 3) false else true
  };

  public func selfTest() : () {
     // to do
     Debug.print "success"
  };
}
