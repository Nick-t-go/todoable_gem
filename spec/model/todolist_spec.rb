require 'dotenv/load'

RSpec.describe Todoable::Model::TodoList do

	let(:new_list) { {:list => {:name => ('a'..'z').to_a.shuffle[0,8].join} }} 

	let(:client) { Todoable::Client.new(username: ENV['VALID_USERNAME'], password: ENV['VALID_PASSWORD']) }
	let(:get_lists) {
		VCR.use_cassette('get_lists') do
			client.get_lists
		end
	}
	let(:post_list){ VCR.use_cassette('post_list') do
			client.post_list(new_list)
		end
	}
	let(:post_wrong_list){ VCR.use_cassette('wrong_list') do
			new_list[:list][:items] = [{:name => 'Get er done'}]
			client.post_list(new_list)
		end
	}
	let(:post_non_unique){ VCR.use_cassette('wrong_list') do
			client.post_list(new_list)
			client.post_list(new_list)
		end
	}
	let(:get_single_list){ VCR.use_cassette('get_list') do
			list = client.post_list(new_list)
			client.get_list(list[:id])
		end
	}
	let(:delete_list){ VCR.use_cassette('delete_list') do
		list = client.post_list(new_list)
		client.delete_list(list[:id])
	end
	}
	let(:new_name){ ('a'..'z').to_a.shuffle[0,8].join }
	let(:patch_list){ VCR.use_cassette('patch_list', :re_record_interval => 1.second) do
		list = client.post_list(new_list)
		new_list[:list][:name] = new_name
		client.patch_list(list[:id], new_list)
		client.get_list(list[:id])
	end
	}

	it 'returns an array of lists' do
		expect(get_lists).to have_key(:lists)
	end	
	it 'posts a new list if name is unique' do
		expect(post_list).to include(:name, :src, :id)
	end
	it 'throws service error if post has a new list with item' do
		expect{post_wrong_list}.to raise_error(Todoable::Error::ServiceError)
	end
	it 'throws error if list name is non-unique' do
		expect{post_non_unique}.to raise_error(Todoable::Error::ServiceError)
	end
	it 'fetches one list by id' do
		expect(get_single_list).to include(:items, :name)
	end
	it 'deletes a list' do
		expect(delete_list).to eq(true)
	end
	it 'updates a list' do
		expect(patch_list[:name]).to eq(new_name) 
	end


end