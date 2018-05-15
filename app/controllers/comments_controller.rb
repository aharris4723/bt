class CommentsController < ApplicationController
def index
        @comments = Comment.all
    end

    def new
        @user = User.find(current_user.id)
        @post = Post.find(params[:post_id])
        @comment = Comment.new
    end

    def create

        user = User.find(current_user.id)
        comment = Comment.new(comment_params)
        comment.user_id = current_user.id
        if comment.save!
            flash[:message] = 'Your comment was posted'
            redirect_to "/posts/#{comment.post_id}"
        else
            flash[:message] = 'try again'
            render 'comments/new'
        end
    end

    def show
        @post = Post.find_by_id(params[:id])
        @comment = Comment.new

    end

    def edit
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        @comment = Comment.find(params[:id])
        @post = Post.find_by_id(params[:id])
        if @comment.update(comment_params)
            flash[:message] = 'Your comment was edited'
            redirect_to "/comments"
        else
            flash[:message] = 'try again'
            render "/comments/#{@comment.id}/edit"
        end
    end

    def destroy
        @post = Post.find_by_id(params[:id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to "/posts/#{@comment.post_id}"
    end

private

def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id)
end
end