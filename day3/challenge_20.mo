import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycle "mo:base/ExperimentalCycles";
import Iter "mo:base/Iter";

actor Challenge_10 {
    /*
    register your (Canister's) principal ID
    read
    update
    delete
    you get Cycle from owner when register
    no anonymous principal
    actor's admin is caller
    */

    // hashMap for register
    var registerPrincipal = HashMap.HashMap<Principal, Principal>(0, Principal.equal, Principal.hash);

    // create
    public shared({caller}) func create(principal: Principal, n: Nat): async Bool { 
        assert no_anonymous_principal(principal);       
        registerPrincipal.put(caller, principal);
        await withdraw_cycles(n);                      // give Cycle to register Canister(principal ID) only once
        for (v in registerPrincipal.vals()){
            if (v == principal) return true;
        };
        return false;
    };

    // read
    public shared({caller}) func read(principal: Principal): async Bool {        
        for (v in registerPrincipal.vals()){
            if (v == principal) return true;
        };
        return false;
    };

    // update
    public shared({caller}) func update(principal: Principal): async ?Principal {        
        let update = registerPrincipal.replace(caller, principal);
        for (v in registerPrincipal.vals()){       // any way to iter??
            if (v == principal) return ?principal;
        };
        switch (?update) {
            case(?null) return null; // no update in case of no principal
            case(_) return update;  // no update in case of a same principal
        };
    };

    // delete NOTICE: be careful to use
     public shared({caller}) func delete(): async () {        
        registerPrincipal.delete(caller);
    };

    // no anonymous principal
    private func no_anonymous_principal(principal: Principal): Bool {
        let anonymous_principal: Text = "2vxsx-fae";
        if (Principal.toText(principal) == anonymous_principal) return true;
        return false;
    };

    // pay Cycles
    public shared({caller}) func withdraw_cycles(n: Nat) : async () {
        Cycle.add(n);
        await credit(); 
    };
    // callback,but no principal(on checking...)
    public func credit() : async () {
        let available = Cycle.available();
        let accepted = Cycle.accept(available);
        assert (accepted == available);
    };
    
};