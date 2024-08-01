package main

import "core:fmt"
import t "ffi"
import "core:c/libc"

STDIN_FILENO :: 0

main :: proc(){
	term: t.termios
	
	if(t.tcgetattr(STDIN_FILENO,&term) < 0){
	fmt.println("Fucked up")
	}

	switch (term.c_cflag & t.CSIZE){
	case t.CS5:
		fmt.println("5 bits/byte")
		break;
	case t.CS6:
		fmt.println("6 bits")
		break
	
	case t.CS7:
		fmt.println("7 bits")
		break
	case t.CS8:
		fmt.println("8 bits")
		break
	case:
		fmt.println("Unknown");
		break
	}

term.c_cflag &= ~t.CSIZE
term.c_cflag |= t.CS8
if (t.tcsetattr(STDIN_FILENO,t.TCSANOW,&term)<0){
	fmt.println("erro feiao")
}

}// main
