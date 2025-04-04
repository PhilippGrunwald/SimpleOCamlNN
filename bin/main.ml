open SimpleOCamlNN


let () = 
  let m = Matrix.create 2 3 0. in
  Matrix.set_column m 0 [1.; 2.; 3.;];
  Matrix.set_column m 1 [0.; 2.; 0.;];
  let n = Matrix.create 3 4 0. in
  Matrix.set_column n 0 [1.; 2.; 3.; -1.];
  Matrix.set_column n 1 [0.; 2.; 0.; 2.];
  Matrix.set_column n 2 [1.; -2.; 0.; 3.];
  Matrix.print_matrix ( Matrix.multiply m n);
