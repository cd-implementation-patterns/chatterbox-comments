describe CommentService do
  let(:json_response) { ActiveSupport::JSON.decode(last_response.body) }
  let(:a_comment) { FactoryGirl.build(:comment) }
  let(:some_comments) {
    2.times.collect{ FactoryGirl.build(:comment) }
  }

  it "provides a list of comments for a post" do
    expect(Comment).to receive(:where).with(post_id: 'my-first-service')
      .and_return(some_comments)

    get '/post/my-first-service/comments'

    expect(last_response).to be_ok
    expect(last_response.content_type).to eq("application/json")

    expect(json_response).to match(some_comments.map(&:attributes))
  end

  it "fetches a comment data" do
    expect(Comment).to receive(:find).with('a-specific-comment')
      .and_return(a_comment)

    get '/comments/a-specific-comment'

    expect(last_response).to be_ok
    expect(last_response.content_type).to eq("application/json")

    expect(json_response).to match(a_comment.attributes)
  end

  it "creates a comment" do
    params = FactoryGirl.attributes_for(:comment).stringify_keys

    post '/comments', params

    expect(last_response.status).to be(201)
    expect(last_response.content_type).to eq("application/json")

    expect(json_response).to match(a_hash_including \
      'status' => 'ok',
      'comment' => hash_including(params)
    )
  end

  it "changes a comment" do
    expect(Comment).to receive(:find).with('a-specific-comment')
      .and_return(a_comment)

    params = FactoryGirl.attributes_for(:comment).stringify_keys

    patch '/comment/a-specific-comment', params

    expect(last_response.status).to be(200)

    expect(json_response).to match(a_hash_including \
      'status' => 'ok',
      'comment' => hash_including(params)
    )
  end

  it "deletes a comment" do
    expect(Comment).to receive(:delete).with('a-specific-comment')

    delete '/comment/a-specific-comment'

    expect(last_response.status).to be(204)
    expect(last_response.content_type).to be_nil

    expect(last_response.body).to eq("")
  end

  it "has a healthcheck" do
    get '/healthcheck'

    expect(last_response).to be_ok
    expect(json_response).to match(a_hash_including \
      'app' => 'comments-service',
      'database' => true
    )
  end
end