package util

import (
	"math/rand"
	"strings"
	"time"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.Seed(time.Now().UnixNano())
}

// Generate random int between min and max value
func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

// Generate random string with N length
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)

	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// Generate random owner name
func RandomOwnerName() string {
	return RandomString(6)
}

// Generate random  money amount
func RandomMoney() int64 {
	return RandomInt(0, 10000)
}

// Generate random currency
func RandomCurrency() string {
	currencies := []string{"IDR", "SGD", "MYR"}
	n := len(currencies)

	return currencies[rand.Intn(n)]
}
