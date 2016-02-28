require 'pry'

fruit = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]


def consolidate_cart(cart: [])
  cart_hash = {}
  cart.each do |item|
    item.each do |keys, values|
    cart_hash[keys] = {:price => "", :clearance => false, :count => 0}
      values.each do |k,v|
        cart_hash[keys][k] = v
      end
    end
  end 
  cart.each do |item|
    item.each do |key, values|
      cart_hash.each do |item, attrbs|
        if item == key
          cart_hash[item][:count] += 1
        else
          nil
        end
      end
    end
  end
  cart_hash
end


def apply_coupons(cart: [], coupons: [])
  hash = cart
  coupons.each do |coupon|
    if hash.keys.include?(coupon[:item])
      new_item = coupon[:item].to_s + " W/COUPON"
      hash[new_item] = {:price => coupon[:cost].to_i, :clearance => cart[coupon[:item]][:clearance], :count => 0}
    else
      nil
    end
  end
  coupons.each do |coupon|
    if hash.keys.include?(coupon[:item])
      if hash[coupon[:item]][:count] >= coupon[:num]
        new_item = coupon[:item].to_s + " W/COUPON"
        hash[new_item][:count] += 1
        hash[coupon[:item]][:count] -= coupon[:num]
      else
        nil
      end
    else
      nil
    end
  end
  hash
end

fruit2 = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 4},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

coup = [{:item => "AVOCADO", :num => 2, :cost => 5.0}, 
  {:item => "AVOCADO", :num => 2, :cost => 5.0}]

#apply_coupons(fruit2,coup)

def apply_clearance(cart: [])
  cart.each do |item, details|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    else
      nil
    end
  end
  cart
end

fruit3 = 
{
  "PEANUTBUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3},
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
}

def checkout(cart: [], coupons: [])
  new_cart = consolidate_cart(cart: cart)
  apply_coupons(cart: new_cart, coupons: coupons)
  apply_clearance(cart: new_cart)
  total = 0
  new_cart.each do |food,details|
    if new_cart[food][:count] == 0
      total += 0
    else
      new_cart[food][:count].times do
        total += new_cart[food][:price]
      end
    end
  end
  if total > 100.0
    (total *= 0.9).round(2)
  else
    nil
  end
  total
end