module {
    // Challenge 3
    public type Animal = {
        species: Text;
        enegy: Nat
    };
    public func animal_sleep(a: Animal) : Animal {
        var mut_a: Animal = {
            species = a.species;
            enegy = a.enegy + 10;
        };
        return mut_a;
    };

};