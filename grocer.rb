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
  cart.each do |item, info|
    if coupons[0][:item] == item && coupons[0][:num] <= info[:count]
      info[:count] -= coupons[0][:num]
      binding.pry
      if info[:count] > 0 

      end
    else
      new_cart = new_cart[item] = info
    end
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end


# Cart == {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
# Coupons == [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]

# new_cart = {}
# cart.each do |food, info|
#   coupons.each do |details| # details == {:item => "AVOCADO", :num => 2, :cost => 5.00}
#     coupons[details].each do |k, v|
#     if coupons[:item] == food && info[:count] > coupons[:num]
#   # first removes the coupon num of items from cart
#   # info[:count] -= coupons[:num]
#   # second creates a new line for the coupon groups
#   # new_cart[food] = info
#     end
#   end
# end
# end
# obj