require 'spec_helper'
require_relative '../../../../apps/web/views/issues/create'

describe Web::Views::Issues::Create do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/issues/create.html.erb') }
  let(:view)      { Web::Views::Issues::Create.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
