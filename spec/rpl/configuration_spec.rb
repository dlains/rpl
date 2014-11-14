require 'spec_helper'

module Rpl

  RSpec.describe Configuration do

    describe '#data_store' do
      it 'default value is file' do
        expect(Configuration.new.data_store).to eq('File')
      end
    end

    describe '#data_store=' do
      it 'can set another value' do
        config = Configuration.new
        config.data_store = 'Database'
        expect(config.data_store).to eq('Database')
      end
    end
  end

end
