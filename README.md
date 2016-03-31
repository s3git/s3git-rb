s3git-rb
========

[![Join the chat at https://gitter.im/s3git/s3git](https://badges.gitter.im/s3git/s3git.svg)](https://gitter.im/s3git/s3git?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is the Ruby interface for [s3git](https://github.com/s3git/s3git). Please see [here](https://github.com/s3git/s3git/blob/master/README.md) for a general introduction to s3git including its use cases.

This Ruby Gem is based on the [s3git-go](https://github.com/s3git/s3git-go) package that is invoked via foreign function interface (FFI) as described [here](https://github.com/ffi/ffi).

**DISCLAIMER: This software is still under development (although the storage format/model is stable) -- use at your own peril for now**

**Note that the API is not stable yet, you can expect minor changes/extensions**

Install
-------

Please make sure you have a working Golang environment installed, otherwise the s3git Gem will not compile (ie. `go build -buildmode=c-shared -o libs3git.so libs3git.go` as in the `\ext` subdir). See [install golang](https://github.com/minio/minio/blob/master/INSTALLGO.md) for setting up a working Golang environment.

Assuming you have rails installed, do as follows:

```sh
$ rails new s3git-test
$ cd s3git-test
$ # Add s3git to Gemfile
$ echo 'gem "s3git", :git => "git://github.com/s3git/s3git-rb.git"' >> Gemfile
$ bundle update
```

That's it -- you are now ready to do your first experiment as listed below.

Create a repository
-------------------

```rb
$ irb
> require 'bundler/setup'
> require 's3git'
> S3git.init_repository '.'
> S3git.add 'hello s3git'
> S3git.commit 'My first s3git commit from Ruby'
> exit
# show commit history
$ s3git log --pretty
66aac2f7e3fe675215cd3cf491d5adb31d270c29dc9b40aa50c6c8606cf5eb784b250a4f181caccea393a34b2ba522f2a0678685014bc27caf987fc13c3bef76 My first s3git commit from Ruby
$ s3git ls
c518dc5f1d95258dc91f6d285e7ea7300f37dea4dd517173f2e23afe0cb52bc9d8eb18683cdcf377e96a2d5a81585e61f6d27fa5d017cad53836bd050e9f105f
$ s3git cat c518dc5f1d95258dc91f6d285e7ea7300f37dea4dd517173f2e23afe0cb52bc9d8eb18683cdcf377e96a2d5a81585e61f6d27fa5d017cad53836bd050e9f105f
hello s3git
```

Clone a repository
------------------

```rb
> require 'bundler/setup'
> require 's3git'
> require 'tmpdir'
> S3git.clone 's3://s3git-spoon-knife', Dir.mktmpdir, {access_key: 'AKIAJYNT4FCBFWDQPERQ', secret_key: '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'}
> S3git.list('').each { |hash| puts hash } 
```

Dump contents of a repository
-----------------------------

```rb
> %w(bundler/setup s3git tmpdir open-uri).each { |gem| require gem } 
> S3git.init_repository Dir.mktmpdir
> S3git.add 'hello s3git'
> S3git.add 'Ruby rocks'
> S3git.add open('https://github.com/s3git/s3git/blob/master/README.md')
> S3git.add open('local-file.txt')
> S3git.list('').each { |hash| puts S3git.get(hash).read } 
```

List multiple commits
---------------------

```rb
> %w(bundler/setup s3git tmpdir).each { |gem| require gem } 
> S3git.init_repository Dir.mktmpdir
> S3git.add 'first file'
> S3git.commit 'first commit'
> S3git.add 'second file'
> S3git.commit 'second commit'
> S3git.list_commits.each { |c| puts c["Message"] } 
```

Limitations and Optimizations
-----------------------------

- Streams are not yet natively supported (temp files are used under the hood)
- Methods that return arrays (eg. log or list) are currently limited to a maximum of 1000 responses
- Proper error handling is largely missing

Contributions
-------------

Contributions are welcome, please submit a pull request for any enhancements.

License
-------

s3git-rb is released under the Apache License v2.0. You can find the complete text in the file LICENSE.
