
(* 
type activation = int
  (* | Tanh
  | Sigmoid
  | ReLu
  *)






type t = int {
  inputs : int;
  outputs : int;
  weights : Matrix.t;
  biases : Matrix.t;
  activation : activation;
}


let init ~inputs ~outputs ~activation = 
  {
  inputs;
  outputs;

  } *)