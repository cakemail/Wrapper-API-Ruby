require 'cakeapi'

cakeapi = CakeAPI.new('YourApiKey')

params = {
  'email' => 'email@address.com', 
  'password' => 'password'
}

# In methods like /List/subscribeEmail you may want to parse a Hash inside a Hash, for the data param. Here's an example of how to do so
# params = {
#   'user_key' => 'THEUSERKEY',
#   'list_id' => 'THELISTID',
#   'client_id' => 'THECLIENTID',
#   'email' => 'someones@email.com',
#   'data' => {
#     'First Name' => 'Your',
#     'Last Name' => 'Name'
#   }
# }

result = cakeapi.call('User/login/', params)

p result