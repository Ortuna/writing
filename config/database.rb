DataMapper.logger = logger
DataMapper::Property::String.length(255)

case Padrino.env
  when :development then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "writingis_development.db"))
  when :production  then DataMapper.setup(:default, ENV['DATABASE_URL'])
  when :test        then DataMapper.setup(:default, "sqlite3://" + Padrino.root('db', "writingis_test.db"))
end
