package aoc

import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"

four :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    score := 0
    for line in lines {
        halfs := strings.split(line, ",")
        defer delete(halfs)

        halfa := strings.split(halfs[0], "-")
        defer delete(halfa)

        halfb := strings.split(halfs[1], "-")
        defer delete(halfb)

        a, _ := strconv.parse_int(halfa[0])
        b, _ := strconv.parse_int(halfa[1])
        c, _ := strconv.parse_int(halfb[0])
        d, _ := strconv.parse_int(halfb[1])

        // Part one
        if (a <= c && b >= d) || (c <= a && d >= b) {
            score += 1
            continue
        }

        // Part two
        if  (c <= b && b <= d) || (c <= a && a <= d) {
            score += 1
        }

    }

    fmt.println(score)
}