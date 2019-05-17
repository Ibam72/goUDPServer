package main

import (
    "fmt"
    "net"
)

func replyStr(size int) []byte{
	ret := make([]byte, size)
	for i:=0 ;i<size;i++ {
		ret[i]=4
	}
	return ret
}
func main() {
	const address = "127.0.0.1:4545"
    fmt.Println("address: ",address)
    conn, _ := net.ListenPacket("udp", address)
    defer conn.Close()

	buffer := make([]byte, 65565)
	const size = 200000
	for {
        length, remoteAddr, _ := conn.ReadFrom(buffer)
        fmt.Printf("Received from %v: %v\n", remoteAddr, string(buffer[:length]))
        conn.WriteTo(replyStr(size), remoteAddr)
    }
}
