require "spec_helper"
require_relative "../../../../apps/web/controllers/project/index"

describe Web::Controllers::Project::Index do
  let(:action) { Web::Controllers::Project::Index.new }
  let(:params) { Hash["warden" => warden] }

  before do
    UserRepository.clear
    ProjectRepository.clear
  end

  describe "authenticated" do
    let(:project) { ProjectRepository.create(Project.new(groove_access_token: "aaa")) }
    let(:user) do
      UserRepository.create(
        User.new(github_id: 123, nickname: "rossta", project_id: project.id, github_access_token: "aaa")
    )
    end

    before do
      warden.set_user user
    end

    it "renders" do
      response = action.call(params)
      response[0].must_equal 200
    end

    it "exposes current user project" do
      action.call(params)
      action.exposures[:project].must_equal project
    end
  end

  describe "visitor" do
    it "throws warden" do
      -> { action.call(params) }.must_throw :warden
    end
  end
end
