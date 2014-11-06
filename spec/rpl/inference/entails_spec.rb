require 'spec_helper'

module Rpl::Inference

  describe Entails do

    before do
      @kb = Rpl::KnowledgeBase.new
    end

    describe '::entails?' do
      it 'work with the wumpus world example' do
        @kb.tell("not Pit11")
        @kb.tell("Breeze11 iif Pit12 or Pit21")
        @kb.tell("Breeze21 iif Pit11 or Pit22 or Pit31")
        @kb.tell("not Breeze11")
        @kb.tell("Breeze21")

        expect(@kb.ask("not Pit12")).to eq(true)
        expect(@kb.ask("Pit22")).to eq(true)
        # Assert.assertEquals(true, kb.askWithTTEntails("~P12"));
        # Assert.assertEquals(false, kb.askWithTTEntails("P22"));
      end
    end

  end

end
