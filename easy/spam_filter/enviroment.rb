require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'DB',
  username: 'DB_USER',
  password: 'DB_PASS',
  host:     'localhost'
)
