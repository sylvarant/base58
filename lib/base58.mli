(*
 * =====================================================================================
 *
 *         Module:  Base58
 *
 *    Description:  Encode and Decode to Base58
 *
 *         Author:  Ajhl 
 *
 * =====================================================================================
 *)

(* Raised whenever base58 string cannot be decoded or negative numbers are input *)
exception Base58 of string

(* The default choice small letters first *)
val flickr_alphabet : string

(* caps first *)
val bitcoin_alphabet : string

(* encode small integer *)
val encode_int : ?alphabet:string -> int  -> string

(* encode big integer *)
val encode_big_int : ?alphabet:string -> Big_int.big_int -> string

(* decode into num *)
val decode : ?alphabet:string -> string -> Num.num

