

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


let train nn inputs labels = 
  let outputs = predict  nn inputs in 
  let gradient =  Matrix.add outputs (Matrix.map_matrix (fun x -> -.x) labels) in
  propagate_backwards nn gradient;
  let rec aux = function 
    | h :: tail -> Layer.adjust_weights_sgd h nn.learning_rate; aux tail
    | [] -> ()
  in
  aux nn.layers


