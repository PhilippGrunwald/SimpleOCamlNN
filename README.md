# SimpleOCamlNN

This project is still under development and not yet ready for use.

_SimpleOCamlNN_ will be a **minimalistic** (admittedly not really efficient) implementation of **fully connected feed forward neural networks** with **backpropagation** and **gradient descent**. Since the code is based only on an included self-written matrix library, and not on super complicated tensors optimised for multithreading and GPU usage with e.g. CUDA, the **code will be very easy to understand** and the principles of neural networks will be clear.

The project will be so lightweight that you can simply copy the code into your own project and it will run.

## Example: Simple Neural Network for the MNIST data set with ~95% Accuracy after 4 Epochs

```ocaml
open SimpleOCamlNN

let nn = NN.create [
    Layer.create_random
      ~inputs:784
      ~outputs:200
      ~activation:Activations.Sigmoid
      ~rand_min:(-1.0)
      ~rand_max:1.0;
    Layer.create_random
      ~inputs:200
      ~outputs:40  
      ~activation:Activations.Sigmoid
      ~rand_min:(-1.0)
      ~rand_max:1.0;
    Layer.create_random
      ~inputs:40
      ~outputs:10  
      ~activation:Activations.Sigmoid
      ~rand_min:(-1.0)
      ~rand_max:1.0;
      ] 0.01 in

NN.train nn data_train 4;
```

## References
1. Christopher M. Bishop, Hugh Bishop: *Deep Learning - Foundations and Concepts* [Springer Link](https://link.springer.com/book/10.1007/978-3-031-45468-4) 
2. Diederik P. Kingma, Jimmy Ba: *Adam: A Method for Stochastic Optimization* [Arxiv](https://arxiv.org/abs/1412.6980)


