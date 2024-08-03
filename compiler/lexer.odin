package uka_tokenizer

import "core:unicode/utf8"
import "core:unicode"

Lexer :: struct{
    input:string,
    position: int,
    readPosition: int,
    ch: byte,
}


lexer_init :: proc(input:string) -> Lexer{
    l:= Lexer{}
    l.input = input
    read_char(&l)
    return l
}



next_token :: proc(l:^Lexer) -> Token{
    tok:Token

skip_whitespace(l)

    switch l.ch{
        case '=':
            tok = new_token(ASSIGN,l.ch)
        
        case ';':
            tok = new_token(SEMICOLON,l.ch)
        
        case '(':
            tok = new_token(LPAREN,l.ch)
        
        case ')':
            tok = new_token(RPAREN,l.ch)
        
        case ',':
            tok = new_token(COMMA,l.ch)
        
        case '+':
            tok = new_token(PLUS,l.ch)

        case '{':
            tok = new_token(LBRACE,l.ch)

        case '}':
            tok = new_token(RBRACE,l.ch)

        case 0:
            tok.text = ""
            tok.kind = EOF
	case:
		if is_letter(l.ch){
			tok.text = read_identifier(l)
			tok.kind = lookup_ident(tok.text)
			return tok
		}else if is_digit(l.ch){
			tok.kind = INT
			tok.text = read_number(l)
			return tok
		}
		else{
			tok = new_token(ILLEGAL,l.ch)
		}
    }
read_char(l)
return tok
}



skip_whitespace :: proc(l: ^Lexer) {
for {
	switch l.ch {
		case ' ', '\t', '\r', '\n':
			read_char(l)
		case:
			return
	}
}
}

new_token :: proc(ttype: Token_Kind,ch:byte) -> Token{
    literal := make([]byte,1)
    defer delete(literal)
    literal[0] = ch
    return Token{kind=ttype,text=string(literal)}
}


read_char :: proc(l: ^Lexer){
    if(l.readPosition >= len(l.input)){
        l.ch = 0;
    }else{
        l.ch = l.input[l.readPosition]
    }

    l.position = l.readPosition
    l.readPosition+=1
}


read_identifier :: proc(l: ^Lexer) -> string{
	position := l.position
	for is_letter(l.ch){
		read_char(l);
	}
	return l.input[position:l.position]
}



read_number :: proc(l: ^Lexer) -> string{
	position:= l.position
	for is_digit(l.ch){
		read_char(l)
	}
	return string(l.input[position:l.position])
}


is_letter :: proc(r: byte) -> bool {
	if r < utf8.RUNE_SELF {
		switch r {
		case '_':
			return true
		case 'A'..='Z', 'a'..='z':
			return true
		}
	}
	return false
}


is_digit :: proc(r: byte) -> bool {
	if '0' <= r && r <= '9' {
		return true
	}
	return false
}

