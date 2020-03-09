require 'pry'
require_relative 'item.rb'
array1 = [1,2,3,4,5].select { |num|  num.even?  }
items = [Item.new("bose1",10), Item.new("bose2",20)]
items.select do |item| item.name == "bose1" end

retArray = []    
items.map do |item| 
    if item.name == "bose1" 
        retArray << item.price     
    end    
    retArray 
end
binding.pry


class Application
 
    @@songs = [Song.new("Sorry", "Justin Bieber"),
              Song.new("Hello","Adele")]
   
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
   
      if req.path.match(/songs/)
   
        song_title = req.path.split("/songs/").last #turn /songs/Sorry into Sorry
        song = @@songs.find{|s| s.title == song_title}
   
        resp.write song.artist
      end
   
      resp.finish
    end
  end


class Application

    @@items = ["Apples","Carrots","Pears"]
    @@cart = []
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        @@items.each do |item|
          resp.write "#{item}\n"
        end
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)
      elsif req.path.match(/cart/)
        resp.write handle_cart
      elsif req.path.match(/add/)
        add_term = req.params["item"]
        resp.write handle_add(add_term)
      else
        resp.write "Path Not Found"
      end
  
      resp.finish
    end
  
    def handle_cart
      retVal = "Your cart is empty"
      if(@@cart.length > 0)
        @@cart.each do |cart_item|
          retVal = retVal + "#{cart_item}\n"
        end
      end
      return retVal
    end
  
    def handle_add(add_term)
      if @@items.include?(add_term)
        @@cart<<add_term
        return "added #{add_term}"
      else
        return "We don't have that item"
      end
    end
    
    def handle_search(search_term)
      if @@items.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{search_term}"
      end
    end
  end
  