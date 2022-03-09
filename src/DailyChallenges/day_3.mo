import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
actor {

    /*
        Write a private function swap that takes 3 parameters : 
        a mutable array , an index j and an index i and returns the same array but where value at index i and index j have been swapped.
    */
    private func _swap<T>(array : [var T], j: Nat, i: Nat) : [var T] {
        var temp : T = array[j];
        array[j]:= array[i];
        array[i]:= temp;
        return array;
    };

    /*
        Write a function init_count that takes a Nat n and returns an array [Nat] where value is equal to it's corresponding index.
        Note : init_count(5) -> [0,1,2,3,4].
        Note 2 : Do not use Array.append.
    */
    public func init_count (n: Nat) : async [Nat]{
        let array : [var Nat] = Array.init<Nat>(n, 0);

        var index : Nat = 0;
        for (item in array.vals()){
            array[index]:= index;
            index+=1;
        };

        return (Array.freeze(array));
    };

    /*
        Write a function seven that takes an array [Nat] and returns "Seven is found" if one digit of ANY number is 7.
        Otherwise this function will return "Seven not found".
    */
    public func seven(array : [Nat]) : async Text {
        var found : Bool = false;
        var return_val : Text = "Seven not found";
        let seven: Char = '7';

        label search_loop for(num in array.vals()){
            let text : Text = Nat.toText(num);
            for (char in text.chars()){
                if (char == seven){
                    found:=true;
                    break search_loop;
                }
            };
        };

        if(found) {
            return_val:= "Seven is found";
        };

        return (return_val);
    };

    /*
        Write a function nat_opt_to_nat that takes two parameters : n of type ?Nat and m of type Nat .
        This function will return the value of n if n is not null and if n is null it will default to the value of m.
    */
    public func nat_opt_to_nat(n:?Nat, m:Nat) : async Nat{
        switch(n){
            case(null){
                return m;
            };
            case(?nat){
                return nat;
            };
        };
    };

    /*
        Write a function day_of_the_week that takes a Nat n and returns a Text value corresponding to the day. If n doesn't correspond to any day it will return null .

        day_of_the_week (1) -> "Monday".
        day_of_the_week (7) -> "Sunday".
        day_of_the_week (12) -> null.
    */
    public func day_of_the_week(n:Nat): async ?Text {
        var day : ?Text = null;
        switch(n){
            case(1){ day:=?"Monday"; };
            case(2){ day:=?"Tuesday"; };
            case(3){ day:=?"Wednesday"; };
            case(4){ day:=?"Thursday"; };
            case(5){ day:=?"Friday"; };
            case(6){ day:=?"Satday"; };
            case(7){ day:=?"Sunday"; };
            case(_){};
        };

        return (day);
    };

    /*
        Write a function populate_array that takes an array [?Nat] and returns an array [Nat] where all null values have been replaced by 0.
        Note : Do not use a loop.   
    */
    public func populate_array(array:[?Nat]): async [Nat]{
        let modifier = func (n:?Nat): Nat {
            switch(n){
                case(null){
                    return 0;
                };
                case(?nat){
                    return nat;
                };
            };
        };
        
        return (Array.map<?Nat,Nat>(array, modifier));
    };

    /*
        Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
        Note : Do not use a loop.
    */
    public func sum_of_array(array:[Nat]): async Nat {
        let adder = func (n:Nat, m:Nat): Nat {
            return n+m;
        };

        return (Array.foldRight(array,0,adder));
    };

    /*
        Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
        Note : Do not use a loop.
    */
    public func squared_array(array:[Nat]): async [Nat]{
        let square = func(n:Nat): Nat {
            return (n*n);
        };

        return (Array.map(array,square));
    };

    /*
        Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
        Note : increase_by_index [1, 4, 8, 0] -> [1 + 0, 4 + 1 , 8 + 2 , 0 + 3] = [1,5,10,3]
        Note 2 : Do not use a loop.
    */
    public func increase_by_index (array : [Nat]): async [Nat]{
        let increase = func (a: Nat, i: Nat) : Nat {
            return (a + i);
        };

        return (Array.mapEntries(array,increase));
    };


    /*
        Write a higher order function contains<A> that takes 3 parameters :
        an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
        This function should return a boolean indicating whether or not a is present in the array.
    */

    public func testing(n:Nat): async Bool{
        return await _contain<Nat>( [1,2,3,4,5], n, _is_present);
    };

    private func _contain<A>(array:[A], a:A, f:<A>((A,A)) -> Bool): async Bool {
        /*if(f(a,a)){
            Debug.print("Found");
        } else {
            Debug.print("Not Found");
        };*/

        return (f(array[0],a));
    };

    let _is_present = func <A>(tuple:(A,A)): Bool {
        
        if(tuple.0 == tuple.1){
            return (true);
        };

        return (false);
    };
};