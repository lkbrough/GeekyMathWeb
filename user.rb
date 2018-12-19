require 'data_mapper' # metagem, requires common plugins too.
require 'encryption'

# need install dm-sqlite-adapter
# if on heroku, use Postgres database
# if not use sqlite3 database I gave you
if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

class User
    include DataMapper::Resource
    property :id, Serial
    property :email, String
    property :password, String
    property :type, Integer, :default => 1

    def login(password)
        cnt = 0
        key = ""
        value = ""
        env_file = "config/local_env.txt"
        f = File.exists?(env_file)?File.open(env_file):nil
        if !f.nil?
            f.each_line do |line|
                ENV[key.to_s] = value.to_s if cnt > 0 and cnt % 2 == 0
                key = line.strip if cnt % 2 == 0
                value = line.strip if cnt % 2 == 1
                cnt = cnt + 1
            end
            ENV[key.to_s] = value.to_s
        end

        encryptor = Encryption::Symmetric.new
        encryptor.key = ENV['PASSWORD_KEY']

        decrypted = encryptor.decrypt(self.password)

    	return decrypted == password
    end

    def encrypt_password
        cnt = 0
        key = ""
        value = ""
        env_file = "config/local_env.txt"
        f = File.exists?(env_file)?File.open(env_file):nil
        if !f.nil?
            f.each_line do |line|
                ENV[key.to_s] = value.to_s if cnt > 0 and cnt % 2 == 0
                key = line.strip if cnt % 2 == 0
                value = line.strip if cnt % 2 == 1
                cnt = cnt + 1
            end
            ENV[key.to_s] = value.to_s
        end

        encryptor = Encryption::Symmetric.new
        encryptor.key = ENV['PASSWORD_KEY']
        self.password = encryptor.encrypt(self.password)

        self.save
    end

    def administrator
        return self.type == 0
    end

    def general
        return self.type == 1
    end

    def pro
        return self.type == 2
    end

    def teacher
        return self.type == 3
    end

end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
User.auto_upgrade!

