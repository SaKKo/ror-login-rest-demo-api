class Api::V1::User::BlogsController < Api::V1::User::AppController
  before_action :check_current_user
  before_action :set_blog, only: [:show, :update, :destroy]

  def index
    blogs = current_user.blogs
    render json: blogs.as_json
  end

  def show
    render json: @blog.as_json
  end

  def create
    blog = Blog.new(params_for_create)
    blog.user_id = current_user.id
    blog.save!
    render json: blog.as_json, status: :created
  end

  def update
    @blog.update!(params_for_update)
    render json: @blog.as_json
  end

  def destroy
    @blog.destroy!
    render json: { succes: true }
  end

  private

  def check_current_user
    current_user
  end

  def set_blog
    @blog = current_user.blogs.find(params[:id])
  end

  def params_for_create
    params.require(:blog).permit(:title, :body)
  end

  def params_for_update
    params.require(:blog).permit(:title, :body)
  end
end
