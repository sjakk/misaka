use anyhow::Result;

#[derive(Debug,Clone,PartialEq)]
pub enum Token{
Integer(i64),
Symbol(String),
LParen,
RParen,
}





pub fn tokenize(program: &str) -> Result<Vec<Token>>{
let program2 = program.replace("(", " ( ").replace(")", " ) ");
let words = program2.split_whitespace();
let mut tokens = Vec::new();

for word in words{
match word{
    "(" => tokens.push(Token::LParen),
    ")" => tokens.push(Token::RParen),
    _ => {
        let i = word.parse::<i64>();
        if i.is_ok(){
            tokens.push(Token::Integer(i.unwrap()));
        }else{
            tokens.push(Token::Symbol(word.to_string()));
        }
    }
}
}
Ok(tokens)
}




#[test]
fn test_area_of_circle(){
let program = 
    "
    (
        (   define    r    10)
        (define   pi   314)
        (* pi (*   r r)   )
    )

    ";


let tokens = tokenize(program).unwrap_or(vec![]);

assert_eq!(
    tokens,
    vec![
    Token::LParen,
                Token::LParen,
                Token::Symbol("define".to_string()),
                Token::Symbol("r".to_string()),
                Token::Integer(10),
                Token::RParen,
                Token::LParen,
                Token::Symbol("define".to_string()),
                Token::Symbol("pi".to_string()),
                Token::Integer(314),
                Token::RParen,
                Token::LParen,
                Token::Symbol("*".to_string()),
                Token::Symbol("pi".to_string()),
                Token::LParen,
                Token::Symbol("*".to_string()),
                Token::Symbol("r".to_string()),
                Token::Symbol("r".to_string()),
                Token::RParen,
                Token::RParen,
                Token::RParen
    ]
);


}


