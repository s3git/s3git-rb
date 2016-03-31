s3git-rb
========

This is the Ruby interface for [s3git](https://github.com/s3git/s3git).

It is based on the [s3git-go](https://github.com/s3git/s3git-go) package that is invoked via foreign function interface (FFI) as described [here](https://github.com/ffi/ffi).

Install
-------

Assuming you have rails installed, do as follows:

```sh
$ rails new s3git-test
$ cd s3git-test
$ # Add s3git to Gemfile
$ echo 'gem "s3git", :git => "git://github.com/s3git/s3git-rb.git"' >> Gemfile
$ bundle update
```

Clone the repository
Describe how to install
For now you must have a working Golang environment installed, otherwise the Gem will not compile

Create a repository
-------------------

```rb
$ irb
> require "s3git"
> S3git.init_repository "."
> S3git.add "MyVideo.mpg"
> S3git.commit "My first s3git commit from Ruby"
> exit
$ s3git log
```

Clone a repository
------------------

```rb
> require "s3git"
> S3git.clone "s3://s3git-spoon-knife", ".", {accessKey: "AKIAJYNT4FCBFWDQPERQ", secretKey: "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"}
> S3git.list "" { |l| puts l } 
```

Make changes and push
---------------------

```rb
> require "s3git"
> S3git.add "picture.jpg"
> S3git.commit "Added a picture"
> S3git.push
```

Pull down changes
-----------------

```rb
> require "s3git"
> S3git.pull
> S3git.log
```

Extract data
------------

```rb
> require "s3git"
> S3git.get "01234567"
```
