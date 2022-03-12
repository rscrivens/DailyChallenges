import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Iter "mo:base/Iter";
import List "mo:base/List";

actor {
    /*
        Create an actor in main.mo and declare the following types.

        TokenIndex of type Nat.
        Error which is a variant type with multiples tags :
    */
    type TokenIndex = Nat;
    type Error = {
        #anonymouscaller;
        #err2;
        #err3;
    };

    stable var registryEntries: [(TokenIndex, Principal)] = [];
    /*
        Declare an HashMap called registry with Key of type TokenIndex and value of type Principal.
        This will keeep track of which principal owns which TokenIndex.
    */
    let registry: HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex,Principal>(0,Nat.equal,Hash.hash);

    /*
        Declare a variable of type Nat called nextTokenIndex, initialized at 0 that will keep track of the number of minted NFTs.
        Write a function called mint that takes no argument.
        This function should :

        Returns a result of type Result and indicate an error in case the caller is anonymous.
        If the user is authenticated : associate the current TokenIndex with the caller (use the HashMap we've created) and 
        increase nextTokenIndex.
    */
    var nextTokenIndex: Nat = 0;

    public shared(msg) func  mint() : async Result.Result<(),Text> {
        if(Principal.toText(msg.caller) == "2vxsx-fae") {
            return #err("You need to log in to mint.");
        };

        registry.put(nextTokenIndex, msg.caller);
        nextTokenIndex+= 1;
        return #ok();
    };

    /*
        Write a function called transfer that takes two arguments :

            to of type Principal.
            tokenIndex of type Nat.
        This function will transfer ownership of tokenIndex to the specified principal.
        You will check for eventuals errors and returns a result of type Result.
    */
    public shared(msg) func transfer(to: Principal, tokenIndex: Nat) : async Result.Result<(), Text> {
        if(Principal.toText(msg.caller) == "2vxsx-fae") {
            return #err("You need to log in to transfer.");
        };

        let curOwner = registry.get(tokenIndex);
        switch(curOwner){
            case(null) {
                return #err("That token doesn't have an owner.");
            };
            case (?p){
                if(Principal.toText(p) != Principal.toText(msg.caller)){
                    return #err("You don't own this token.");
                };

                registry.put(tokenIndex, p);
                return #ok();
            };
        };
    };

    /*
        Write a function called balance that takes no arguments but returns a list of tokenIndex owned by the called.
    */
    public shared(msg) func balance(): async List.List<TokenIndex>{
        let owned_tokens : List.List<TokenIndex> = null;

        if(Principal.toText(msg.caller) == "2vxsx-fae") {
            return owned_tokens;
        };

        return owned_tokens;
    };

    /*
        Write a function called http_request that should return a message indicating the number of nft minted so far and
        the principal of the latest minter.
        (Use the section on http request in the daily guide).
    */
    

    system func preupgrade() {
        registryEntries := Iter.toArray(registry.entries());
    };

    system func postupgrade() {
        registryEntries := [];
    };
}