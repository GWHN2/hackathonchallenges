import Array "mo:base/Array";
actor {
  public func greet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };
  public func add(number1 : Nat, number2: Nat) : async Nat {
    return number1 + number2;
  };
  public func subtract(number1 : Nat, number2: Nat) : async Nat {
    return number1 - number2;
  };
  public func area_square(side : Nat) : async Nat {
    return side * side;
  };
  public func days_to_seconds(days : Nat) : async Nat {
    return days * 24 * 60 * 60;
  };
  public func increment_counter(counter : Nat) : async Nat {
    return counter + 1;
  };
  public func clear_counter(counter : Nat) : async Nat {
    return 0;
  };
  public func divide(number1 : Nat, number2: Nat) : async Nat {
    return number1 / number2;
  };
  public func is_even(number : Nat) : async Bool {
    return number % 2 == 0;
  };
  public func sum_of_array(array : [Nat]) : async Nat {
    var sum = 0;
    for(value in array.vals()){
      sum+= value;
    };
    return sum;
  };
  public func remove_element_array(array : [Nat], element : Nat) : async [Nat] {
    var new_array : [Nat] = [];
    for(value in array.vals()){
      if(value != element){
        new_array := Array.append<Nat>(new_array, [value]);
      };
    };
    return (new_array);
  };
  public func maximum_array(array : [Nat]) : async Nat {
    var max = 0;
    for(value in array.vals()){
      if(value > max){
        max := value;
      };
    };
    return max;
  };
  
  public func selection_sort(array : [Nat]) : async [Nat] {
    let new_array : [var Nat] = Array.thaw(array);
    var i : Nat = 0;
    let n : Nat = new_array.size();
    while(i < n - 1) {
      var min_i = i;
      var  j = i + 1;
      while(j < n) {
        if(new_array[j] < new_array[min_i]) {
          min_i := j;
        };
        j+=1;
      };
      let temp : Nat = new_array[min_i];
      new_array[min_i] := new_array[i];
      new_array[i] := temp;

      i+=1;
    };
    return Array.freeze(new_array);
  };
};