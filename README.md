# Todoable

Todoable is a Ruby Gem API wrapper for the todoable API

## Installation

Need ruby on system to operate. [Get Ruby](https://www.ruby-lang.org/en/downloads/). Then:

```bash
gem install bundler
bundle install
```

## Usage

```ruby
require 'todoable'

client = Todoable::Client.new({ 
     username: YOUR_USERNAME,
     password: YOUR_PASSWORD,
})

client.get_lists # gets all lists
client.post_list(new_list) # posts new list
client.get_list(list_id) # gets single list
client.delete_list(list_id) # deletes list
client.patch_list(list_id, {:list => {name: 'new name'}}) #update list name

client.post_item(list_id, {:item => {:name => "Feed the cat" }}) # add item to list
client.delete_item(list_id, item_id) # deletes list item
client.finish_item(list_id, item_id) # changes item status to finish
```

## Testing
1) Requires .env file with VALID_USERNAME & VALID_PASSWORD keys
2) Uses VCR, have to manually clear out cassettes if changes are made.
3) Run tests using `bundle exec rspec spec` in terminal from gem root.


## Todo
1) Inspired by API wrappers I used in rails. Did not get to test configuration at class level but the intention was to be able to configure in initialize. Need to test configuration in framework.
2) Error handling is not complete. Ex. User gets a positive response if they update a list using a name that is already in use. The name would not actually be updated but user would think it was.
3) Token expiration was not tested. Token expires every 20min. Added a checker for this. This should be tested and perhaps implemented differently.
4) Better configure VCR, implement housecleaning in RSPEC config to clean up cassettes. 



## License
[MIT](https://choosealicense.com/licenses/mit/)
