#require 'pry'
require 'bundler/setup'
Bundler.require(:default)
require "net/http"
require "uri"
require 'fileutils'
require 'geocoder'

require_relative '../app'
require_relative '../models/library'
require_relative '../models/helpers'



Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 40.7143528,
      'longitude'    => -74.0059731,
      'address'      => 'New York, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :database => 'db/development.sqlite3'
   )


# configure :development do
#  set :database, 'sqlite:///dev.db'
#  set :show_exceptions, true
# end

# configure :production do
#  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

#  ActiveRecord::Base.establish_connection(
#    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#    :host     => db.host,
#    :username => db.user,
#    :password => db.password,
#    :database => db.path[1..-1],
#    :encoding => 'utf8'
#  )
# end