open Base58
open TestSimple

(* the encoding tests *)
let main() =
  plan 8;

  ok true "Base58 loaded succesfully";

  is (encode_int 0) "1" "0 encoded correctly";
  is (encode_int 123456) "CGy" "6 decimals encoded correctly";
  is (encode_int 3471844090) "6hN7hS" "large number encoded correctly";
  is (encode_int ~alphabet:bitcoin_alphabet 0x3BC5B3) "M5TY" "Bitcoin encoded correctly";
  is (encode_big_int (Big_int.zero_big_int)) "1" "Big int 0 encoded correctly";
  is (encode_big_int (Big_int.big_int_of_int 11987654321)) "jgiRZc" "Large Big int encoded correctly";
  is (encode_big_int (Big_int.power_int_positive_int 2 100)) "2ki7xkQVuB8dLGWonW" "2^100 encoded correctly";
  exit 0;;

main();;

