default:
	go build -buildmode=c-shared -o ext/libs3git.so ext/libs3git.go

.PHONY: default
