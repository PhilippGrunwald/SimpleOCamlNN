open SimpleOCamlNN


let parse_mnist filename = 
  let split_csv_line line =
    let rec aux i j acc =
      if j >= String.length line then
        (* Add the last field *)
        List.rev ((String.sub line i (j - i)) :: acc)
      else if line.[j] = ',' then
        let field = String.sub line i (j - i) in
        aux (j + 1) (j + 1) (field :: acc)
      else
        aux i (j + 1) acc
    in
    let splitted_list = List.map int_of_string (aux 0 0 []) in 
    (* Printf.printf "%d\n" (List.length splitted_list); *)
    match splitted_list with
    | h :: tail -> begin
      let label = Matrix.create 10 1 0.0 in
      Matrix.set label h 0 1.0;
      let inputs = Matrix.create 784 1 0.0 in
      Matrix.set_column inputs 0 (List.map float_of_int tail);
      (inputs, label)
    end
    | [] -> failwith "Weird Error"
  in

  let ic = open_in filename in
  let rec aux acc = 
    try
      let line = input_line ic in
      aux (split_csv_line line :: acc)
    with End_of_file -> 
      close_in ic;
      List.rev acc
  in
  aux []



let () = 
  (* let m = Matrix.create 2 3 0. in
  Matrix.set_column m 0 [1.; 2.; 3.;];
  Matrix.set_column m 1 [0.; 2.; 0.;];
  let n = Matrix.create 3 4 0. in
  Matrix.set_column n 0 [1.; 2.; 3.; -1.];
  Matrix.set_column n 1 [0.; 2.; 0.; 2.];
  Matrix.set_column n 2 [1.; -2.; 0.; 3.];
  Matrix.print_matrix ( Matrix.multiply m n); *)
  print_endline "Start loading the data...";
  let data_train = parse_mnist "./data/mnist_train.csv" in
  (* let data_test parse_mnist "./data/mnist_test.csv"); *)
  print_endline "Data loaded!";
  print_endline "Creating NN...";

  let nn = NN.create [
    Layer.create_random
      ~inputs:784
      ~outputs:200 
      ~activation:Activations.Sigmoid 
      ~rand_min:(-1.0)
      ~rand_max:1.0;
    Layer.create_random
      ~inputs:200
      ~outputs:80  
      ~activation:Activations.Sigmoid 
      ~rand_min:(-1.0)
      ~rand_max:1.0;
    Layer.create_random
      ~inputs:80
      ~outputs:10 
      ~activation:Activations.Sigmoid 
      ~rand_min:(-1.0)
      ~rand_max:1.0;
      ] 0.001 in

  print_endline "NN Created!";
  print_endline "Start trianing...";
  NN.train nn data_train 4;

