

type t

val create : Layer.t list -> t

val num_inputs : t -> int
val num_outputs : t -> int
val get_layers : t -> Layer.t list
val predict : t -> Matrix.t -> Matrix.t