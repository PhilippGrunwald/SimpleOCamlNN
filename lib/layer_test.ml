let%expect_test "feed forward" = 
  let layer = Layer.create_random 
      ~inputs:2
      ~outputs:3 
      ~activation: Activations.LeakyReLu
      ~rand_min: (-1.)
      ~rand_max: 1.0
  in
  let input = Matrix.create_random 2 1 (-1.) 1. in
  Matrix.print_matrix @@ Layer.feed_foreward layer input;
  [%expect {|
    -0.01
    -0.00
    0.17
  |}]

let%expect_test "feed forward const" = 
  let layer = Layer.create_const 
      ~inputs:3
      ~outputs:4 
      ~activation: Activations.Sigmoid
      ~weight_init: 1.0
    in
  let input = Matrix.create 3 1 1.0 in
  Matrix.print_matrix @@ Layer.feed_foreward layer input;
  [%expect {|
    0.98
    0.98
    0.98
    0.98
  |}]