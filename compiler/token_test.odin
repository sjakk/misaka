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
    }

log.debug(keywords)

}

@(test)
test_full_syntax :: proc(t: ^testing.T){

	input := `let five = 5;
	       let ten = 10;

	       let add = fn(x,y){
		       x + y;
	       }
	       
	       let result = add(five,ten);`

tests := []struct{
	expectedType: Token_Kind,
	expectedLiteral: string,
}{
	{LET,"let"},
	{IDENT,"five"},
	{ASSIGN,"="},
	{INT,"5"},
	{SEMICOLON,";"},
	{LET,"let"},
	{IDENT,"ten"},
	{ASSIGN,"="},
	{INT,"10"},
	{SEMICOLON,";"},
	{LET,"let"},
	{IDENT,"add"},
	{ASSIGN,"="},
	{FUNCTION,"fn"},
	{LPAREN, "("},
	{IDENT, "x"},
	{COMMA, ","},
	{IDENT, "y"},
	{RPAREN, ")"},
	{LBRACE, "{"},
	{IDENT, "x"},
	{PLUS, "+"},
	{IDENT, "y"},
	{SEMICOLON, ";"},
	{RBRACE, "}"},
	{SEMICOLON, ";"},
	{LET, "let"},
	{IDENT, "result"},
	{ASSIGN, "="},
	{IDENT, "add"},
	{LPAREN, "("},
	{IDENT, "five"},
	{COMMA, ","},
	{IDENT, "ten"},
	{RPAREN, ")"},
	{SEMICOLON, ";"},
	{EOF, ""},
}

l:= lexer_init(input)
    
    for v,i in tests{

        tok:= next_token(&l)

        testing.expect(t, tok.kind == v.expectedType,"Different Types provided")
        testing.expect(t,tok.text == v.expectedLiteral,"Literal Wrong provided")
    }



}
