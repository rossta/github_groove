require 'spec_helper'
require_relative '../../../../apps/web/views/tickets/sync'

describe Web::Views::Tickets::Sync do
  let(:exposures) { Hash[foo: 'bar'] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/tickets/sync.html.erb') }
  let(:view)      { Web::Views::Tickets::Sync.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #foo' do
    view.foo.must_equal exposures.fetch(:foo)
  end
end
