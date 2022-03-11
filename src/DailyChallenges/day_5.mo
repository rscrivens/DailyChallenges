import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Cycles "mo:base/ExperimentalCycles";

actor {
    /*
        Write a function is_anonymous that takes no arguments but returns true is the caller is anonymous and
        false otherwise.
    */
    public shared(msg) func is_anonymous() : async Bool {
        var is_anon : Bool = false;
        if(Principal.toText(msg.caller) == "2vxsx-fae"){
            is_anon:= true;
        };

        return (is_anon);
    };

    /*
    Create an HashMap called favoriteNumber where the keys are Principal and the value are Nat.
    */
    let favoriteNumber: HashMap.HashMap<Principal,Nat> = HashMap.HashMap<Principal,Nat>(0, Principal.equal, Principal.hash);

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
                return ("You've already registered your number");
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

    /*
        Write a function deposit_cycles that allow anyone to deposit cycles into the canister.
        This function takes no parameter but returns n of type Nat corresponding to the amount of cycles deposited by the call.
    */
    public func deposit_cycles(): async Nat {
        let deposit_amount : Nat = 100;
        if(Cycles.available() < deposit_amount){
            return (0);
        };

        return (Cycles.accept(deposit_amount));
    };

    /*
        Write a function withdraw_cycles that takes a parameter n of type Nat corresponding to the number of cycles you want to 
        withdraw from the canister and send it to caller asumming the caller has a callback called deposit_cycles()
        Note : You need two canisters.
        Note 2 : Don't do that in production without admin protection or your might be the target of a cycle draining attack.
    */

    /*
        Rewrite the counter (of day 1) but this time the counter will be kept accross ugprades.
        Also declare a variable of type Nat called version_number that will keep track of how many times your canister has been upgraded.
    */
    private stable var counter : Nat = 0;
    private stable var version_number : Nat = 0;
    public func increment_counter(n:Nat) : async Nat {
        counter+= n;
        return (counter);
    };

    public func clear_counter() {
        counter := 0;
    };

    public func version() : async Nat {
        return (version_number);
    };

    system func preupgrade() {
        
    };

    system func postupgrade() {
        version_number+= 1;
    };
};