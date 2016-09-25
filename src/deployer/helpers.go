package main

import (
    "fmt"
)

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func multilinePrint(text ...interface{}) {
    for _, line := range text {
        fmt.Println(line)
    }
}
