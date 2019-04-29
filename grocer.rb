require "pry"

def consolidate_cart(cart)
  sorted_hash = {} #use an empty hash for this, not an empty array!
  cart.each do |item_hash|
  	item_hash.each do |food_name, info_hash|
  		if sorted_hash[food_name] #exists
  			sorted_hash[food_name][:count] += 1 #adds 1 to count value, if the food_name already exists in sorted_hash
  		else
  			sorted_hash[food_name] = info_hash #if the name doesnt exist in sorted_hash, make it so
  			sorted_hash[food_name][:count] = 1 #then add the count key, with value 1
  		end
  	end
  end
  sorted_hash
end

def apply_coupons(cart, coupons)

# 	cart = {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
# 	}
	
# 	coupon = {:item => "AVOCADO", :num => 2, :cost => 5.0}

	new_hash = {}
	cart.each do |food_name, att_hash|
		coupons.each do |coupon_hash|
			if food_name == coupon_hash[:item] && att_hash[:count] >= coupon_hash[:num]
			# if food name in cart == coupon[:item] AND count of cart food is greater or 
			# equal to the number of coupons
				att_hash[:count] = att_hash[:count] - coupon_hash[:num]
				# cart food count minus coupon count
				if new_hash["#{food_name} W/COUPON"]
					new_hash["#{food_name} W/COUPON"][:count] += 1
				# if food name w/coupon exists in new_hash, add 1 to the counter 

				else
					new_hash["#{food_name} W/COUPON"] = {:price => coupon_hash[:cost],:clearance => att_hash[:clearance], :count => 1}
					# creates new food_name w/coupon to show bundled price in basket, price = coupon cost, clearance = true, count = 1
				end
			end

		end
		new_hash[food_name] = att_hash
		# add the attributes cart hash to the food_name hash in new_hash for each food_name
		# updates the existing food_name 's  with the updated attributes
	end
	new_hash
end

def apply_clearance(cart)
 # discount 20% every item with clearance == true

 new_hash = {}
 cart.each do |food_name, att_hash|
 	new_hash[food_name] = {}
 	# creates empty hash for each food_name in new_hash
 	if att_hash[:clearance] == true	
 		new_hash[food_name][:price] = att_hash[:price] * 4 / 5
 	else
 		new_hash[food_name][:price] = att_hash[:price]
 	end
 	new_hash[food_name][:clearance] = att_hash[:clearance]
 	new_hash[food_name][:count] = att_hash[:count]
 end
new_hash
# returns a new cart, all items the same except clearence == true subtracted 20%

end

def checkout(cart, coupons)

	consolidated_cart = consolidate_cart(cart) #colsolidate_cart method called
	applied_coupons = apply_coupons(consolidated_cart, coupons) #apply_method method called
	applied_clearance = apply_clearance(applied_coupons) #apply_clearance method called
  	clearance_total = 0
  	applied_clearance.each do |item, item_hash|
    	clearance_total += (item_hash[:count] * item_hash[:price])
  	end
  	# adds the value of all clearance items to the total

  	if clearance_total > 100
    	clearance_total = clearance_total * 9 / 10
  	end

  	clearance_total

#   When checking out, follow these steps in order:

# Apply coupon discounts if the proper number of items are present.
# Apply 20% discount if items are on clearance.
# If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.


end


