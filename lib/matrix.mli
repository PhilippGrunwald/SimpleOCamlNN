
type t 

val create : int -> int -> float -> t

val num_rows : t -> int

val num_cols : t -> int

val print_matrix : t -> unit

val set : t -> int -> int -> float -> unit

val set_row : t -> int -> float list -> unit

val set_column : t -> int -> float list -> unit

val get : t -> int -> int -> float

val map_matrix_inplace : (float -> float) -> t -> unit

val map_matrix : (float -> float) -> t -> t

val create_random : int -> int -> float -> float -> t

val add : t -> t -> t

val multiply : t -> t -> t

val multiply_first_transposed : t -> t -> t

val multiply_element_vise : t -> t -> t

val transpose : t -> t 