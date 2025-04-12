open SimpleOCamlNN

(* Last Timing: 61.402189 *)

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
      Matrix.set_column inputs 0 (List.map (fun x -> (float_of_int x) /. 255.) tail);
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


let get_index_of_max a = 
  if Matrix.num_rows a = 0 then
    failwith "Empty Array has no max element"
  else
  let max_ind = ref 0 in
  let max = ref @@ Matrix.get a 0 0 in
  for i = 1 to Matrix.num_rows a - 1 do
    if Matrix.get a i 0 > !max then begin
      max_ind := i;
      max := Matrix.get a i 0;
    end
  done;
  !max_ind

let benchmark nn data_test = 
  let rec aux n_correct = function
  | (inputs, label) :: tail -> begin
    let prediction_encoded = NN.predict nn inputs in
    let prediction = get_index_of_max prediction_encoded in
    let label_decoded = get_index_of_max label in
    if label_decoded = prediction then 
      aux (n_correct + 1) tail
    else
      aux n_correct tail
  end
  | [] -> n_correct
  in
  (float_of_int @@ aux 0 data_test) /. (float_of_int @@ List.length data_test)



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
  let data_test = parse_mnist "./data/mnist_test.csv" in

  

  (* let data_test parse_mnist "./data/mnist_test.csv"); *)
  print_endline "Data loaded!";
  print_endline "Creating NN...";

  let start = Unix.gettimeofday () in
  let nn = NN.create [
    Layer.create_random
      ~inputs:784
      ~outputs: 200
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
      ~outputs:20  
      ~activation:Activations.Sigmoid
      ~rand_min:(-1.0)
      ~rand_max:1.0;
    Layer.create_random
      ~inputs:20
      ~outputs:10  
      ~activation:Activations.Sigmoid
      ~rand_min:(-1.0)
      ~rand_max:1.0;
      ] 0.005 in

  print_endline "NN Created!";
  print_endline "Start trianing...";
  

  let accuracy = benchmark nn data_test in
  Printf.printf "\n\n\n--------- Acc --------\nAcc: %.4f\n\n\n" accuracy;
  flush stdout;
  for i = 0 to 20 do
    NN.train nn data_train 1;
    let accuracy = benchmark nn data_test in
    Printf.printf "\n\n\n--------- Acc %d --------\nAcc: %.4f\n\n\n" i accuracy;
    flush stdout;
  done;
  let stop = Unix.gettimeofday () in
  Printf.printf "Execution time: %f seconds\n" (stop -. start);

