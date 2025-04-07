

type t = {
  inputs: int;
  outputs: int;
  layers: Layer.t list;
}


let create layers =
  (* TODOO implement some checks if the layers can build a proper network *)
  {
    inputs = List.hd layers |> Layer.num_inputs;
    outputs = List.hd (List.rev layers) |> Layer.num_outputs;
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
