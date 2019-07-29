def items
	[
		{"AVOCADO" => {:price => 3.00, :clearance => true}},
		{"KALE" => {:price => 3.00, :clearance => false}},
		{"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
		{"ALMONDS" => {:price => 9.00, :clearance => false}},
		{"TEMPEH" => {:price => 3.00, :clearance => true}},
		{"CHEESE" => {:price => 6.50, :clearance => false}},
		{"BEER" => {:price => 13.00, :clearance => false}},
		{"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
		{"BEETS" => {:price => 2.50, :clearance => false}}
	]
end

def coupons
	[
		{:item => "AVOCADO", :num => 2, :cost => 5.00},
		{:item => "BEER", :num => 2, :cost => 20.00},
		{:item => "CHEESE", :num => 3, :cost => 15.00}
	]
end

def consolidate_cart(cart)
  # code here
  cart.uniq.each_with_object({}) do |item, hash|
    item.each do |name, details|
      hash[name] = details
      details[:count] = cart.count(item)
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    name = coupon[:item]
    count = coupon[:num]
    if cart.has_key?(name) and count <= cart[name][:count]
      new_name = name + " W/COUPON"
      if cart.has_key?(new_name)
        cart[new_name][:count] += 1
      else
        cart[new_name] = cart[name].clone
        cart[new_name][:count] = 1
        cart[new_name][:price] = coupon[:cost]
      end
        cart[name][:count] -= count
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, details|
    details[:price] = (details[:price] * 0.8).round(2) if details[:clearance] == true
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = cart.values.reduce(0) {|sum, item| sum + (item[:price]*item[:count]).round(2)}
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
