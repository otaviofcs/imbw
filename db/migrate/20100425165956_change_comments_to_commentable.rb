class ChangeCommentsToCommentable < ActiveRecord::Migration
  def self.up
    add_column :comments, :commentable_type, :string
    add_column :comments, :commentable_id, :integer
    @comments = Comment.all
    @comments.each do |comment|
      comment.commentable_type = 'Gallery'
      comment.commentable_id = comment.gallery_id
      comment.save!
    end
    remove_column :comments, :gallery_id

  end

  def self.down
    add_column :comments, :gallery_id, :integer
    @comments = Comment.all
    @comments.each do |comment|
      comment.gallery_id = comment.commentable_id
      comment.save!
    end
    remove_column :comments, :commentable_type
    remove_column :comments, :commentable_id

  end
end
