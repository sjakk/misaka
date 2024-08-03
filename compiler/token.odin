package uka_tokenizer


Token_Kind :: string

Token :: struct{
kind: Token_Kind,
text: string // literal

}


keywords := map[string]Token_Kind{
"fn" = FUNCTION,
"let" = LET,
};




lookup_ident :: proc(ident: string) -> Token_Kind{

if tok,ok := keywords[ident]; ok{
return tok
}
return IDENT
}






aopjs:="0"

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
