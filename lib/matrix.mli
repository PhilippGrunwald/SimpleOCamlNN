
type t

val create : int -> int -> float -> t

val print_matrix : t -> unit

val set : t -> int -> int -> float -> unit

val set_column : t -> int -> float list -> unit

val get : t -> int -> int -> float

val map_matrix_inplace : t -> (float -> float) -> unit

val create_random : int -> int -> float -> float -> t

val multiply : t -> t -> t

val transpose : t -> t 