package main

import "core:crypto/hash"
import "core:encoding/endian"
import "core:fmt"

rol :: proc(value:u32,bits:uint) -> u32{
return (value << bits) | (value >> (32 - bits))
}

blk :: proc(){
	fmt.println("Hello")
}

main :: proc(){

	a:= 10
	if(a > 8){
		blk()
		return
	}else{
		fmt.println("abc")
	}

}


//digest
sha1_ctx :: struct{

state: [5]u32,
count: [2]u32,
buffer: [64]byte

}

ini0 :: 0x67452301
ini1 :: 0xEFCDAB89
ini2 :: 0x98BADCFE
ini3 :: 0x10325476
ini4 :: 0xC3D2E1F0


sha1_init :: proc(ctx: ^sha1_ctx){
ctx.state[0] = ini0
ctx.state[1] = ini1
ctx.state[2] = ini2
ctx.state[3] = ini3
ctx.state[4] = ini4
ctx.count[0], ctx.count[1] = 0,0
}

sha1_transform :: proc(state:[5]u32,buffer:[64]byte){

}
