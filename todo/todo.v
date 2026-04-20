import readline

fn main() {
	mut todo := []string{}
	mut reader := readline.Readline{}
	for {
		input := reader.read_line("> ") or { break}
		match input {
			"exit" { break }
			"add" {
				todo << reader.read_line("add > ") or { break }
			}
			"list" {
				for i, item in todo {
					println("ID: ${i + 1} - Item: ${item}")
				}
			}
			"delete" {
				id := reader.read_line("delete > ") or { break }
				todo.delete(id.int() - 1)
			}
			else { continue }
		}
	}
}
