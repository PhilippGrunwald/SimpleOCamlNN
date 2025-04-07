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

val get_last_input : t -> Matrix.t

val get_last_output : t -> Matrix.t

val get_gradient : t -> Matrix.t

val feed_foreward : t -> Matrix.t -> Matrix.t

val propagate_backwards : t -> Matrix.t -> Matrix.t





