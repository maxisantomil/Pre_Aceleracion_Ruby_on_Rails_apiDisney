class CharactersSearchService
    
    def self.search(curr_characters,query)
        curr_characters.where("title like '%#{query}%'")
    end

end 