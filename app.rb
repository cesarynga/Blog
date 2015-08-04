#coding:utf-8
require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'sqlite3'
require_relative 'config/init'

ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(:development)
