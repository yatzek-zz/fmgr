
# Changed em_postgresql adapter in database.yml to empostgresql because Heroku DATABASE_URL processing code
# throws exception: URI.parse(DB_URL) -> Invalid Url - underscore is not valid character in a url
#
# Rails load this file which requires the original non-blocking pg adapter.
# Also need to alias the connection method which is derived from adapter name.
# See: em-postgresql-adapter/lib/active_record/connection_adapters/em_postgresql_adapter.rb for more details

require 'em-postgresql-adapter'

module ActiveRecord
  class Base
    class << self
      alias empostgresql_connection em_postgresql_connection
    end
  end
end