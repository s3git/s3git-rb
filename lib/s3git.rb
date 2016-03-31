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

  def self.clone(url, path, options = {})
    @@path = path
    access = options[:access_key] if options.key? :access_key
    secret = options[:secret_key] if options.key? :secret_key
    S3gitBinding.s3git_clone(url, @@path, access, secret)
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

  def self.list(hash)
    result = S3gitBinding.s3git_list(@@path, hash)
    result.split(",")
  end

  module S3gitBinding
    extend FFI::Library
    ffi_lib File.expand_path("../ext/libs3git.so", File.dirname(__FILE__))
    attach_function :s3git_init_repository, [:string], :int
    attach_function :s3git_open_repository, [:string], :int
    attach_function :s3git_clone, [:string, :string, :string, :string], :int
    attach_function :s3git_add, [:string, :string], :string
    attach_function :s3git_commit, [:string, :string], :int
    attach_function :s3git_push, [:string, ], :int
    attach_function :s3git_get, [:string, :string], :string
    attach_function :s3git_list, [:string, :string], :string
  end
end
