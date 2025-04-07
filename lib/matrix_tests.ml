
let%expect_test "print_test" = 
  let matrix = Matrix.create 2 3 0. in
  Matrix.print_matrix matrix;
  [%expect {| 
    0.00 0.00 0.00
    0.00 0.00 0.00
  |}]


let%expect_test "print_test2" = 
  let matrix = Matrix.create 3 1 0. in
  Matrix.set matrix 0 0 (-1.0);
  Matrix.set matrix 1 0 1.0;
  Matrix.set matrix 2 0 42.0;
  Matrix.print_matrix matrix;
  [%expect {| 
    -1.00 
    1.00
    42.00
  |}]


let%expect_test "mapping" = 
  let matrix = Matrix.create 3 2 0. in
  Matrix.set matrix 0 0 (-1.0);
  Matrix.set matrix 1 0 1.0;
  Matrix.set matrix 2 0 2.5;
  Matrix.set matrix 2 1 (-3.0);
  Matrix.map_matrix_inplace (fun x -> x *. x) matrix;
  Matrix.print_matrix matrix;
  [%expect {| 
    1.00 0.00
    1.00 0.00
    6.25 9.00
  |}]

let%expect_test "mapping not in place" = 
  let matrix = Matrix.create 3 2 0. in
  Matrix.set matrix 0 0 (-1.0);
  Matrix.set matrix 1 0 1.0;
  Matrix.set matrix 2 0 2.5;
  Matrix.set matrix 2 1 (-3.0);
  Matrix.map_matrix (fun x -> x *. x) matrix
    |> Matrix.print_matrix;
  [%expect {| 
    1.00 0.00
    1.00 0.00
    6.25 9.00
  |}]

let%expect_test "mapping & set_column" = 
  let matrix = Matrix.create 2 5 0. in
  Matrix.set_row matrix 0 [1.; 2.; 3.; 4.; 5.];
  Matrix.set_row matrix 1 [-2.; -3.; -4.; -5.; -6.];
  Matrix.print_matrix matrix;
  [%expect {| 
    1.00 2.00 3.00 4.00 5.00
    -2.00 -3.00 -4.00 -5.00 -6.00
  |}]


let%expect_test "get" = 
  let matrix = Matrix.create 2 5 0. in
  Matrix.set_row matrix 0 [1.; 2.; 3.; 4.; 5.];
  Matrix.set_row matrix 1 [-2.; -3.; -4.; -5.; -6.];
  let value = Matrix.get matrix 1 2 in
  Printf.printf "%.2f" value;
  [%expect {| 
    -4.00      
  |}]


let%expect_test "dimension error" = 
  let matrix = Matrix.create 2 5 0. in
  (try 
    Matrix.set_row matrix 0 [1.; 2.; 3.; 4.]
  with Failure msg -> print_endline msg);
  [%expect {| 
    column length does not match matrix dimension      
  |}]


let%expect_test "dimension error add" = 
  let m = Matrix.create 2 5 0. in
  let n = Matrix.create 3 5 0. in
  (try 
   Matrix.print_matrix @@ Matrix.add m n
  with Failure msg -> print_endline msg);
  [%expect {| 
    Missmatch of dimensions in Matrix.add      
  |}]

let%expect_test "Add" = 
  let m = Matrix.create 2 3 0. in
  Matrix.set_row m 0 [1.; 2.; 3.;];
  Matrix.set_row m 1 [0.; 2.; -1.;];
  let n = Matrix.create 2 3 0. in
  Matrix.set_row n 0 [1.; 2.; 3.];
  Matrix.set_row n 1 [0.; 2.; -2.];
  Matrix.print_matrix ( Matrix.add m n);
  [%expect {|
    2.00 4.00 6.00 
    0.00 4.00 -3.00   
  |}]



let%expect_test "matmul" = 
  let m = Matrix.create 2 3 0. in
  Matrix.set_row m 0 [1.; 2.; 3.;];
  Matrix.set_row m 1 [0.; 2.; 0.;];
  let n = Matrix.create 3 4 0. in
  Matrix.set_row n 0 [1.; 2.; 3.; -1.];
  Matrix.set_row n 1 [0.; 2.; 0.; 2.];
  Matrix.set_row n 2 [1.; -2.; 0.; 3.];
  Matrix.print_matrix ( Matrix.multiply m n);
  [%expect {|
    4.00 0.00 3.00 12.00
    0.00 4.00 0.00 4.00
  |}]

let%expect_test "matmul first transposed" = 
  let m = Matrix.create 2 3 0. in
  Matrix.set_row m 0 [1.; 2.; 3.;];
  Matrix.set_row m 1 [0.; 2.; 0.;];
  let n = Matrix.create 2 4 0. in
  Matrix.set_row n 0 [1.; 2.; 3.; -1.];
  Matrix.set_row n 1 [0.; 2.; 0.; 2.];
  Matrix.multiply_first_transposed m n
    |> Matrix.print_matrix;
  [%expect {|
    1.00 2.00 3.00 -1.00
    2.00 8.00 6.00 2.00
    3.00 6.00 9.00 -3.00
  |}]


let%expect_test "transpose" = 
  let m = Matrix.create 2 3 0. in
  Matrix.set_row m 0 [1.; 2.; 3.];
  Matrix.set_row m 1 [-1.; -2.; -3.];
  Matrix.transpose m |> Matrix.print_matrix;
  [%expect {|
    1.00 -1.00
    2.00 -2.00
    3.00 -3.00
  |}]

  

