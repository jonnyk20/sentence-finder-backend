class SentencesController < ApplicationController
  def search
    word = params[:word]
    language_from = params[:language_from]
    language_to = params[:language_to]

    sentences = Sentence.search(word).records.includes(:translations).where({ language: language_from })

    mapped = sentences.map { |s| s.get_translations(language_to) }

    puts 'MAPPED'
    puts mapped
    puts mapped.length
    
    
    filtered = mapped.select do |s|
      s[:translations].length != 0
    end

    puts 'filtered'
    puts filtered.length
  
    vocab_item = {
      word: word,
      sentences: filtered
    }


    res = {
      vocab_item: vocab_item
    }

    json_response(res)
  end
end
