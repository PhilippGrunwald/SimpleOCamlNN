type t = 
  | Tanh
  | Sigmoid
  | Relu
  | LeakyReLu
val tanh : float -> float
val sigmoid : float -> float
val relu : float -> float
val leaky_relu : float -> float
val get_activation_function : t -> (float -> float)

