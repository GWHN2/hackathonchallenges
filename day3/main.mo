import Array "mo:base/Array";
import Char "mo:base/Char";
import Int "mo:base/Int";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycle "mo:base/ExperimentalCycles";
import Animal "animal";
import Favorite_type "custom";
import module_list "list";


actor {
    // Challenge 1
    public type My_favorite = Favorite_type.Favorite_type;
    public func fun() : async My_favorite {
        let my_favorite: My_favorite = {
            body = "slim";
            size = "small";
            spicies = "Japanese"
        };
        return my_favorite;
    };
    

    // Challenge 2
    public type Animal = Animal.Animal;

    // Challenge 3 

    // Challenge 4
    public func create_animal_then_takes_a_break(s: Text, e: Nat) : async Animal {
        let animal: Animal = {
            species = s;
            energy = e;
        };
        let animal_sleep = Animal.animal_sleep(animal);
        return animal_sleep;
    };

    // Challenge 5
    public type List<Animal> = ?(Animal, List<Animal>); 
    var list_animals = List.nil<Animal>();
    
    public func sample(l : List<Animal>) : async List<Animal> {
        let animal: Animal = {
            species = "cat";
            energy = 10;
        };
        return List.push(animal, l);    
    };

    // Challenge 6
    public func push_animal(a: Animal) : async () {
        list_animals := List.push(a, list_animals);
    };
    public func get_animals() : async [Animal] {
        let array_animals = List.toArray(list_animals);
        return array_animals;
    };

    
    // Challenge 11
    public shared({caller}) func is_anonymous() : async Bool {
        let anonymous_principal: Text = "2vxsx-fae";
        if (Principal.toText(caller) == anonymous_principal) return true;
        return false;
    };

    // Challenge 12
    var favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // Challenge 13
    public shared({caller}) func add_favorite_number1(n: Nat) : async () {
        favoriteNumber.put(caller, n); 
    };
    public shared({caller}) func show_favorite_number() : async ?Nat {
        let num = favoriteNumber.get(caller);
        switch(num){
            case(null) return null;
            case(_) return num;
        };
    };

    // Challenge 14
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

    // Challenge 15
    public shared({caller}) func update_favorite_number(n: Nat) : async Text {
        let val = await show_favorite_number();
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

    // Challenge 16
    public shared({caller}) func deposit_cycles() : async Nat {
        let available = Cycle.available();
        return Cycle.accept(available);
    };

    // Challenge 17
    let other_canister : actor {deposit_cycles : () -> async Nat} = actor("CANISTER_ID"); //from deposit_cycles canister
    private func withdraw_cycles(n: Nat) : async Nat {
        Cycle.add(n);
        await other_canister.deposit_cycles(); 
    };
    
    // Challenge 18
    private stable var version_number : Nat = 0;
    system func preupgrade() {
        version_number += 1;
    };
    public func get_version() : async Nat {
        return version_number;
    };

};