package main

import (
	"C"
	"os"
	"bytes"
	"github.com/s3git/s3git-go"
)

//export s3git_init_repository
func s3git_init_repository(path *C.char) int {

	_, err := s3git.InitRepository(C.GoString(path))
	if err != nil {
		return -1
	}

	return 0
}

//export s3git_open_repository
func s3git_open_repository(path *C.char) int {

	_, err := s3git.OpenRepository(C.GoString(path))
	if err != nil {
		return -1
	}

	return 0
}

//export s3git_clone
func s3git_clone(url, path *C.char) int {

	_, err := s3git.Clone(C.GoString(url), C.GoString(path))
	if err != nil {
		return -1
	}

	return 0
}

//export s3git_add
func s3git_add(path, filename *C.char) *C.char {

	repo, err := s3git.OpenRepository(C.GoString(path))
	if err != nil {
		return C.CString("")
	}

	file, err := os.Open(C.GoString(filename))
	if err != nil {
		return C.CString("")
	}

	key, _, err := repo.Add(file)
	if err != nil {
		return C.CString("")
	}

	return C.CString(key)
}

//export s3git_commit
func s3git_commit(path, message *C.char) int {

	repo, err := s3git.OpenRepository(C.GoString(path))
	if err != nil {
		return -1
	}

	repo.Commit(C.GoString(message))

	return 0
}

//export s3git_get
func s3git_get(path, hash *C.char) *C.char {

	repo, err := s3git.OpenRepository(C.GoString(path))
	if err != nil {
		return C.CString("")
	}

	r, err := repo.Get(C.GoString(hash))
	if err != nil {
		return C.CString("")
	}

	buf := new(bytes.Buffer)
	buf.ReadFrom(r)
	s := buf.String()

	return C.CString(s)
}

//export s3git_push
func s3git_push(path *C.char) int {

	repo, err := s3git.OpenRepository(C.GoString(path))
	if err != nil {
		return -1
	}

	repo.Push(false, func(total int64) {})

	return 0
}

////export s3git_list
//func s3git_list(path, hash *C.char) *C.char {
//
//	repo, err := s3git.OpenRepository(C.GoString(path))
//	if err != nil {
//		return C.CString("")
//	}
//
//	list, _ := repo.List(C.GoString(hash))
//
//	for l := range list {
//
//	}
//
//	repo.Push(false, func(total int64) {})
//
//	return 0
//}

func main() {}
