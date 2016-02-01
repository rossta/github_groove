require 'spec_helper'
require_relative '../../../../apps/web/views/session/destroy'

describe Web::Views::Session::Destroy do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/session/destroy.html.erb') }
  let(:view)      { Web::Views::Session::Destroy.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
