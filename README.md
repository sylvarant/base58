
Base58
==========================================
[![Build Status](https://travis-ci.org/sylvarant/base58.svg)](https://travis-ci.org/sylvarant/captureio) [![Coverage Status](https://coveralls.io/repos/sylvarant/base58/badge.svg?branch=master&service=github)](https://coveralls.io/github/sylvarant/base58?branch=master) 
---------------------------------------------------------------------------

Usage
-----

The library can encode regular (small) integers:
```ocaml
let str =  (encode_int 123456) in
assert(str = "CGy")
```
as well as the big integers provided by the Ocaml standard library:
```ocaml
(encode_big_int (Big_int.power_int_positive_int 2 100))
assert(str = "2ki7xkQVuB8dLGWonW");
```

The decoding function outputs an Ocaml `Num` that will be an `int` when possible and a 
`Big_int` otherwise.
```ocaml
assert((decode "6hN7hS") = (Int 3471844090));
assert((Big_int.eq_big_int (decode "2ki7xkQVuB8dLGWonW")  
  (Big_int.power_int_positive_int 2 100)))
```

By default `Base58` will encode using the Flickr alphabet.
Alternatively, you can use the bitcoin alphabet as well.
```ocaml
let str = (encode_int ~alphabet:bitcoin_alphabet 0x2466CA) in 
assert(str = "DEAD")
```

For more examples see the tests in `t/*.ml`.

## License

[Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0)
