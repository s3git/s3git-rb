s3git-rb
========

[![Join the chat at https://gitter.im/s3git/s3git](https://badges.gitter.im/s3git/s3git.svg)](https://gitter.im/s3git/s3git?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

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
> require 'bundler/setup'
> require 's3git'
> S3git.init_repository ."
> S3git.add "MyVideo.mpg"
> S3git.commit "My first s3git commit from Ruby"
> exit
$ s3git log
$ s3git ls
```

Clone a repository
------------------

```rb
> require 'bundler/setup'
> require 's3git'
> require 'tmpdir'
> S3git.clone "s3://s3git-spoon-knife", Dir.mktmpdir, {access_key: "AKIAJYNT4FCBFWDQPERQ", secret_k_ey: "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"}
> S3git.list("").each { |hash| puts hash } 
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

Contributions
-------------

Contributions are welcome, please submit a pull request for any enhancements.

License
-------

s3git-rb is released under the Apache License v2.0. You can find the complete text in the file LICENSE.
