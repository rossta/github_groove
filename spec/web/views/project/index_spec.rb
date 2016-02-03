require 'spec_helper'
require_relative '../../../../apps/web/views/project/index'

describe Web::Views::Project::Index do
  let(:params)    { Hanami::Action::Params.new({}) }
  let(:exposures) { Hash[project: nil, tickets: [], params: params] }
  let(:template)  { Hanami::View::Template.new("apps/web/templates/project/index.html.erb") }
  let(:view)      { Web::Views::Project::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it "exposes #project" do
    view.project.must_equal exposures.fetch(:project)
  end

  describe "when there is no project" do
    it "shows a placeholder message" do
      rendered.must_include("Groove Project Token")
      rendered.must_include("Please enter your Groove API access token from your groove settings page")
    end
  end

  describe "when there is a project" do
    let(:project)     { Project.new(groove_access_token: "aaa") }
    let(:exposures) { Hash[project: project, params: params] }

    it "list project" do
      rendered.must_include("Groove Project Token")
      rendered.scan(/class="project"/).count.must_equal 1
      rendered.scan(/value="aaa"/).count.must_equal 1
    end

    it "hides the placeholder message" do
      rendered.wont_include("<p class=\"placeholder\">There is no Groove project yet.</p>")
    end
  end
end
