


type t = 
  | Tanh
  | Sigmoid
  | Relu
  | LeakyReLu



let tanh x = 
  Float.tanh x

let sigmoid x = 
  1.0 /. (1.0 +. Float.exp(-.x))

let relu x = 
  if x > 0. then x else 0.

let leaky_relu x = 
  if x > 0. then x else 0.01 *. x

let get_activation_function = function
  | Tanh -> tanh
  | Sigmoid -> sigmoid
  | Relu -> relu
  | LeakyReLu -> leaky_relu