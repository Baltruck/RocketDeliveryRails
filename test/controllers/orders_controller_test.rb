class OrdersControllerTest < ActionDispatch::IntegrationTest  

  def setup
    user = User.create!(name: "User 1", email: "test@test.com", password: "password")
    address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
    restaurant = Restaurant.create!(user: user, address: address, name: "Restaurant 1", phone: "123456", price_range: 2)
    customer = Customer.create!(user: user, address: address, phone: "123456")
    product = Product.create!(name: "Product 1", cost: 10, restaurant: restaurant)
    order_status = OrderStatus.create(name: "pending")
    OrderStatus.create(name: "in progress")
    OrderStatus.create(name: "delivered")
    @order = Order.create!(restaurant: restaurant, customer: customer, order_status: order_status, restaurant_rating: 4)
  end

### NEW TESTS GET ###

  # Test if the route exists and is a GET route
  test "orders route exists and is a GET route" do
    assert_routing({ path: '/api/orders', method: :get }, { controller: 'api/orders', action: 'index' })
  end

 # Test with valid 'type' and 'id' parameters
test "get orders with valid type and id parameters" do
  user = User.create!(name: "User 1", email: "test1@test.com", password: "password")
  address = Address.create!(street_address: "Street 1", city: "City 1", postal_code: "11111")
  customer = Customer.create!(user: user, address: address, phone: "123456")
  get "/api/orders", params: { type: 'customer', id: customer.id }
  assert_response :success
  assert_not_nil @controller.instance_variable_get(:@orders)
end

  # Test with invalid 'type' parameter
  test "get orders with invalid type parameter" do
    get "/api/orders", params: { type: 'invalid', id: 1 }
    assert_response 422
    assert_equal({ error: "Invalid user type" }.to_json, response.body)
  end

  # Test with valid 'type' but 'id' not found
  test "get orders with valid type and id not found" do
    get "/api/orders", params: { type: 'customer', id: 999 }
    assert_response :success
    assert_equal [].to_json, response.body
  end

  # Test without 'type' and 'id' parameters
  test "get orders without type and id parameters" do
    get "/api/orders"
    assert_response 400
    assert_equal({ error: "Both 'user type' and 'id' parameters are required" }.to_json, response.body)
  end

  # Test order status update route pending
  test "update order status to 'pending'" do
    post "/api/order/#{@order.id}/status", params: { status: "pending" }
    assert_response :success
    assert_equal "pending", @order.reload.order_status.name
  end

### NEW TESTS POST ###

# Test creating a new order
test "create a new order" do
  user2 = User.create!(name: "User 2", email: "test2@test.com", password: "password")
  address2 = Address.create!(street_address: "Street 2", city: "City 2", postal_code: "22222")
  restaurant2 = Restaurant.create!(user: user2, address: address2, name: "Restaurant 2", phone: "234567", price_range: 3)
  customer2 = Customer.create!(user: user2, address: address2, phone: "234567")
  product1 = Product.create!(name: "Product 1", cost: 10, restaurant: restaurant2)
  product2 = Product.create!(name: "Product 2", cost: 5, restaurant: restaurant2)

  post "/api/orders", params: {
    restaurant_id: restaurant2.id,
    customer_id: customer2.id,
    products: [
      { id: product1.id, quantity: 1, cost: 10 },
      { id: product2.id, quantity: 2, cost: 10 }
    ]
  }

  assert_response :success
  assert_not_nil @controller.instance_variable_get(:@order)
end

# Test creating an order with missing data
test "create an order with missing data" do
  post "/api/orders"
  assert_response 400
  assert_equal({ error: "Restaurant ID, customer ID, and products are required" }.to_json, response.body)
end

# Test creating an order with invalid restaurant or customer ID
test "create an order with invalid restaurant or customer ID" do
  post "/api/orders", params: {
    restaurant_id: 999,
    customer_id: 999,
    products: []
  }
  assert_response 422
  assert_equal({ error: "Invalid restaurant or customer ID" }.to_json, response.body)
end

# Test creating an order with invalid product ID
test "create an order with invalid product ID" do
  user3 = User.create!(name: "User 3", email: "test3@test.com", password: "password")
  address3 = Address.create!(street_address: "Street 3", city: "City 3", postal_code: "33333")
  restaurant3 = Restaurant.create!(user: user3, address: address3, name: "Restaurant 3", phone: "345678", price_range: 3)
  customer3 = Customer.create!(user: user3, address: address3, phone: "345678")

  post "/api/orders", params: {
    restaurant_id: restaurant3.id,
    customer_id: customer3.id,
    products: [
      { id: 999, quantity: 1 }
    ]
  }
  assert_response 422
  assert_equal({ error: "Invalid product ID" }.to_json, response.body)
end

### OLD TESTS ###
  
  test "update order status to 'in progress'" do
    post "/api/order/#{@order.id}/status", params: { status: "in progress" }
    assert_response :success
    assert_equal "in progress", @order.reload.order_status.name
  end

  test "update order status to 'delivered'" do
    post "/api/order/#{@order.id}/status", params: { status: "delivered" }
    assert_response :success
    assert_equal "delivered", @order.reload.order_status.name
  end

  test "return 422 error for invalid status" do
    post "/api/order/#{@order.id}/status", params: { status: "invalid" }
    assert_response 422
  end

  test "return 422 error for invalid order" do
    post "/api/order/0/status", params: { status: "pending" }
    assert_response 422
  end

end