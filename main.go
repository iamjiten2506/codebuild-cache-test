package main

import (
    "fmt"
    "github.com/gin-gonic/gin"
    "github.com/gorilla/mux"
)

func main() {
    // Create large build artifacts to consume cache space
    for i := 0; i < 1000; i++ {
        fmt.Printf("Building component %d\n", i)
    }
    
    r := gin.Default()
    router := mux.NewRouter()
    
    fmt.Println("Build completed successfully")
}
