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
  new_cart = {} # empty cart I'll push data to
  cart.each do |item, info| # iterate over cart
    if coupons[0][:item] == item && coupons[0][:num] <= info[:count] # is there a coupon and do we have enough items to qualify?
      info[:count] -= coupons[0][:num] # if so, remove the amount of items covered by the coupon from the cart

    # else
    end
    if info[:count] > 0 
      new_cart = new_cart[item] = info
      # new_cart = {"banana" => {:count => 2}}
    end
    # still iteration one "AVOCADO"
  end
  binding.pry
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