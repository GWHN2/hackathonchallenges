import Iter "mo:base/Iter";
import Int "mo:base/Int";
import Array "mo:base/Array";
import Option "mo:base/Option";

module list {
    // Challenge 7
    public type List<T> = ?(T, List<T>);
    public func is_null<T>(l: List<T>) : Bool {
        switch(l) {
            case(null) {true};
            case(_) {false};
        };
    };

    // Challenge 8 
    public func last<T>(l: List<T>) : ?T {
        var x = l;
        while (is_null<T>(x) == false) {
            switch (x) {
                case (null) return null;
                case (?(last, null)) {return ?last};
                case (?(_, r)) {x := r};
            };
        };
        return null;
    };

    // Challenge 9
    public func size<T>(l: List<T>) : Nat {
        var n: Nat = 0;
        var x = l;
        while (is_null<T>(l) == false) {
            switch(x){
                case (null) {return n;};
                case(?(last, null)) {n += 1; return n;};
                case(?(_, r)) {x := r; n += 1;};             
            };
        };
        return n;
    };

    // Challenge 10
    public func get<T>(l: List<T>, n: Nat) : ?T {
        var x = l;
        var i: Nat = 0;
        while (is_null<T>(l) == false) {            
            switch(x){
                case (null) {
                    return null;
                };
                case(?(list, null)) {
                    if (i == n){
                        return ?list;
                    };
                    x := null;
                };
                case(?(v, r)) {
                    if (i == n){
                        return ?v;
                    };
                    x := r;
                    i += 1;
                };             
            };
        };
        return null;
    };

    // Challenge 11
    public func reverse<T>(l: List<T>) : List<T> {
        var reverse_list: List<T> = null;
        let length: Int = size(l);
        for (i in Iter.range(0, length-1)) {
            let get_v = get(l, Int.abs(i));
            switch (get_v) {
                case(null) ();
                case(?v) {
                    let immut_get_v = Option.get(get_v, v);
                    reverse_list := ?(immut_get_v, reverse_list);
                };
            };   
        };        
        return reverse_list;
    };
    
};