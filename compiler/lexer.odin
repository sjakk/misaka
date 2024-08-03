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
    }
read_char(l)
return tok
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



is_letter :: proc(r: rune) -> bool {
	if r < utf8.RUNE_SELF {
		switch r {
		case '_':
			return true
		case 'A'..='Z', 'a'..='z':
			return true
		}
	}
	return unicode.is_letter(r)
}


