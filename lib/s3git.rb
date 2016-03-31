require 'ffi'
require "s3git/version"

module S3git
  @@path

  def self.init_repository(path)
    @@path = path
    S3gitBinding.s3git_init_repository(@@path)
  end

  def self.open_repository(path)
    @@path = path
    S3gitBinding.s3git_open_repository(@@path)
  end

  def self.clone(url, path)
    @@path = path
    S3gitBinding.s3git_clone(url, @@path)
  end

  def self.add(filename)
    S3gitBinding.s3git_add(@@path, filename)
  end

  def self.commit(message)
    S3gitBinding.s3git_commit(@@path, message)
  end

  def self.get(hash)
    S3gitBinding.s3git_get(@@path, hash)
  end

  def self.push()
    S3gitBinding.s3git_push(@@path)
  end

  module S3gitBinding
    extend FFI::Library
    ffi_lib File.expand_path("../ext/libs3git.so", File.dirname(__FILE__))
    attach_function :s3git_init_repository, [:string], :int
    attach_function :s3git_open_repository, [:string], :int
    attach_function :s3git_add, [:string, :string], :string
    attach_function :s3git_commit, [:string, :string], :int
    attach_function :s3git_push, [:string, ], :int
    attach_function :s3git_get, [:string, :string], :string
  end
end
