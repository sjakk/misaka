package uka_tokenizer


Token_Kind :: string

Token :: struct{
kind: Token_Kind,
text: string // literal

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


/*
Foo_Vtable :: struct {
    do_thing: proc(f: ^Foo, x: f32) -> i32,
}

Foo :: struct {
    using vtable: ^Foo_Vtable,
    x: f32,  
}

foo_vtable := Foo_Vtable{
    do_thing = proc(f: ^Foo, x: f32) -> i32 {
        f.x = x
        return i32(f.x + 1)
    }
}

f := new(Foo)
f.vtable = &foo_vtable
f.x = 123

j := f->do_thing(f.x+1)
*/


ILLEGAL :: "ILLEGAL"
EOF :: "EOF"
// Identifiers + literals
IDENT :: "IDENT" // add, foobar, x, y, ...
INT :: "INT" // 1343456
// Operators
ASSIGN :: "="
PLUS :: "+"
// Delimiters
COMMA :: ","
SEMICOLON :: ";"
LPAREN :: "("
RPAREN :: ")"
LBRACE :: "{"
RBRACE :: "}"
// Keywords
FUNCTION :: "FUNCTION"
LET :: "LET"