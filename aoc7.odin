package aoc

import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"

Dir :: struct {
    name: string,
    parent: ^Dir,
    children: [dynamic]Dir,
    file_size: uint,
}

dir_free :: proc(dir : Dir) {
    for c in dir.children {
        dir_free(c)
    }
    delete(dir.name)
    delete(dir.children)
}

dir_size :: proc(dir : Dir) -> uint {
    size := dir.file_size
    
    for c in dir.children {
        size += dir_size(c)
    }

    return size
}

find_smallest :: proc(dir : Dir, size_looking : uint) -> uint {
    smallest := dir_size(dir)

    for c in dir.children {
        c_size := find_smallest(c, size_looking)
        if c_size >= size_looking && c_size < smallest {
            smallest = c_size
        }
    }

    return smallest
}

seven :: proc() {
    data, _ := os.read_entire_file_from_filename("input.txt")
    defer delete(data)

    str := strings.clone_from_bytes(data)
    defer delete(str)

    lines := strings.split_lines(str)
    defer delete(lines)

    dir : Dir
    dir.name = strings.clone("/")
    defer dir_free(dir)

    current_dir := &dir

    for line in lines {
        if line == "$ cd /" {
            current_dir = &dir
        } else if strings.contains(line, "$ cd ..") {
            current_dir = current_dir.parent 
        } else if strings.contains(line, "$ cd ") {
            parts := strings.split(line, " ")
            defer delete(parts)

            for i in 0..<len(current_dir.children) {
                if current_dir.children[i].name == parts[2] {
                    current_dir = &current_dir.children[i]
                    continue
                }
            }
        } else if strings.contains(line, "$ ls") {

        } else if strings.contains(line, "dir ") {
            parts := strings.split(line, " ")
            defer delete(parts)

            new_dir : Dir
            new_dir.name = strings.clone(parts[1])
            new_dir.parent = current_dir
            append(&current_dir.children, new_dir)
        } else {
            parts := strings.split(line, " ")
            defer delete(parts)

            size := strconv.atoi(parts[0])
            current_dir.file_size += uint(size)
        }
    }

    total := dir_size(dir)
    unused := 70000000 - total
    unused_needed := 30000000 - unused

    fmt.println(find_smallest(dir, unused_needed))
}