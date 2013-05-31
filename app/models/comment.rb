class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  # NOTE: :created_at and :user_id should not normally be included
  # however, they're both needed to override the default values
  # for the rake db:seed task that migrates old data
  # After the initial migration, these two values should be
  # removed.
  attr_accessible :title, :comment, :created_at, :user_id
end
