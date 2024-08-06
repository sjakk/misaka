package main

import "core:fmt"

WIDTH :: 8
HEIGHT :: 8



get_bit  :: proc(bitboard: u64,square:u64) -> u64 {
return (1 if bitboard & (1 << u64(square)) > 0 else 0)
}

set_bit :: proc(bitboard: ^u64,square:FILES){
	bitboard^ |= u64(1<<u64(square))
}

pop_bit :: proc(bitboard: ^u64,square:FILES){
	if get_bit(bitboard^,u64(square)) > 0 {
		bitboard^ ~= (1 << u64(square))
	}
}


main :: proc(){
using FILES
using Piece_Color



fc: FILES_COORDINATES = {.e4}; // how tf i use that

show_bitboard(mask_pawn_attacks(e4,black))

}





show_bitboard :: proc(bitboard: u64){
	fmt.println()

	for rank in 0..<WIDTH{
		for file in 0..<HEIGHT{
			square := rank * WIDTH + file


			if !(file > 0){
				fmt.printf(" %d ", 8-rank)	
			}



			fmt.printf(" %v ", get_bit(bitboard,u64(square)))
		}
		fmt.println()
	}
	fmt.println("\n    a  b  c  d  e  f  g  h 	\n")
	fmt.printfln("Bitboard: %d",bitboard)
}



FILES :: enum{
    a8, b8, c8, d8, e8, f8, g8, h8,
    a7, b7, c7, d7, e7, f7, g7, h7,
    a6, b6, c6, d6, e6, f6, g6, h6,
    a5, b5, c5, d5, e5, f5, g5, h5,
    a4, b4, c4, d4, e4, f4, g4, h4,
    a3, b3, c3, d3, e3, f3, g3, h3,
    a2, b2, c2, d2, e2, f2, g2, h2,
    a1, b1, c1, d1, e1, f1, g1, h1
}

FILES_COORDINATES :: bit_set[FILES;u64]



















