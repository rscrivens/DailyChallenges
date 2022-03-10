import List "mo:base/List";
import Custom "custom";
import Animal "animal";
import li "list";

actor {
    var animal : ?Animal.Animal = null;
    var animal_list = List.nil<Animal.Animal>();

    public func fun(): async Custom.Dog {
        let my_dog : Custom.Dog = {
            name = "boba";
            breed = "chiweenie";
            age = 5;
        };

        return (my_dog);
    };

    /*
    In main.mo create a public function called create_animal_then_takes_a_break
    that takes two parameter : a specie of type Text, an number of energy point of type Nat and returns an animal.
    This function will create a new animal based on the parameters passed and then put this animal to sleep before returning
    */
    public func create_animal_then_takes_a_break(specie: Text, energy: Nat): async Animal.Animal{
        var animal : Animal.Animal = {
            specie = specie;
            energy = energy;
        };

        return (Animal.animal_sleep(animal));
    };

    /*
        In main.mo : create a function called push_animal that takes an animal as parameter and returns 
        nothing this function should add this animal to your list created in challenge 5. 
        Then create a second functionc called get_animals that takes no parameter but 
        returns an Array that contains all animals stored in the list.
    */
    public func push_animal(a:Animal.Animal): async (){
        animal_list := List.push<Animal.Animal>(a,animal_list);
        return ();
    };

    public func get_animals(): async [Animal.Animal]{
        return (List.toArray(animal_list));
    };

    public func test_is_null(array:[Nat]): async Bool {
        var l = List.nil<Nat>();
        for(n in array.vals()){
            l:= List.push<Nat>(n,l);
        };

        return li.is_null<Nat>(l);
    };

    public func test_get_last(array:[Nat]): async List.List<Nat> {
        var l = List.nil<Nat>();
        for(n in array.vals()){
            l:= List.push<Nat>(n,l);
        };

        return li.get_last<Nat>(l);
    };

    public func test_size(array:[Nat]): async Nat {
        var l = List.nil<Nat>();
        for(n in array.vals()){
            l:= List.push<Nat>(n,l);
        };

        return li.size<Nat>(l);
    };

    public func test_get_val(array:[Nat], n_rank:Nat): async ?Nat {
        var l = List.nil<Nat>();
        for(n in array.vals()){
            l:= List.push<Nat>(n,l);
        };

        return li.get_val_at_n<Nat>(l, n_rank);
    };
}