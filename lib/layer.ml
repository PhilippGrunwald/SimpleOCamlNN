
(* 
type activation = int
  | Tanh
  | Sigmoid
  | ReLu
  *)


type t =  {
  inputs : int;
  outputs : int;
  weights : Matrix.t;
  biases : Matrix.t;
  activation : (float -> float);
  activation_derivative : (float -> float);
  mutable last_output : Matrix.t;
  mutable last_input : Matrix.t;
  mutable gradient : Matrix.t;
  mutable last_net_output : Matrix.t;
}


let print_layer layer = 
  Printf.printf "\n--------Layer---------\n";
  Printf.printf "Inputs: %d\n" layer.inputs;
  Printf.printf "Outputs: %d\n" layer.outputs;
  Printf.printf "Weights:\n";
  Matrix.print_matrix layer.weights;
  Printf.printf "Biases:\n" ;
  Matrix.print_matrix layer.biases;
  print_newline();
  print_newline()


let create_random ~inputs ~outputs ~activation ~rand_min ~rand_max = 
  {
    inputs = inputs;
    outputs = outputs;
    weights = Matrix.create_random outputs inputs rand_min rand_max;
    biases = Matrix.create_random outputs 1 rand_min rand_max;
    activation = Activations.get_activation_function activation;
    activation_derivative = Activations.get_activation_function_der activation;
    last_output = Matrix.create outputs 1 0.;
    last_net_output = Matrix.create outputs 1 0.;
    last_input = Matrix.create inputs 1 0.;
    gradient = Matrix.create inputs 1 0.;
  }

let create_const ~inputs ~outputs ~activation ~weight_init = 
  {
    inputs = inputs;
    outputs = outputs;
    weights = Matrix.create outputs inputs weight_init;
    biases = Matrix.create outputs 1 weight_init;
    activation = Activations.get_activation_function activation;
    activation_derivative = Activations.get_activation_function_der activation;
    last_output = Matrix.create outputs 1 0.;
    last_net_output = Matrix.create outputs 1 0.;
    last_input = Matrix.create inputs 1 0.;
    gradient = Matrix.create inputs 1 0.;
  }

let num_inputs layer =
  layer.inputs

let num_outputs layer = 
  layer.outputs

let get_last_output layer = 
  layer.last_output

let get_last_input layer = 
  layer.last_input

let get_gradient layer = 
  layer.gradient


let feed_foreward layer inputs = 
  layer.last_input <- inputs;
  let net_output = inputs
    |> Matrix.multiply layer.weights
    |> Matrix.add layer.biases in
  layer.last_net_output <- net_output;
  layer.last_output <- 
    net_output |> Matrix.map_matrix layer.activation;
  layer.last_output


let propagate_backwards layer gradient = 
  (* Printf.printf "TODOO: Add derivative of activation functions!!"; *)
  layer.gradient <- gradient;
  gradient 
    |> Matrix.multiply_element_vise (Matrix.map_matrix layer.activation_derivative layer.last_net_output)
    |> Matrix.multiply_first_transposed layer.weights  
