

let test () = 
  print_endline "Test from lib"




let%expect_test "test" = 
  test ();
  [%expect {| Test from lib |} ]