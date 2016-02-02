require 'spec_helper'
require_relative '../../../../apps/web/views/project/create'

describe Web::Views::Project::Create do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/project/create.html.erb') }
  let(:view)      { Web::Views::Project::Create.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
