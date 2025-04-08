
let%expect_test "nn creation" = 
  let nn = NN.create [
    Layer.create_const 
      ~inputs:3 
      ~outputs:10 
      ~activation:Activations.Tanh 
      ~weight_init: 1.0;
    Layer.create_const
      ~inputs:10
      ~outputs:1
      ~activation:Activations.Sigmoid 
      ~weight_init:1.
  ] 0.001 in
  Matrix.create 3 1 1.0
    |> NN.predict nn
    |> Matrix.print_matrix;
  [%expect {|
    1.00
  |}] 


let%expect_test "nn ff" = 
  let nn = NN.create [
    Layer.create_const 
      ~inputs:3 
      ~outputs:4 
      ~activation:Activations.Tanh 
      ~weight_init: 0.1;
    Layer.create_const
      ~inputs:4
      ~outputs:1
      ~activation:Activations.Sigmoid 
      ~weight_init:0.1
  ] 0.001 in
  Matrix.print_matrix @@ NN.predict nn (Matrix.create 3 1 0.1);
  [%expect {|
    0.54
  |}]


let%expect_test "nn creation" = 
  let nn = NN.create [
    Layer.create_const 
      ~inputs:3 
      ~outputs:4 
      ~activation:Activations.Tanh 
      ~weight_init: 1.0;
    Layer.create_const
      ~inputs:4
      ~outputs:1
      ~activation:Activations.Sigmoid
      ~weight_init:0.1
  ] 0.001 in
  ignore @@ NN.predict nn (Matrix.create 3 1 0.1);
  Matrix.create 1 1 1.0
    |> NN.propagate_backwards nn;
  NN.get_layers nn
    |> List.hd
    |> Layer.get_gradient
    |> Matrix.print_matrix;
  [%expect {|
    0.02
    0.02
    0.02
    0.02
  |}] 
