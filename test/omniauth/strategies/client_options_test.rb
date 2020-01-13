# frozen_string_literal: true

require "test_helper"

class ClientOptionsTest < Minitest::Test
  let(:app) { ->(env) { } }

  let(:strategy) do
    OmniAuth::Strategies::Netlify.new(app, "consumer_id", "consumer_secret")
  end

  test "sets name" do
    assert_equal "netlify", strategy.options.name
  end

  test "sets authorize url" do
    assert_equal "https://app.netlify.com/authorize",
                 strategy.options.client_options.authorize_url
  end

  test "sets token url" do
    assert_equal "https://api.netlify.com/oauth/token",
                 strategy.options.client_options.token_url
  end
end
