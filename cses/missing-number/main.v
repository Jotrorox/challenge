import os

fn main() {
	_ := os.input("> ").int()
	mut nums := os.input("> ").split_by_space().map(it.int())
	nums.sort()

	for i, n in nums {
		if i == 0 {
			if n != 1 {
				println("1")
				return
			} else {
				continue
			}
		}

		if n != nums[i-1] + 1 {
			println(n - 1)
			return
		}
	}
}