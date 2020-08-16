class CommentsController < ApplicationController


  def create
    the_comment = Comment.new

    the_comment.author_id = params.fetch("query_author_id")
    the_comment.photo_id = params.fetch("query_photo_id")
    the_comment.body = params.fetch("query_body")

    the_comment.save

    redirect_to("/photos/#{the_comment.photo_id}")
  end

  def destroy
    id = params.fetch("the_comment_id")
    the_comment = Comment.where({ :id => id }).at(0)
    the_comment.destroy

    redirect_to("/photos")
  end

end
