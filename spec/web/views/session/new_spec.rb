require 'spec_helper'
require_relative '../../../../apps/web/views/session/new'

describe Web::Views::Session::New do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/session/new.html.erb') }
  let(:view)      { Web::Views::Session::New.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
