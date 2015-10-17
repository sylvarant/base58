
(*
 * =====================================================================================
 *
 *         Module:  Base58
 *
 *    Description:  Encode to Decode to Base58
 *
 *         Author:  Ajhl 
 *
 * =====================================================================================
 *)


(* Raised whenever base58 string cannot be decoded or negatives are input *)
exception Base58 of string

let base = 58
let big_base = Big_int.big_int_of_int 58
let flickr_alphabet  = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ" 
let bitcoin_alphabet = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"

(* encode an integer to base 58 *)
let encode_int ?(alphabet = flickr_alphabet) i = 
  let rec encode ls = function
    | 0 -> (match ls with 
      | [] -> "1"
      | _ -> (String.concat "" ls))
    | x -> let index = (x mod base) in
      encode ((String.make 1 alphabet.[index]) :: ls) (x / base)
  in
  (encode [] (if i < 0 then raise (Base58 "Negative number") else i))

(* encode a bigint to base 58 *)
let encode_big_int  ?(alphabet = flickr_alphabet) big =
  let rec encode ls = fun x -> 
    if (Big_int.eq_big_int x Big_int.zero_big_int) 
    then (match ls with 
      | [] -> "1"
      | _ -> (String.concat "" ls))
    else 
      let (q,index) = Big_int.quomod_big_int x big_base in
      (encode ((String.make 1 alphabet.[(Big_int.int_of_big_int index)]) :: ls) q)
  in
  (encode [] (if (Big_int.lt_big_int big Big_int.zero_big_int) then
    raise (Base58 "Negative number") 
    else big))

(* decode a string return either an Int or Big_int *)
let decode ?(alphabet = flickr_alphabet) str = 
  let result = ref Big_int.zero_big_int in
  for i = 0 to ((String.length str) - 1) do
    try
      let index = Big_int.big_int_of_int (String.index alphabet str.[i]) in
      result := Big_int.add_big_int (Big_int.mult_big_int !result big_base) index
    with _ ->
      raise (Base58 ("The passed value "^ str ^" is not base58"))
  done; 
  if (Big_int.is_int_big_int !result) 
  then Num.Int (Big_int.int_of_big_int !result)
  else Num.Big_int !result 

