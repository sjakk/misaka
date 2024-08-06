package main


//pieces bitboards



not_a_file:u64 : 18374403900871474942
 
not_h_file:u64 :  9187201950435737471

not_hg_file:u64 : 4557430888798830399

not_ab_file:u64 : 18229723555195321596

pawn_attacks:[2][64]u64

mask_pawn_attacks :: proc(square: FILES,side: Piece_Color) -> u64{
	using Piece_Color

	attacks:u64
	bitboard:u64

	set_bit(&bitboard,square)
	show_bitboard(bitboard)
	//white pawns
	if (side != black){
		if((bitboard >> 7) & not_a_file > 0){
			attacks |= (bitboard >> 7)
		}
		if((bitboard >> 9) & not_h_file > 0){
			attacks |= (bitboard >> 9)
		}
	}else{
		if((bitboard << 7) & not_h_file > 0){
			attacks |= (bitboard << 7)
		}

		if((bitboard << 9) & not_a_file > 0){
			attacks |= (bitboard << 9)
		}

	}

return attacks
}


Piece_Color :: enum {
white,black
}





/*
debugger for loop to get constants
for rank in 0..<WIDTH{
		for file in 0..<HEIGHT{
			square := rank * WIDTH + file
			if (file > 1){
			set_bit(&not_ab_file,FILES(square))
			}
		}
	}

 */
