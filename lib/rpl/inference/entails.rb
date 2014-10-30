module Inference

  class Entails

    def self.entails?(kb, query)
      return check_all(kb, query, symbols, Rpl::Model.new)
    end

    private

    def check_all(kb, query, symbols, model)
      if symbols.empty?
        if model.is_true?(kb.as_sentence)
          return model.is_true?(query)
        else
          return true
      end
      
    end

    # public boolean ttCheckAll(KnowledgeBase kb, Sentence alpha,
    #     List<PropositionSymbol> symbols, Model model) {
    #   // if EMPTY?(symbols) then
    #   if (symbols.isEmpty()) {
    #     // if PL-TRUE?(KB, model) then return PL-TRUE?(&alpha;, model)
    #     if (model.isTrue(kb.asSentence())) {
    #       return model.isTrue(alpha);
    #     } else {
    #       // else return true // when KB is false, always return true
    #       return true;
    #     }
    #   }
    #
    #   // else do
    #   // P <- FIRST(symbols)
    #   PropositionSymbol p = Util.first(symbols);
    #   // rest <- REST(symbols)
    #   List<PropositionSymbol> rest = Util.rest(symbols);
    #   // return (TT-CHECK-ALL(KB, &alpha;, rest, model &cup; { P = true })
    #   // and
    #   // TT-CHECK-ALL(KB, &alpha;, rest, model U { P = false }))
    #   return ttCheckAll(kb, alpha, rest, model.union(p, true))
    #       && ttCheckAll(kb, alpha, rest, model.union(p, false));
    # }

    def symbols(sentences, query)
      result = []
      sentences.each do |sentence|
        result << sentence.symbols
      end
      result << query.symbols
      
      return result.flatten
    end

  end

end
