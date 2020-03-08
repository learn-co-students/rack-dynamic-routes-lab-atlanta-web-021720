
class Application

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            search_item = req.path.split("/items/").last
            item_in_arr = @@items.select { |item| item.name == search_item }
            item_instance = item_in_arr.first
            if item_instance
                resp.write "Item price is #{item_instance.price}"
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


end