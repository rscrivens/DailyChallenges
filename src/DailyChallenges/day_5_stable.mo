import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";

actor {
    /*
    Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    */
    stable var favorite_nums_stable: [(Principal, Nat)] = [];
    let favoriteNumber: HashMap.HashMap<Principal,Nat> = HashMap.fromIter<Principal,Nat>(favorite_nums_stable.vals(), 0, Principal.equal, Principal.hash);

    /*
        add_favorite_number that takes n of type Nat and stores this value in the HashMap where the key is the principal of the caller.
        This function has no return value.
        
        show_favorite_number that takes no argument and returns n of type ?Nat, 
        n is the favorite number of the person as defined in the previous function or null if the person hasn't registered.

        Rewrite your function add_favorite_number so that if the caller has already registered his favorite number,
        the value in memory isn't modified. This function will return a text of type Text that indicates
        "You've already registered your number" in that case and "You've successfully registered your number" in the other scenario.
    */
    public shared({caller}) func add_favorite_number(n:Nat): async Text {
        let existing_n : ?Nat = favoriteNumber.get(caller);
        switch(existing_n){
            case(null){
                favoriteNumber.put(caller, n);
                return ("You've successfully registered your number");
            };
            case(_) {
                return ("You've already registered your numbe");
            };
        };
    };

    public shared({caller}) func show_favorite_number(): async ?Nat {
        return (favoriteNumber.get(caller));
    };

    /*
        update_favorite_number
        delete_favorite_number
    */
    public shared({caller}) func update_favorite_number(n: Nat): async Text {
        let existing_n : ?Nat = favoriteNumber.get(caller);
        switch(existing_n){
            case(null){
                return ("You've never registered your number");
            };
            case(_) {
                favoriteNumber.put(caller, n);
                return ("You've updated your number");
            };
        };
    };

    public shared({caller}) func delete_favorite_number(): async Text {
        let existing_n : ?Nat = favoriteNumber.get(caller);
        switch(existing_n){
            case(null){
                return ("You've never registered your number");
            };
            case(_) {
                favoriteNumber.delete(caller);
                return ("You've deleted your number");
            };
        };
    };

    system func preupgrade() {
        favorite_nums_stable := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        favorite_nums_stable := [];
    };
};