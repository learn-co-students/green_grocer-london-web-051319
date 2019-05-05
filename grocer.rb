require "pry"

def consolidate_cart(cart)
  obj = cart.each_with_object({}) do |item, object|
    item.each do |food, info|
      if object[food]
        info[:count] += 1
      else 
        object[food] = info
        info[:count] = 1
      end
    end
  end
  obj
end

def apply_coupons(cart, coupons)
  new_cart = {}
  coupon_items = {}
  if coupons == []
    return cart
  end
  cart.each do |item, info| 
    coupons.each do |object| 

      if object[:item] != item || object[:item] == item && object[:num] > info[:count]
        new_cart[item] = info # this is a short version of the destructive add for hashes inside an iterative loop.
      elsif object[:item] == item && object[:num] <= info[:count]
        if coupon_items.include?("#{item} W/COUPON")
          coupon_items["#{item} W/COUPON"][:count] += 1
        else
          coupon_items["#{item} W/COUPON"] = {:price => object[:cost], :clearance => info[:clearance], :count => 1} # this is a full version of the destructive add
        end
        info[:count] -= object[:num]
        new_cart[item] = info
      end
    end
  end 
  new_cart.merge!(coupon_items) # use this to add key value pairs outside of an iteration
  # binding.pry
end



def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end