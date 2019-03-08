require 'todoable/error'

RSpec.describe Todoable::Error::ResponseValidator do
	it 'throws an error for unauthorized users' do
		response = double(code: 401)
		expect {described_class.validate(response)}.to raise_error(Todoable::Error::Unauthorized)
	end

end