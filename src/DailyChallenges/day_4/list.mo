import L "mo:base/List";
module {
    /*
        Write a function is_null that takes l of type List<T> and returns a boolean indicating if the list is null .
        Tips : Try using a switch/case.
    */
    public func is_null<T>(l:L.List<T>): Bool {
        switch(l){
            case(null){
                return true;
            };
            case(_){
                return false;
            };
        };
    };

    /*
        Write a function last that takes l of type List<T> and returns the optional last element of this list.
    */
    public func get_last<T>(l:L.List<T>): L.List<T> {
        var cur_l : L.List<T> = l;
        var next_l : L.List<T> = l;
        label search_loop loop{
            switch(next_l){
                case(null){
                    break search_loop;
                };
                case(?(_,next)){
                    cur_l:=next_l;
                    next_l:=next;
                };
            };
        };

        return (cur_l);
    };

    /*
        Write a function size that takes l of type List<T> and returns a Nat indicating the size of this list.
        Note : If l is null , this function will return 0.
    */
    public func size<T>(l:L.List<T>): Nat {
        var size:Nat = 0;
        var next_l : L.List<T> = l;
        label search_loop loop{
            switch(next_l){
                case(null){
                    break search_loop;
                };
                case(?(_,next)){
                    size+=1;
                    next_l:=next;
                };
            };
        };

        return (size);
    };

    /*
        Write a function get that takes two arguments : l of type List<T> and n of type Nat this function should return
        the optional value at rank n in the list.
    */
    public func get_val_at_n<T>(l:L.List<T>, n:Nat): ?T {
        var depth: Nat = 0;
        var val: ?T = null;
        var next_l : L.List<T> = l;
        label search_loop loop{
            switch(next_l){
                case(null){
                    break search_loop;
                };
                case(?(t,next)){
                    if(depth == n){
                        val:=?t;
                        break search_loop;
                    };
                    
                    depth+=1;
                    next_l:=next;
                };
            };
        };

        return (val);
    };
};