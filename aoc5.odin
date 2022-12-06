package aoc

import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"

five :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    s : int

    for i := 0; i < len(lines); i += 1 {
        if len(lines[i]) == 0 {
            s = i
        }
    }

    bins_count := 0
    bins_str := strings.split(lines[s-1], " ")
    defer delete(bins_str)
    for b in bins_str {
        for c in b {
            if c != ' ' {
                bins_count += 1
                break
            }
        }
    }

    bins := make([][dynamic]rune, bins_count)
    defer delete(bins)

    for i := s - 2; i >= 0; i -= 1 {
        for j := 0; j < bins_count; j += 1 {
            p := 1 + (j * 4)
            if lines[i][p] != ' ' {
                append(&bins[j], rune(lines[i][p]))
            }
        }
    }

    for i := s + 1; i < len(lines); i += 1 {
        parts := strings.split(lines[i], " ")
        defer delete(parts)

        count, _ := strconv.parse_int(parts[1])
        src, _ := strconv.parse_int(parts[3])
        dst, _ := strconv.parse_int(parts[5])

        // Part 1
        // for _ in 0 ..< count {
        //     append(&bins[dst - 1], pop(&bins[src - 1]))
        // }

        // Part 2
        temp := make([]rune, count)
        defer delete(temp)
        
        for c := 0; c < count; c += 1 {
            temp[c] = pop(&bins[src - 1])
        }
        
        for c := count - 1; c >= 0; c -= 1 {
            append(&bins[dst - 1], temp[c])
        }
    }

    for i in 0..<bins_count {
        fmt.print(pop(&bins[i]))
        delete(bins[i])
    }
    fmt.println()
}

