use std::env;
use std::fs;
use std::io::{self, Read, Write};

fn main() {
    let code = if env::args().len() > 1 {
        fs::read_to_string(env::args().nth(1).unwrap()).unwrap()
    } else {
        let mut input = String::new();
        io::stdin().read_to_string(&mut input).unwrap();
        input
    };

    let mut tape = vec![0u8; 30000];
    let mut code_pos = 0usize;
    let mut tape_pos = 0usize;

    while code_pos < code.len() && tape_pos < tape.len() {
        match code.as_bytes()[code_pos] as char {
            '[' => {
                if tape[tape_pos] == 0 {
                    let mut depth = 1;
                    code_pos += 1;
                    while depth > 0 && code_pos < code.len() {
                        match code.as_bytes()[code_pos] as char {
                            '[' => depth += 1,
                            ']' => depth -= 1,
                            _ => {}
                        }
                        code_pos += 1;
                    }
                    code_pos -= 1;
                } else {
                    code_pos += 1;
                }
            }
            ']' => {
                if tape[tape_pos] != 0 {
                    let mut depth = 1;
                    while depth > 0 && code_pos > 0 {
                        code_pos -= 1;
                        match code.as_bytes()[code_pos] as char {
                            ']' => depth += 1,
                            '[' => depth -= 1,
                            _ => {}
                        }
                    }
                } else {
                    code_pos += 1;
                }
            }
            '+' => {
                tape[tape_pos] = tape[tape_pos].wrapping_add(1);
                code_pos += 1;
            }
            '-' => {
                tape[tape_pos] = tape[tape_pos].wrapping_sub(1);
                code_pos += 1;
            }
            '>' => {
                tape_pos += 1;
                code_pos += 1;
            }
            '<' => {
                tape_pos = tape_pos.saturating_sub(1);
                code_pos += 1;
            }
            '.' => {
                print!("{}", tape[tape_pos] as char);
                io::stdout().flush().unwrap();
                code_pos += 1;
            }
            ',' => {
                let mut buf = [0u8; 1];
                io::stdin().read_exact(&mut buf).ok();
                tape[tape_pos] = buf[0];
                code_pos += 1;
            }
            _ => code_pos += 1,
        }
    }
}
