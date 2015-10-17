open Base58
open TestSimple

(* the decoding tests *)
let main() =
  plan 7;

  ok true "Base58 loaded succesfully";

  is (decode "1") (Int 0) "1 decoded correctly";
  is (decode "CGy") (Int 123456) "CGy decoded correctly";
  is (decode "6hN7hS") (Int 3471844090) "large number encoded correctly";
  is (decode "jgiRZc") (Int 11987654321) "Large Big int encoded correctly";
  is (decode ~alphabet:bitcoin_alphabet "M5TY") (Int 0x3BC5B3) "Bitcoin address correctly decoded";
  let (Num.Big_int x) =  (decode "2ki7xkQVuB8dLGWonW") in
  ok (Big_int.eq_big_int x  (Big_int.power_int_positive_int 2 100)) "2^100 is Big Int";
  exit 0;;

main();;
