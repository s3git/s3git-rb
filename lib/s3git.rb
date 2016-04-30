require 'ffi'
require 'json'
require 'tempfile'
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

  def self.add(input)
    stream = input.is_a?(String) ? StringIO.new(input) : input

    # TODO: Use actual stream instead of using temp file
    Tempfile.open('s3git') do |f|
      f.binmode
      f.write stream.read
      f.close
      S3gitBinding.s3git_add(@@path, f.path)
    end
  end

  def self.commit(message)
    S3gitBinding.s3git_commit(@@path, message)
  end

  def self.get(hash)
    tempfile = S3gitBinding.s3git_get(@@path, hash)
    open(tempfile) unless tempfile.empty?
  end

  def self.push(options = {})
    hydrate = options[:hydrate] if options.key? :hydrate
    S3gitBinding.s3git_push(@@path, hydrate)
  end

  def self.pull()
    S3gitBinding.s3git_pull(@@path)
  end

  def self.list(hash)
    result = S3gitBinding.s3git_list(@@path, hash)
    result.split(",")
  end

  def self.list_commits()
    json = S3gitBinding.s3git_list_commits(@@path)
    JSON.parse(json)
  end

  def self.remote_add(name, resource, options = {})
    access = options[:access_key] if options.key? :access_key
    secret = options[:secret_key] if options.key? :secret_key
    endpoint = options[:end_point] if options.key? :end_point
    S3gitBinding.s3git_remote_add(@@path, name, resource, access, secret, endpoint)
  end

  def self.snapshot_create(message)
    S3gitBinding.s3git_snapshot_create(@@path, message)
  end

  module S3gitBinding
    extend FFI::Library
    ffi_lib File.expand_path("../ext/libs3git.so", File.dirname(__FILE__))
    attach_function :s3git_init_repository, [:string], :int
    attach_function :s3git_open_repository, [:string], :int
    attach_function :s3git_clone, [:string, :string, :string, :string], :int
    attach_function :s3git_add, [:string, :string], :string
    attach_function :s3git_commit, [:string, :string], :int
    attach_function :s3git_push, [:string, :bool], :int
    attach_function :s3git_pull, [:string], :int
    attach_function :s3git_get, [:string, :string], :string
    attach_function :s3git_list, [:string, :string], :string
    attach_function :s3git_list_commits, [:string], :string
    attach_function :s3git_remote_add, [:string, :string, :string, :string, :string, :string], :int
    attach_function :s3git_snapshot_create, [:string, :string], :int
  end
end
