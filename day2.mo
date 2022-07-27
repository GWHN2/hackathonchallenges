import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Map "mo:base/HashMap";
import Nat8 "mo:base/Nat8";
import Prim "mo:prim";
import Text "mo:base/Text";
actor {
  //write a function decimal to bits that takes a nat n and returns a text corresponding to the binary representation of n.
  //for example, decimal_to_bits(255) should return "11111111".
  public func decimal_to_bits(n : Nat) : async Text {
    var m = n;
    var b = Buffer.Buffer<Char>(0);
    while (m > 0) {
      let r = m % 2;
      m := m / 2;
      if (r == 1) {
        b.add('1');
      } else {
        b.add('0');
      };
    };
    let arr: [Char] = Array.reverse(b.toArray());
    var s = Text.fromIter(Iter.fromArray(arr));
    return s;
  };
  public func capitalize_character(c : Char) : async Char {
    if (c == 'a') {
      return 'A';
    } else if (c == 'b') {
      return 'B';
    } else if (c == 'c') {
      return 'C';
    } else if (c == 'd') {
      return 'D';
    } else if (c == 'e') {
      return 'E';
    } else if (c == 'f') {
      return 'F';
    } else if (c == 'g') {
      return 'G';
    } else if (c == 'h') {
      return 'H';
    } else if (c == 'i') {
      return 'I';
    } else if (c == 'j') {
      return 'J';
    } else if (c == 'k') {
      return 'K';
    } else if (c == 'l') {
      return 'L';
    } else if (c == 'm') {
      return 'M';
    } else if (c == 'n') {
      return 'N';
    } else if (c == 'o') {
      return 'O';
    } else if (c == 'p') {
      return 'P';
    } else if (c == 'q') {
      return 'Q';
    } else if (c == 'r') {
      return 'R';
    } else if (c == 's') {
      return 'S';
    } else if (c == 't') {
      return 'T';
    } else if (c == 'u') {
      return 'U';
    } else if (c == 'v') {
      return 'V';
    } else if (c == 'w') {
      return 'W';
    } else if (c == 'x') {
      return 'X';
    } else if (c == 'y') {
      return 'Y';
    } else if (c == 'z') {
      return 'Z';
    } else {
      return c;
    };
  };
  public func capitalize_text(t:Text) : async Text{
    return Text.map(t, Prim.charToUpper);
  };
  //Write a function is_inside that takes two arguments : a Text t and a Char c and returns a Bool indicating if c is inside t .
  //for example, is_inside("abc", 'a') should return true.

  public func is_inside(t : Text, c : Char) : async Bool {
    for(char in t.chars()){
      if(Char.equal(char, c)){
        return true;
      };
    };
    return false;
  };
  //Write a function trim_whitespace that takes a text t and returns the trimmed version of t. Note : Trim means removing any leading and trailing spaces from the text : trim_whitespace(" Hello ") -> "Hello".
  public func trim_whitespace(t : Text) : async Text {
    var text = "";
    for(char in t.chars()){
      if(Char.notEqual(char, ' ')){
        text #= Text.fromChar(char);
      };
    };
    return text;
  };
  //Write a function duplicated_character that takes a Text t and returns the first duplicated character in t converted to Text. Note : The function should return the whole Text if there is no duplicate character : duplicated_character("Hello") -> "l" & duplicated_character("World") -> "World".
  public func duplicated_character(t : Text) : async Text {
    var text = "";
    var count = 0;
    var char = "";
    for(char in t.chars()){
      count := 0;
      for(char2 in t.chars()){
        if(Char.equal(char, char2)){
          count := count + 1;
        };
      };
      if(count > 1){
        return Text.fromChar(char);
      };
    };
    return text;
  };
  //Write a function size_in_bytes that takes Text t and returns the number of bytes this text takes when encoded as UTF-8.
  public func size_in_bytes(t : Text) : async Nat {
    var count = 0;
    for(char in t.chars()){
      count := count + 1;
    };
    return count;
  };

  //implement a function bubble_sort that takes an array of natural numbers and returns the sorted array .
  public func bubble_sort(arr : [Nat]) : async [Nat] {
    let mut_arr : [var Nat] = Array.thaw(arr);
    let size = mut_arr.size();
    for(i in Iter.range(0, size-2)){
      for(j in Iter.range(0, size - i - 2)){
        if(mut_arr[j] > mut_arr[j+1]){
          let temp = mut_arr[j];
          mut_arr[j] := mut_arr[j+1];
          mut_arr[j+1] := temp;
        };
      };
    };
    return Array.freeze(mut_arr);
  };
  public func nat_opt_to_nat(m : Nat, n : ?Nat) : async Nat{
    switch(n){
      case (? number){
        return number;
      };
      case (null){
        return m;
      };
    };
  };
  public func day_of_the_weeks(n : Nat) : async ?Text{
    do ?{
    switch(n){
      case (1){
        "Monday"
      };
      case (2){
        "Tuesday"
      };
      case (3){
        "Wednesday"
      };
      case (4){
        "Thursday"
      };
      case (5){
        "Friday"
      };
      case (6){
        "Saturday"
      };
      case (7){
        "Sunday"
      };
      case (_){
        null !
      };
    };
    };
  };
  //write function populate_array that takes an array [?Nat] and returns an array[Nat] where all null values have been replaced by 0.
  public func populate_array(arr : [?Nat]) : async [Nat]{
    return Array.map<?Nat,  Nat>(arr, func(n){
      switch(n){
        case (? n){
          return n;
        };
        case (null){
          return 0;
        };
      };
    });
  };
  //Write a function sum_of_array that takes an array [Nat] and returns the sum of a values in the array.
  //Note : Do not use a loop.
  public func sum_of_array(arr : [Nat]) : async Nat{
    return Array.foldLeft<Nat, Nat>(arr, 0 ,func(x: Nat, y:Nat): Nat{x+y})
  };
  //Write a function squared_array that takes an array [Nat] and returns a new array where each value has been squared.
  //Note : Do not use a loop.
  public func squared_array(arr : [Nat]) : async [Nat]{
    return Array.map<Nat,Nat>(
      arr,
      func(x: Nat){Nat.pow(x,2)}
    )
  };
  //Write a function increase_by_index that takes an array [Nat] and returns a new array where each number has been increased by it's corresponding index.
  //Note : increase_by_index [1, 4, 8, 0] -> [1 + 0, 4 + 1 , 8 + 2 , 0 + 3] = [1,5,10,3]
  //Note 2 : Do not use a loop.
  public func increase_by_index(arr : [Nat]) : async [Nat]{
    return Array.mapEntries<Nat,Nat>(
      arr,
      func(x: Nat, i:Nat){x+i}
    )
  };
  //Write a higher order function contains<A> that takes 3 parameters : an array [A] , a of type A and a function f that takes a tuple of type (A,A) and returns a boolean.
  //This function should return a boolean indicating whether or not a is present in the array.
  //For example, contains([1,2,3], 2, (a,b) => a == b) should return true.
  public func contains<A>(arr : [A], a : A, f : (A, A) -> Bool) : Bool{
    let array = Array.thaw<A>(arr);
    for(value in array.vals()){
      if(f(value, a)){
        return true;
      };
    };
    return false;
  };
};