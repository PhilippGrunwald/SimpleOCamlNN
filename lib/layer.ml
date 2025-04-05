
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
  (* activation : activation; *)
}


let print_layer layer = 
  Printf.printf "\n--------Layer---------";
  Printf.printf "Inputs: %d" layer.inputs;
  Printf.printf "Outputs: %d" layer.outputs;
  Printf.printf "Weights:";
  Matrix.print_matrix layer.weights;
  Printf.printf "Biases:" ;
  Matrix.print_matrix layer.biases


let init_random ~inputs ~outputs = 
  {
  inputs = inputs;
  outputs = outputs;
  weights = Matrix.create_random outputs inputs (-1.0) 1.0;
  biases = Matrix.create_random outputs 1 (-1.0) 1.0;
  } 