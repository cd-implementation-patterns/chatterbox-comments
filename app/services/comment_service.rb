require 'sinatra/base'

require 'models/comment'

class CommentService < Sinatra::Application
  COMMENT_PARAMS_WHITELIST = [:post_id, :user_id, :body]

  before do
    content_type :json
    database.logger = nil if settings.environment != :production
  end

  get '/post/:post_id/comments' do
    Comment.where(post_id: params[:post_id]).to_json
  end

  get '/comments/:id'do
    Comment.find(params[:id]).to_json
  end

  post '/comments' do
    comment = Comment.create!(allowed_params)

    status 201
    {status: 'ok', comment: comment}.to_json
  end

  patch '/comment/:id' do
    comment = Comment.find(params[:id])
    comment.update!(allowed_params)

    {status: 'ok', comment: comment}.to_json
  end

  delete '/comment/:id' do
    Comment.delete(params[:id])

    status 204
  end

  get '/healthcheck' do
    {app: 'comments-service', database: fetch_db_status}.to_json
  end

  private
  def allowed_params
    params.with_indifferent_access.slice(*COMMENT_PARAMS_WHITELIST)
  end

  def fetch_db_status
    begin
      database.connection.verify!(0)
      database.connection.select_value("SELECT NOW()")
      true
    end rescue false
  end
end