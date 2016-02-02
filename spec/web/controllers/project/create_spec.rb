require 'spec_helper'
require_relative '../../../../apps/web/controllers/project/create'

describe Web::Controllers::Project::Create do
  let(:action) { Web::Controllers::Project::Create.new }
  let(:params) { Hash['warden' => warden] }

  before do
    UserRepository.clear
    ProjectRepository.clear
  end

  describe "authenticated" do
    let(:project_params) { Hash[project: { groove_access_token: "aabbcc", github_repository: "rossta/github_groove" }] }

    before do
      user = UserRepository.create(
        User.new(github_id: 123, nickname: "rossta", github_access_token: "aaa")
      )
      warden.set_user user
    end

    it "redirects" do
      response = action.call(params.merge(project_params))
      response[0].must_equal 302
    end

    it "creates project" do
      action.call(params.merge(project_params))
      ProjectRepository.all.count.must_equal 1
    end

    it "renders validation error" do
      response = action.call(params)
      response[0].must_equal 200
    end
  end

  describe "visitor" do
    it "redirects" do
      -> { action.call(params) }.must_throw :warden
    end

    it "does not create project" do
      catch(:warden) { action.call(params) }
      ProjectRepository.all.count.must_equal 0
    end
  end
end
