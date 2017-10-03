class PostsController < ApplicationController

  swagger_controller :posts, 'Post Management'

  swagger_api :index do
    summary 'Fetch all posts items'
    notes 'this list all the active posts'
    param :page, :integer, :optional, 'page number'
    param :per_page, :integer, :optional, 'per page size'
    response :unauthorized
    response :not_acceptable, 'The request you made is not acceptable'
    response :requested_range_not_satisfiable
  end

  def index
    @posts = Post.page(params[:page]).per(params[:per_page])
    render json: @posts, meta: pagination_dict(@posts)
  end

  swagger_api :show do
    summary 'get post'
    notes 'get post by id'
    param :id, :integer, :required, 'post id'
    response :ok, 'Success', :User
    response :unauthorized
    response :not_acceptable
    response :not_found
  end

  def show
    @post = Post.find params[:id]
    render json: @post if stale? @post
  end

  swagger_model :Post do
    description 'A Tag object.'
    property :id, :integer, :required, 'post Id'
    property :title, :string, :required, 'Title'
    property :body, :string, :required, 'body'
  end
end
