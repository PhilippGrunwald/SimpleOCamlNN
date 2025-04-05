

type t = float array array 

let create n m value =
  Array.make_matrix n m value


let print_matrix matrix =
  Array.iter (fun row -> 
    Array.iter ( 
      fun element -> 
        Printf.printf "%.2f " element
        ) row; 
    print_newline()
  ) matrix

  
let set matrix i j value =
  matrix.(i).(j) <- value


let set_column matrix i column = 
  if List.length column <> Array.length matrix.(0) then
    failwith "column length does not match matrix dimension"
  else
  matrix.(i) <- Array.of_list column


let get matrix i j =
  matrix.(i).(j)


let num_rows matrix = 
  Array.length matrix


let num_cols matrix = 
  Array.length matrix.(0)
  

let map_matrix_inplace matrix f =
  for i = 0 to num_rows matrix - 1 do
    for j = 0 to num_cols matrix - 1 do
      set matrix i j (f @@ get matrix i j)
    done
  done
  
    
let create_random n m lower upper = 
  let matrix = create n m 0.0 in
  map_matrix_inplace matrix (fun _ ->  lower +. (Random.float (upper -. lower)));
  matrix


let multiply m n = 
  (* check that the two matrices can be multiplied *)
  let rows_m = num_rows m in
  let rows_n = num_rows n in
  let cols_m = num_cols m in
  let cols_n = num_cols n in
  
  if cols_m <> rows_n then
    failwith "Dimension of matrices do not match"
  else
    
  let result = create rows_m cols_n 0.0 in  
  for i = 0 to rows_m - 1 do
    for j = 0 to cols_n - 1 do
      let prod = ref 0. in
      for k = 0 to cols_m - 1 do
        prod := !prod +. (get m i k) *. (get n k j);
      done;
      set result i j !prod; 
    done;
  done;
  result


let transpose matrix = 
  let rows = num_rows matrix in
  let cols = num_cols matrix in
  let result = create cols rows 0.0 in
  for i = 0 to cols - 1 do 
    for j = 0 to rows - 1 do 
      set result i j (get matrix j i)
    done
  done;
  result

  
  
  