
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
  let matrix = Matrix.create 3 1 0. in
  Matrix.set matrix 0 0 (-1.0);
  Matrix.set matrix 1 0 1.0;
  Matrix.set matrix 2 0 2.5;
  Matrix.map_matrix_inplace matrix (fun x -> x *. x);
  Matrix.print_matrix matrix;
  [%expect.unreachable]
[@@expect.uncaught_exn {|
  (* CR expect_test_collector: This test expectation appears to contain a backtrace.
     This is strongly discouraged as backtraces are fragile.
     Please change this test to not include a backtrace. *)
  (Invalid_argument "index out of bounds")
  Raised by primitive operation at SimpleOCamlNN__Matrix.get in file "lib/matrix.ml", line 21, characters 2-16
  Called from SimpleOCamlNN__Matrix.map_matrix_inplace in file "lib/matrix.ml", line 27, characters 27-41
  Called from SimpleOCamlNN__Matrix_tests.(fun) in file "lib/matrix_tests.ml", line 28, characters 2-52
  Called from Ppx_expect_runtime__Test_block.Configured.dump_backtrace in file "runtime/test_block.ml", line 142, characters 10-28
  |}]

