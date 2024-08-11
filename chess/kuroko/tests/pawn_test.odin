package tests


import main ".."
import "core:testing"




@(test)
pawn_attack_squares_test :: proc(t: ^testing.T) {
using main.Piece_Color
using main.FILES



for i in 0..<64{

main.pawn_attacks[white][i] = main.mask_pawn_attacks(main.FILES(i),white)
main.pawn_attacks[black][i] = main.mask_pawn_attacks(main.FILES(i),black)
}


testing.expect(t,main.pawn_attacks[white][e4] == (0b101 << 27),"Failed e4 square")

}
