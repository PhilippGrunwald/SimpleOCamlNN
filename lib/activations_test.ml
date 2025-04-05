

let%expect_test "tanh" =
  Printf.printf "%.2f" (Activations.get_activation_function Activations.Tanh 1.0);
  [%expect {| 0.76 |}]

let%expect_test "sigmoid" =
  Printf.printf "%.2f" (Activations.get_activation_function Activations.Sigmoid 0.0);
  [%expect {| 0.50 |}]

let%expect_test "relu" =
  Printf.printf "%.2f" (Activations.get_activation_function Activations.Relu 1.0);
  [%expect {| 1.00 |}]

let%expect_test "rel2" =
  Printf.printf "%.2f" (Activations.get_activation_function Activations.Relu (-0.000001));
  [%expect {| 0.00 |}]

let%expect_test "leaky_relu" = 
  Printf.printf "%.2f" (Activations.get_activation_function Activations.LeakyReLu (-2.0));
  [%expect {| -0.02 |}]