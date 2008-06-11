require 'init'
require 'rubygems'
require 'activerecord'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/db/debug.log")

databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))

# Specify sqlite dbfile location independently
databases["sqlite3"][:dbfile] = plugin_spec_dir + "/db/wizardry.sqlite3.db"

ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(plugin_spec_dir, "db", "schema.rb"))
