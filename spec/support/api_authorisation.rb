shared_context 'api_authorisation' do
  let(:dashboard)   { FactoryGirl.create(:dashboard_with_widgets) }
  let(:user)        { FactoryGirl.create(:user_with_token, :dashboards => [dashboard]) }
  let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

  before do
    request.env["HTTP_AUTHORIZATION"] = authorization
  end

  def datapoint_json(datapoint)
    "{\"id\":#{datapoint.id}"
  end
end
