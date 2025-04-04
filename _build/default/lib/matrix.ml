

type t = float array array 

let create n m value =
  Array.make_matrix n m value


let print_matrix matrix =
  Array.iter (fun row -> 
    Array.iter ( 
      fun element -> Printf.printf "%.2f " element) row; print_newline()) matrix


  
let set matrix i j value =
  matrix.(i).(j) <- value


let get matrix i j =
  matrix.(i).(j)


let map_matrix_inplace matrix f =
  for i = 0 to Array.length matrix - 1 do
    for j = 0 to Array.length matrix.(0) - 1 do
      set matrix i j (f @@ get matrix i j)
    done
  done