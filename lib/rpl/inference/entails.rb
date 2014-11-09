module Rpl::Inference

  class Entails

    def entails?(kb, query)
      return check_all(kb, query, identifiers(kb.as_sentence, query), Rpl::Model.new)
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

      symbol = symbols.shift
      return check_all(kb, query, symbols.dup, model.union(symbol, true)) && check_all(kb, query, symbols.dup, model.union(symbol, false))
    end

    def identifiers(sentence, query)
      result = []
      result << sentence.identifiers
      result = result.uniq
      result << query.identifiers
      
      return result.flatten
    end

  end

end
