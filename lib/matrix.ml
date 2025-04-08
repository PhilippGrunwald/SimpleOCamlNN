

type t = float array array 

let create n m value =
  Array.make_matrix m n value

let num_rows matrix = 
    Array.length matrix.(0)
  
  
let num_cols matrix = 
    Array.length matrix


let set matrix i j value =
  matrix.(j).(i) <- value




let set_row matrix i row = 
  if List.length row <> num_cols matrix then
    failwith "column length does not match matrix dimension"
  else
  if i >= num_rows matrix || i < 0 then
    failwith "The index of row is out of bounds"
  else
  let row_as_array = Array.of_list row in
  for j = 0 to (num_cols matrix) - 1 do
    set matrix i j row_as_array.(j)
  done

let set_column matrix i column = 
  if List.length column <> num_rows matrix then
    failwith "row length does not match matrix dimension"
  else
  if i >= num_cols matrix || i < 0 then
    failwith "The index of column is out of bounds"
  else
  matrix.(i) <- Array.of_list column


let get matrix i j =
  matrix.(j).(i)
    


let print_matrix matrix =
  let rows = num_rows matrix in
  let cols = num_cols matrix in
  for i = 0 to rows - 1 do
    for j = 0 to cols - 1 do
      Printf.printf "%.2f " (get matrix i j)
    done;
    print_newline()
  done

  

  

let map_matrix_inplace f matrix =
  for i = 0 to num_rows matrix - 1 do
    for j = 0 to num_cols matrix - 1 do
      set matrix i j (f @@ get matrix i j)
    done
  done

let map_matrix f matrix = 
  Array.map (Array.map f) matrix
  
    
let create_random n m lower upper = 
  let matrix = create n m 0.0 in
  map_matrix_inplace (fun _ ->  lower +. (Random.float (upper -. lower))) matrix;
  matrix


let add m n = 
  let rows_m = num_rows m in
  let rows_n = num_rows n in
  let cols_m = num_cols m in
  let cols_n = num_cols n in
  
  if cols_m <> cols_n || rows_m <> rows_n then
    failwith "Missmatch of dimensions in Matrix.add"
  else

  let result = create rows_m cols_m 0. in
  for i = 0 to rows_m - 1 do
    for j = 0 to cols_m -1 do
      set result i j @@ (get m i j ) +. (get n i j)
    done
  done;
  result



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


let multiply_first_transposed m n = 
  (* multiplication of m.T * n *)
  let rows_m = num_rows m in
  let rows_n = num_rows n in
  let cols_m = num_cols m in
  let cols_n = num_cols n in
  
  if rows_m <> rows_n then
    failwith "Dimension of matrices do not match"
  else
    
  let result = create cols_m cols_n 0.0 in  
  for i = 0 to cols_m - 1 do
    for j = 0 to cols_n - 1 do
      let prod = ref 0. in
      for k = 0 to rows_m - 1 do
        prod := !prod +. (get m k i) *. (get n k j);
      done;
      set result i j !prod; 
    done;
  done;
  result


let multiply_element_vise m n = 
  (* multiplication of m.T * n *)
  let rows_m = num_rows m in
  let rows_n = num_rows n in
  let cols_m = num_cols m in
  let cols_n = num_cols n in
  
  if rows_m <> rows_n || cols_m <> cols_n then
    failwith "Dimension of matrices do not match"
  else
    
  let result = create rows_m cols_m 0.0 in  
  for i = 0 to rows_m - 1 do
    for j = 0 to cols_m - 1 do
      (get m i j) *. (get n i j)
        |> set result i j
    done
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

  
  
  