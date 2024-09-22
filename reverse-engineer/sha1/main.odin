package main

import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"
import "core:strings"


SHA1_HEX_STRING_LEN :: 40



main :: proc(){

args := os.args
reader: bufio.Scanner

file, _ := os.open(args[1])
s:= os.stream_from_handle(file)
bufio.scanner_init(&reader,s)

	if len(args) != 3{
		fmt.println("Usage:")
		fmt.println("sha1_cracker: <wordlist.txt> <sha1_hash>")
	}
for _ in 0..<10{
_ = bufio.scanner_scan(&reader)
}

line:= bufio.scanner_text(&reader)
fmt.println(line)
}


