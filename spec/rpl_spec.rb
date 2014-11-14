require 'spec_helper'

RSpec.describe Rpl do

  describe '#configure' do
    before do
      Rpl.configure do |config|
        config.data_store = 'Database'
      end
    end

    it 'should report that the knowledge base will be stored in a databse' do
      expect(Rpl.configuration.data_store).to eq('Database')
    end
  end
end