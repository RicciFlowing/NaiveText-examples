require_relative 'enviroment'
require_relative 'text_creator'

class CreatePostsTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :text
      t.string :content_type
    end
    puts 'ran up method'
  end

  def down
    drop_table :posts
    puts 'ran down method'
  end
end

CreatePostsTable.migrate(:up)
