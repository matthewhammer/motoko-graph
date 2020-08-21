import Types "Types";
import Param "Param";

module {
  // tiny parameter set
  public func tiny() : [Param.Entity] {
    [
      #producer({id="p1"; region=1}),
      #inventory({id="i0"; producer="p1";
                  kind="apple";
                  quantity=80;
                  cost=20}),
      #inventory({id="i1"; producer="p2";
                  kind="avocado";
                  quantity=20;
                  cost=80}),
      #producer({id="p2"; region=2}),
      #producer({id="p3"; region=3}),
      #trucker({id="t1"}),
      #trucker({id="t2"}),
      #route({id="t1-1-2";
              startRegion=1; endRegion=2;
              startTime=0; endTime=1;
              trucker="t1"; cost=20}),
      #route({id="t1-2-1";
              startRegion=2; endRegion=1;
              startTime=2; endTime=3;
              trucker="t2"; cost=80}),      
      #retailer({id="r1"; region=2}),
      #retailer({id="r2"; region=3}),
    ]
  };
};
