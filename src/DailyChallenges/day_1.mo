import Array "mo:base/Array";
import Debug "mo:base/Debug";

actor {
  var counter : Nat = 0;

  public func add(n : Nat, m : Nat) : async Nat {
    return (n + m);
  };

  public func square(n : Nat): async Nat {
    return (n * n);
  };

  public func days_to_second(n : Nat): async Nat {
    // 24 * 60 * 60 = 86400
    return (n * 86400);
  };

  public func increment_counter(n:Nat) : async Nat {
    counter+= n;
    return (counter);
  };

  public func clear_counter() {
    counter := 0;
  };

  public func divide(n: Nat, m: Nat) : async Bool {
    var canDivide : Bool = false;
    if (( m % n) == 0){
      canDivide:= true;
    };

    return (canDivide);
  };

  public func is_even(n: Nat) : async Bool {
    return (await divide(2, n));
  };

  public func sum_of_array(array:[Nat]): async Nat {
    var sum: Nat = 0;
    for (val in array.vals()){
      sum+= val
    };

    return (sum);
  };

  public func maximum(array:[Nat]): async Nat {
    var max: Nat = 0;
    for (val in array.vals()){
      if(val > max) {
        max:= val;
      };
    };

    return (max);
  };

  public func remove_from_array(array:[Nat], n:Nat): async [Nat]{
    let newArray: [Nat] = Array.filter(array, func (a:Nat): Bool{
          return (a != n);
        }
        );

    return (newArray);
  };

  public func selection_sort (array:[Nat]): async [Nat] {
    if(array.size() < 2){
      return (array);
    };

    var curIndex: Nat = 0;
    var posIndex: Nat = 0;
    var minIndex: Nat = 0;
    var mutableArr: [var Nat] = Array.thaw<Nat>(array);

    while (curIndex < mutableArr.size()){
      posIndex:= curIndex + 1;
      minIndex:= curIndex;
      while (posIndex < mutableArr.size()){
        if(mutableArr[posIndex] < mutableArr[minIndex]){
          minIndex:= posIndex;
        };
        posIndex+=1;
      };

      if (minIndex != curIndex){
        // swap
        let temp: Nat = mutableArr[curIndex];
        mutableArr[curIndex]:= mutableArr[minIndex];
        mutableArr[minIndex]:= temp;
      };
      curIndex+=1;
    };

    return (Array.freeze<Nat>(mutableArr));
  };
};
