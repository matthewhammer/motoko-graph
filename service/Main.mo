/* temp: boiler plate service
*/
import Debug "mo:base/Debug";
actor {
      
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
