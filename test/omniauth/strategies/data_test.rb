# frozen_string_literal: true

require "test_helper"

class DataTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Netlify.new(app, "consumer_id", "consumer_secret")
  end

  test "returns raw info" do
    payload = {"id" => "ID"}
    access_token = mock("access_token")
    response = mock("response", parsed: payload)
    access_token
      .expects(:get)
      .with("https://api.netlify.com/api/v1/user")
      .returns(response)
    strategy.stubs(:access_token).returns(access_token)

    assert_equal Hash[:id, "ID"], strategy.raw_info
  end

  test "returns info" do
    raw_info = {id: "ID", full_name: "NAME", email: "EMAIL"}
    strategy.stubs(:raw_info).returns(raw_info)

    info = strategy.info

    assert_equal "ID", info[:id]
    assert_equal "NAME", info[:name]
    assert_equal "EMAIL", info[:email]
  end

  test "returns uid" do
    strategy.stubs(:info).returns(id: "ID")
    assert_equal "ID", strategy.uid
  end

  test "returns extra info" do
    raw_info = {raw: true}
    strategy.stubs(:raw_info).returns(raw_info)

    assert_equal raw_info, strategy.extra
  end

  test "returns authorize params" do
    session = {}
    request = Rack::Request.new("env.session" => {})
    strategy.stubs(:session).returns(session)
    strategy.stubs(:request).returns(request)
    strategy.stubs(:script_name).returns("")

    assert_equal "consumer_id", strategy.authorize_params.client_id
    assert_equal "/auth/netlify/callback",
                 strategy.authorize_params.redirect_uri
  end

  test "returns token params" do
    strategy.stubs(:callback_url).returns("/auth/netlify/callback")
    strategy.request.stubs(:params).returns("code" => "CODE")

    assert_equal "CODE", strategy.token_params.code
    assert_equal "/auth/netlify/callback", strategy.token_params.redirect_uri
    assert_equal "consumer_id", strategy.token_params.client_id
    assert_equal "consumer_secret", strategy.token_params.client_secret
    assert_equal "web_server", strategy.token_params.type
  end
end
