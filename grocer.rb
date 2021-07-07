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
end

def apply_clearance(cart)
  discounted_cart = {}
  cart.each do |food, info|
    if info[:clearance] == true
      info[:price] = (0.8 * info[:price]).round(2)
      discounted_cart[food] = info
    else
      discounted_cart[food] = info
    end
  end
end

def checkout(cart, coupons) # cart == hash inside an array; coupons == []
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  discounts_cart = apply_clearance(coupons_cart) # which is everything in the trolley with the coupons and discounts applied
  cart_total = []
  discounts_cart.each do |item, details|
    cart_total << details[:price] * details[:count]
  end
  total = cart_total.reduce(0, :+)
  if total > 100
    total *= 0.9
  else
    total
  end
end
  
# binding.pry