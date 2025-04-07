type t

val print_layer : t -> unit

val create_random : 
  inputs:int -> 
  outputs:int -> 
  activation:Activations.t -> 
  rand_min:float -> 
  rand_max:float -> t

val create_const : 
  inputs:int -> 
  outputs:int -> 
  activation:Activations.t -> 
  weight_init: float -> t

val num_inputs : t -> int

val num_outputs : t -> int

val feed_foreward : t -> Matrix.t -> Matrix.t





