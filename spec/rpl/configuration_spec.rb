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
    describe '#file_path' do
      it 'default value is the users home directory' do
        expect(Configuration.new.file_path).to eq(Dir.home)
      end
    end

    describe '#file_path=' do
      it 'can set another value' do
        config = Configuration.new
        config.file_path = '/usr/local/data'
        expect(config.file_path).to eq('/usr/local/data')
      end
    end

    describe '#file_name' do
      it 'default value is .rpl_data' do
        expect(Configuration.new.file_name).to eq('.rpl_data')
      end
    end

    describe '#file_name=' do
      it 'can set another value' do
        config = Configuration.new
        config.file_name = 'other_name'
        expect(config.file_name).to eq('other_name')
      end
    end
  end

end
