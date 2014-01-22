require 'active_record'

namespace :db do

  task :configuration do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: 'db/sqlite3.db'
    )
  end

  desc "Migrate the database."
  task :migrate => :configuration do
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'users'
        create_table :users do |t|
          t.string :account, limit: 50, null: false
          t.string :name, limit: 50
          t.string :phone, limit: 20
          t.string :status, limit: 20, null: false
          t.datetime :last_signined_at
          t.timestamps
        end
      end

      unless ActiveRecord::Base.connection.tables.include? 'captchas'
        create_table :captchas do |t|
          t.references :user, null: false
          t.string :content, limit: 8, null: false
          t.string :operation, limit: 20, null: false
          t.boolean :available, default: true, null: false
          t.datetime :expired_at, null: false
          t.timestamps
        end
      end

      unless ActiveRecord::Base.connection.tables.include? 'tokens'
        create_table :tokens do |t|
          t.references :user, null: false
          t.string :content, limit: 32, null: false
          t.timestamps
        end
      end
    end
  end

  desc "Delete the database."
  task :drop => :configuration do
    ActiveRecord::Schema.define do
      if ActiveRecord::Base.connection.tables.include? 'users'
        drop_table :users
      end

      if ActiveRecord::Base.connection.tables.include? 'captchas'
        drop_table :captchas
      end

      if ActiveRecord::Base.connection.tables.include? 'tokens'
        drop_table :tokens
      end
    end
  end
end