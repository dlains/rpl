require 'spec_helper'

module Rpl
  module Data
    RSpec.describe FileDataStore do
      before do
        @file_path = File.join(data_dir, 'rpl_test.kb')
      end
      
      after do
        if Dir.exists?(File.dirname(@file_path))
          FileUtils.rm_r(File.dirname(@file_path))
        end
      end

      describe '#save' do
        before do
          @kb = Rpl::KnowledgeBase.new
          @kb.tell('PA and PB')
        end

        it 'raises an error if the arguments are invalid' do
          expect{FileDataStore.new(@file_path).save(nil)}.to raise_error(ArgumentError)
        end

        it 'should create the directory if it does not already exist' do
          FileDataStore.new(@file_path).save(@kb)
          expect(Dir.exist?(File.dirname(@file_path))).to eq(true)
        end

        it 'save knowledge base data to a file' do
          FileDataStore.new(@file_path).save(@kb)
          expect(File.exists?(@file_path)).to eq(true)
        end
      end

      describe '#load' do
        before do
          kb = Rpl::KnowledgeBase.new
          kb.tell('PA and PB')
          kb.tell('PB implies (PC or PD)')
          FileDataStore.new(@file_path).save(kb)
        end

        it 'raises an error if the arguments are invalid' do
          expect{FileDataStore.new(@file_path).load(nil)}.to raise_error(ArgumentError)
        end

        it 'loads knowledge base data from a file', force: true do
          kb = Rpl::KnowledgeBase.new
          FileDataStore.new(@file_path).load(kb)
          expect(kb.sentences.size).to eq(2)
          expect(kb.sentences[0].to_s).to eq('PA and PB')
          expect(kb.sentences[1].to_s).to eq('PB implies PC or PD')
        end
      end

    end
  end
end
