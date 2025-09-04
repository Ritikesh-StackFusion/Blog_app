# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]

      def index
        posts = if params[:category].present?
                  Post.where("category ILIKE ?", "%#{params[:category]}%")
                else
                  Post.all
                end

        posts = posts.order(created_at: :asc).page(params[:page]).per(6)
        render json: posts.map { |post| post_json(post) }, status: :ok
      end

      def show
        render json: post_json(@post), status: :ok
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: post_json(post), status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: post_json(@post), status: :ok
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy!
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_json(post)
        post.as_json.merge({
          image_url: post.image.attached? ? url_for(post.image) : nil
        })
      end

      def post_params
        params.require(:post).permit(:title, :content, :author, :category, :image, tags: [])
      end
    end
  end
end
