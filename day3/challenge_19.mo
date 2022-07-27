import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycle "mo:base/ExperimentalCycles";
import Iter "mo:base/Iter";

actor {
    private stable var _state : [(Principal, Nat)] = [];

    system func preupgrade() {
        _state := Iter.toArray(favoriteNumber.entries());
    };
    system func postupgrade() {
        _state := [];
    };

    
    public shared({caller}) func is_anonymous() : async Bool {
        let anonymous_principal: Text = "2vxsx-fae";
        if (Principal.toText(caller) == anonymous_principal) return true;
        return false;
    };

    
    var favoriteNumber : HashMap.HashMap<Principal, Nat> = HashMap.fromIter(_state.vals(), 0, Principal.equal, Principal.hash);

    
    public shared({caller}) func add_favorite_number1(n: Nat) : async () {
        return favoriteNumber.put(caller, n); 
    };
    public shared({caller}) func show_favorite_number() : async ?Nat {
        let num = favoriteNumber.get(caller);
        switch(num){
            case(null) return null;
            case(_) return num;
        };
    };

    
    public shared({caller}) func add_favorite_number2(n: Nat) : async Text {
        let num = await show_favorite_number();
        switch(?num){
            case(?null){
                favoriteNumber.put(caller, n);
                return "You've successfully registered your number";
            };
            case(_){
                return "You've already registered your number";
            };
        };    
    };

    
    public shared({caller}) func update_favorite_number(n: Nat) : async Text {
        let val = show_favorite_number();
        switch (?val){
            case(?null) return "there is no this key's value";
            case(_) {
                let before_update = favoriteNumber.replace(caller, n);
                let after_update = favoriteNumber.get(caller);
                return "update done";
            };
        };
    };
    public shared({caller}) func delete_favorite_number() : async Text {
        favoriteNumber.delete(caller);
        return "delete!";
    };
    
    
};