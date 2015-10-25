require_relative 'enviroment'


class CreatePostsTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :text
      t.boolean :vote
    end
    puts 'ran up method'
  end

  def down
    drop_table :posts
    puts 'ran down method'
  end
end

CreatePostsTable.migrate(:up)
