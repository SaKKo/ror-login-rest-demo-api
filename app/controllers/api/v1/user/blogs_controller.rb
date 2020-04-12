class Api::V1::User::BlogsController < Api::V1::User::AppController
  before_action :set_blog, only: [:show, :update, :destroy]

  def index
    blogs = Blog.last(30)
    render json: blogs.as_json
  end

  def show
    render json: @blog.as_json
  end

  def create
    blog = Blog.create!(params_for_create)
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

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def params_for_create
    params.require(:blog).permit(:title, :body)
  end

  def params_for_update
    params.require(:blog).permit(:title, :body)
  end
end
