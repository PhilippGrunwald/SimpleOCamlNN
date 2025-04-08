

type t = {
  inputs: int;
  outputs: int;
  learning_rate: float;
  layers: Layer.t list;
}


let create layers learning_rate =
  (* TODOO implement some checks if the layers can build a proper network *)
  {
    inputs = List.hd layers |> Layer.num_inputs;
    outputs = List.hd (List.rev layers) |> Layer.num_outputs;
    learning_rate = learning_rate;
    layers = layers
  }

let num_inputs nn = 
  nn.inputs

let num_outputs nn = 
  nn.outputs

let get_layers nn = 
  nn.layers


let predict nn inputs =
  let rec aux layers inputs = 
    match layers with
      | head :: rest -> aux rest (Layer.feed_foreward head inputs)
      | [] -> inputs
  in
  aux nn.layers inputs


let propagate_backwards nn gradient = 
  let rec aux layers gradient = 
    match layers with
      | head :: rest -> aux rest (Layer.propagate_backwards head gradient)
      | [] -> gradient
  in
  ignore @@ aux (List.rev nn.layers) gradient


let train_one nn inputs labels = 
  let outputs = predict  nn inputs in 
  let gradient =  Matrix.add outputs (Matrix.map_matrix (fun x -> -.x) labels) in
  propagate_backwards nn gradient;
  let rec aux = function 
    | h :: tail -> Layer.adjust_weights_sgd h nn.learning_rate; aux tail
    | [] -> ()
  in
  aux nn.layers


let rec train nn training_data epochs =
  Printf.printf "Epochs to go: %d\n" epochs;
  flush stdout;
  let rec aux i = function
    | (input, label) :: tail -> begin
      train_one nn input label; 
      if i mod 100 = 0 then
        Printf.printf "Trained in epoch: %d\n" i;
        flush stdout;
      aux (i + 1) tail
    end
    | [] -> ()
  in
  if epochs >= 1 then
    aux 0 training_data;
    train nn training_data (epochs - 1)



