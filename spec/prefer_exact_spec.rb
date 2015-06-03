require 'spec_helper'

RSpec.describe Capybara do
  describe ':prefer_exact option' do
    before {
      @original = Capybara.match
      Capybara.match = :prefer_exact
    }

    after {
      Capybara.match = @original
    }

    let :string do
      Capybara.string <<-STRING
        <html>
          <head>
            <title>simple_node</title>
          </head>
          <body>
            <label id="wrong">Some Fund</label>
            <label id="right">Fund</label>
          </body>
        </html>
      STRING
    end

    it "allows using matchers" do

      label = string.find(:css, 'label', :text => 'Fund')
      expect(label['id']).to eq('right')
    end
  end
end
