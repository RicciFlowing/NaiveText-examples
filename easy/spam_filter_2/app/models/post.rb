class Post < ActiveRecord::Base
  scope :spam, ->{ where(content_type: 'spam') }
  scope :content, ->{ where.not(content_type: 'spam') }
  scope :verified, ->{ where(content_type: 'verified_content') }
end
