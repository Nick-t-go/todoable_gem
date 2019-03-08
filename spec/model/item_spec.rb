 
RSpec.describe Todoable::Model::Item do

	let(:new_item) { {:item => {:name => "Feed the cat" }} }
	let(:new_list) { {:list => {:name => ('a'..'z').to_a.shuffle[0,8].join} }} 
	let(:client) { Todoable::Client.new(username: ENV['VALID_USERNAME'], password: ENV['VALID_PASSWORD']) }

	let(:post_item){ VCR.use_cassette('post_item') do
			list = client.post_list(new_list)
			client.post_item(list[:id], new_item)
		end
	}
	let(:finish_item){ VCR.use_cassette('finish_item') do
			list = client.post_list(new_list)
			item = client.post_item(list[:id], new_item)
			client.finish_item(list[:id], item[:id] )
		end
	}
	let(:delete_item){ VCR.use_cassette('delete_item') do
			list = client.post_list(new_list)
			item = client.post_item(list[:id], new_item)
			client.delete_item(list[:id], item[:id] )
		end
	}

	it 'posts a new item to a list' do
		expect(post_item).to include(:name)
	end

	it 'posts finish status to an list' do
		expect(finish_item).to eq(true)
	end

	it 'deletes an item from a list' do
		expect(delete_item).to eq(true)
	end

	
end