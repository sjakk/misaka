package uka_tokenizer


import "core:testing"
import "core:log"
import "core:fmt"


@(test)
test_next_token :: proc(t: ^testing.T){
    input:= "=+(){},;"
    tests:=[]struct{
        expectedType:Token_Kind,
        expectedText:string,
    }{
        {ASSIGN,"="},
        {PLUS,"+"},
        {LPAREN,"("},
        {RPAREN, ")"},
        {LBRACE, "{"},
        {RBRACE, "}"},
        {COMMA, ","},
        {SEMICOLON, ";"},
        {EOF, ""},
    }

    l:= lexer_init(input)
    
    for v,i in tests{

        tok:= next_token(&l)

        testing.expect(t, tok.kind == v.expectedType,"Different Types provided")
        testing.expect(t,tok.text == v.expectedText,"Literal Wrong provided")
        //log.info(tt)
    }




}
