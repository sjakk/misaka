package uka_tokenizer

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


read_char :: proc(l:^Lexer){
    if(l.readPosition >= len(l.input)){
        l.ch = 0;
    }else{
        l.ch = l.input[l.readPosition]
    }

    l.position = l.readPosition
    l.readPosition+=1
}
