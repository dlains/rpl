require 'spec_helper'

module Rpl::Inference

  describe Entails do

    before do
      @kb = Rpl::KnowledgeBase.new
    end

    describe '::entails?' do
      it 'returns true for a simple conjunction' do
        @kb.tell('PA and PB')
        expect(@kb.ask("PA")).to eq(true)
      end
      
      it 'returns false for a simple disjunction' do
        @kb.tell('PA or PB')
        expect(@kb.ask('PA')).to eq(false)
      end

      it 'returns true for a simple implication' do
        @kb.tell('(PA implies PB) and PA')
        expect(@kb.ask('PA')).to eq(true)
      end

      it 'returns false for a different implication' do
        @kb.tell('(PA implies PB) and PB')
        expect(@kb.ask('PA')).to eq(false)
      end

      it 'returns false for a simple negation' do
        @kb.tell('PA')
        expect(@kb.ask('not PA')).to eq(false)
      end

      it 'returns false for unknown identifiers' do
        @kb.tell('(PA implies PB) and PB')
        expect(@kb.ask('X')).to eq(false)
      end

      it 'works with the wumpus world example', force: true do
        @kb.tell("not Pit11")
        @kb.tell("Breeze11 iif Pit12 or Pit21")
        @kb.tell("Breeze21 iif Pit11 or Pit22 or Pit31")
        @kb.tell("not Breeze11")
        @kb.tell("Breeze21")

        expect(@kb.ask("not Pit12")).to eq(true)
        expect(@kb.ask("Pit22")).to eq(false)
      end
    end

  end

end
