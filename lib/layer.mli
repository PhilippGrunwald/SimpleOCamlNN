type t

val print_layer : t -> unit

val init_random : 
  inputs:int -> 
  outputs:int -> 
  activation:Activations.t -> 
  rand_min:float -> 
  rand_max:float -> t

val init_const : 
  inputs:int -> 
  outputs:int -> 
  activation:Activations.t -> 
  weight_init: float -> t

  val feed_foreward : t -> Matrix.t -> Matrix.t





