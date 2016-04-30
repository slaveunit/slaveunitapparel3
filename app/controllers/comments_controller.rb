class CommentsController < ApplicationController
	
# So admin abilities are applied to only these.  
# So public can view product without signing in.
  load_and_authorize_resource :only => [:new, :update, :create]
	
	def create
		@product = Product.find(params[:product_id])
		@comment = @product.comments.new(comment_params)
		@comment.user = current_user

	# VALIDATION
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @product, notice: "Review creation: SUCCESS"}
				format.json { render :show, status: :created, location: @product }
	
	# AJAX, display new comment after posting without reloading page.
			  	format.js
	# AJAX, display new comment after posting without reloading page.
	
			else
				format.html { redirect_to @product, alert: "Review creation: FAIL"}
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	# VALIDATION
	
	end

	# DELETE COMMENT
	def destroy
		@comment = Comment.find(params[:id])
		product = @comment.product
		@comment.destroy
		redirect_to product
	end
	# DELETE COMMENT

	def show
		@comments = @product.comments.order
	end
	
private

	def comment_params
		params.require(:comment).permit(:user_id, :body, :rating)
	end	

end
