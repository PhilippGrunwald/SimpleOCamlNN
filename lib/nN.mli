

type t

val create : Layer.t list -> float -> t

val num_inputs : t -> int
val num_outputs : t -> int
val get_layers : t -> Layer.t list
val predict : t -> Matrix.t -> Matrix.t
val propagate_backwards : t -> Matrix.t -> unit
val train : t -> (Matrix.t * Matrix.t) list -> int -> unit