
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


let init_random ~inputs ~outputs ~activation ~rand_min ~rand_max = 
  {
    inputs = inputs;
    outputs = outputs;
    weights = Matrix.create_random outputs inputs rand_min rand_max;
    biases = Matrix.create_random outputs 1 rand_min rand_max;
    activation = Activations.get_activation_function activation;
  }

let init_const ~inputs ~outputs ~activation ~weight_init = 
  {
    inputs = inputs;
    outputs = outputs;
    weights = Matrix.create outputs inputs weight_init;
    biases = Matrix.create outputs 1 weight_init;
    activation = Activations.get_activation_function activation;
  }



let feed_foreward layer inputs = 
  let output = Matrix.multiply layer.weights inputs in
  let output_with_biases = Matrix.add output layer.biases in
  Matrix.map_matrix_inplace output_with_biases layer.activation;
  output_with_biases
  
