require 'pry'

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)



    if req.path.match(/items/)
      item_to_find = req.path.split("/").last
      val = nil
      @@items.each do |item|
        if item_to_find == item.name
          val = item
        end
      end

      if val == nil
        resp.write "Item not found"
        resp.status = "400"
      else
        resp.write "#{val.price}"
        resp.status = "200"
      end
    else
      resp.status = "404"
      resp.write "Route not found"
    end

    resp.finish
  end

end
