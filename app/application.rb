class Application
    
    # @@items = [Item.new("bose1",10), Item.new("bose2",20)]
    @@items = []
    @@cart = []
    
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
  
      if req.path.match(/items/)
        item_name = req.path.split("/items/").last
        item = @@items.find{|item| item.name == item_name}
        if item
            resp.write item.price
        else
            resp.write "Item not found"
            resp.status = 400
        end
 
      else
        resp.write "Route not found"
        resp.status = 404
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

# items = [Item.new("bose1",10), Item.new("bose2",20)]
# retArray = []    
# items.map do |item| 
#     if item.name == "bose1" 
#         retArray << item.price     
#     end    
#     retArray 
# end