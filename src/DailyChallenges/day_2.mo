import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

actor {
    public func nat_to_nat8(n:Nat) : async Nat8 {
        if (n > 255) {
            return (0);
        };

        let m : Nat8 = Nat8.fromNat(n);
        return (m);
    };

    public func max_number_with_n_bits(n:Nat) : async Nat {
        return (Nat.pow(2,n) - 1);
    };

    public func decimal_to_bits(n:Nat) : async Text {
        var val : Nat = n;
        var txt : Text = "";
        
        while(val >= 2){
            txt:= Nat.toText(val % 2) # txt;
            val:= val / 2;
        };

        txt:= Nat.toText(val) # txt;
        return txt;
    };

    public func capitalize_character(c:Char) : async Char {
        var capChar : Char = c;
        if(Char.isLowercase(capChar)){
            capChar:= Char.fromNat32(Char.toNat32(capChar) - 32);
        };

        return (capChar);
    };

    public func capitalize_text(t:Text) : async Text {
        var capText : Text = "";
        for(c in t.chars()){
            let capChar = await capitalize_character(c);
            capText:= capText # Char.toText(capChar);
        };

        return (capText);
    };

    public func is_inside(t:Text, c:Char) : async Bool {
        var found : Bool = false;

        label search for (char in t.chars()){
            if(char == c){
                found:= true;
                break search;
            };
        };

        return (found);
    };

    public func trim_whitespace(t:Text) : async Text {
        if(t.size() == 0){
            return (t);
        };

        var chars : [Char] = Iter.toArray(t.chars());
        var startIndex : Nat = 0;
        var endIndex : Nat = chars.size() - 1;

        while(startIndex < chars.size() and chars[startIndex] == ' ') {
            startIndex+=1;
        };

        while(endIndex > startIndex and chars[endIndex] == ' ') {
            endIndex-= 1;
        };
        endIndex+= 1;

        var trimmedText : Text = "";
        while(startIndex < endIndex){
            trimmedText:= trimmedText # Char.toText(chars[startIndex]);
            startIndex+=1;
        };

        return (trimmedText);
    };

    public func duplicated_character(t:Text) : async Text {
        var dup_char : Text = t;

        var index : Nat = 0;
        label outerloop for(c in t.chars()){
            var checkIndex: Nat = 0;
            if(not Char.isWhitespace(c)){
                for(d in t.chars()){
                    if(checkIndex > index){
                        if(c == d){
                            dup_char := Char.toText(c);
                            break outerloop;
                        };
                    };
                    checkIndex+=1;
                };
            };
            index+=1;
        };

        return (dup_char);
    };
    
    public func size_in_bytes(t:Text): async Nat {
        var size :Nat = 0;

        for(c in t.chars()){
            var bits: Text = await decimal_to_bits(Nat32.toNat(Char.toNat32(c)));
            size+=bits.size() / 8;
            if((bits.size() % 8) != 0){
                size+= 1;
            };
        };

        return (size);
    };

    public func bubble_sort(array : [Nat]): async [Nat]{
        var end_index : Nat = array.size();
        if(end_index <= 1 ){
            return array;
        } else{
            end_index-= 1;
        };        

        var mut_array : [var Nat] = Array.thaw(array);
        var did_swap : Bool = false;
        var index : Nat = 0;

        loop{
            did_swap:=false;
            loop{
                if(mut_array[index] > mut_array[index+1]){
                    let temp = mut_array[index];
                    mut_array[index]:=mut_array[index+1];
                    mut_array[index+1]:=temp;
                    did_swap:=true;
                };
                index+=1;
            }while(index < end_index);
            index:=0;
        }while(did_swap);

        return (Array.freeze(mut_array));
    };
};