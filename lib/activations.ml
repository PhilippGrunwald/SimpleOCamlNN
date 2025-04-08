type t = 
  | Tanh
  | Sigmoid
  | Relu
  | LeakyReLu


let tanh x = 
  Float.tanh x

let tanh_der x = 
  let cosh_x = Float.cosh x in
  1.0 /. (cosh_x *. cosh_x)

let sigmoid x = 
  1.0 /. (1.0 +. Float.exp(-.x))

let sigmoid_der x = 
  let e_minus_x = Float.exp(-.x) in
  e_minus_x /. ((e_minus_x +. 1.) *. (e_minus_x +. 1.))

let relu x = 
  if x > 0. then x else 0.

let relu_der x = 
  if x > 0. then 1.0 else 0.

let leaky_relu x = 
  if x > 0. then x else 0.01 *. x

let leaky_relu_der x = 
  if x > 0. then 1. else 0.01

  
let get_activation_function = function
  | Tanh -> tanh
  | Sigmoid -> sigmoid
  | Relu -> relu
  | LeakyReLu -> leaky_relu

let get_activation_function_der = function
  | Tanh -> tanh_der
  | Sigmoid -> sigmoid_der
  | Relu -> relu_der
  | LeakyReLu -> leaky_relu_der