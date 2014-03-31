require 'sinatra'
require 'sinatra/base'
#require 'sinatra/activerecord/rake'
require "./app"

#require 'pry'

task :environment do
  require_relative './config/environment'
end

namespace :db do
  task :migrate => [:environment] do
    require_relative './db/migrations/01_create_song_lib.rb'
    CreateSongLib.migrate(:up) if defined?(CreateSongLib)
  end


  task :seed => :environment do
    seed_file = File.join('./db/seeds.rb')
    load(seed_file) if File.exist?(seed_file)
  end
end
task :console => [:environment] do
  Pry.start
end