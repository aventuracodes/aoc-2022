package aoc

import "core:strings"
import "core:os"
import "core:strconv"
import "core:fmt"
import "core:slice"

one :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    counts : [dynamic]int
    defer delete(counts)

    count : int = 0
    for line in lines {
        num, ok := strconv.parse_int(line)

        if ok {
            count += num
        } else {
            append(&counts, count)
            count = 0
        }
    }

    slice.reverse_sort(counts[:])

    fmt.println(counts[0])
    fmt.println(counts[0] + counts[1] + counts[2])
}