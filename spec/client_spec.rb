require 'todoable'

RSpec.describe Todoable::Client do
	context 'using valid keys' do
		describe "authenticating and configuring client" do
			subject {
		      VCR.use_cassette('auth') do
		        Todoable::Client.new(username: ENV['VALID_USERNAME'], password: ENV['VALID_PASSWORD'])
		      end
		    }

			it 'has configuration' do
				expect(subject.configuration).to have_attributes(username: ENV['VALID_USERNAME'], password: ENV['VALID_PASSWORD'])
			end
			it 'can detect valid configuration options' do
				expect(subject.configuration.valid?).to be_truthy
			end
			it 'has model methods' do
				expect(subject).to respond_to(:get_lists)
				expect(subject).to respond_to(:get_list)
			end

		end
	end
	context 'using invalid values' do
		subject {
			VCR.use_cassette('unauthorized') do
				Todoable::Client.new(username: 'Bob', password: 'Dole')
			end
		}
		it 'should raise an error when configuration is invalid' do
		    expect { Todoable::Client.new(username: nil, password: nil) }
		    .to raise_error(Todoable::Error::MissingCredentials)
		end
		it 'should raise an error when credentials are not authorized' do
		    expect { subject }
		    .to raise_error(Todoable::Error::Unauthorized)
		end
	end
end

