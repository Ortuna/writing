# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

# require "#{PADRINO_ROOT}/vendor/kitana/kitana"
# Padrino::Logger::Config[:development][:log_level]  = :devel

Padrino.dependency_paths << "#{Padrino.root}/vendor/kitana/kitana.rb"
Padrino.before_load do; end

Padrino.after_load do
  DataMapper.finalize
end

Padrino.load!
