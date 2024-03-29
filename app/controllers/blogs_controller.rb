class BlogsController < ApplicationController
  # Authenticate user
  before_action :authenticate_user!, except: [:index, :show, :lazy_load_blogs]
  before_action :set_blog, only: %i[ show edit update destroy ]

  # Needed for image URLs to be accessible
  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  # GET /blogs
  def index
  end

  # GET /blogs/:title
  def show
    # Eager load with_attached images
    @blog = Blog.where(draft: false).includes(:cover_image_attachment).friendly.find(params[:id])
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/:title/edit
  def edit
  end

  # Rendered via content-loader in index.
  def lazy_load_blogs
    @blogs = Blog.where(draft: false).includes(
      { cover_image_attachment: :blob }, :categories).order(created_at: :desc).page params[:page]
    render partial: "shared/blogs_collection",
           locals: {
             blogs: @blogs,
             controller_named: "blogs",
             action_named: "index"
           }
  end

  # Update draft status and publish blog
  def publish
    blog = Blog.find(params[:id])
    blog.update!(draft: false)
    redirect_to blog_url(blog)
  end

  # POST /blogs
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        # Check to see if this is a draft blog first.
        if @blog.draft
          format.html { redirect_to admin_panel_url }
        else
          format.html { redirect_to blog_url(@blog), notice: "Blog was successfully created." }
          format.json { render :show, status: :created, location: @blog }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/:title or /blogs/:title.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        # Check to see if this has been updated to a draft blog first.
        if @blog.draft
          format.html { redirect_to admin_panel_url }
        else
          format.html { redirect_to blog_url(@blog), notice: "Blog was successfully updated." }
          format.json { render :show, status: :ok, location: @blog }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/:title or /blogs/:title.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:title, :body, :cover_image, :draft, :category_ids => [])
  end
end
