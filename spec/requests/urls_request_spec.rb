require 'rails_helper'

RSpec.describe 'UrlController', :type => :request do
  let(:headers) {
    {
      'content-type': 'application/json',
      'accept': 'application/json'
    }
  }
  describe 'POST /url' do
    describe 'valid URL with required params' do
      let(:json_response) { JSON.parse(response.body) }
      subject { post '/urls', params: { long_url: "http://thenewyorktimes.com/" }.to_json, headers: headers }
      it 'is created' do
        expect(Url.count).to eql(0)
        subject
        expect(Url.count).to eql(1)
      end
      it 'returns a 201 CREATED' do
        subject
        expect(response.code.to_i).to eql(201)
      end
      it 'is 8 characters' do
        subject
        expect(json_response["short_path"].length).to eql(8)
      end
      it 'has a short path property' do
        subject
        expect(json_response).to have_key("short_path")
      end
      it 'has a short URL property' do
        subject
        expect(json_response).to have_key("short_url")
      end
    end
    describe 'bad request' do
      describe 'invalid URL' do
        subject { post '/urls', params: { long_url: "to be or not to be that is the question" }.to_json, headers: headers }
        it 'is not created' do
          expect(Url.count).to eql(0)
          subject
          expect(Url.count).to eql(0)
        end
        it 'returns a 400 BAD REQUEST' do
          subject
          expect(response.code.to_i).to eql(400)
        end
        it 'has no body' do
          subject
          expect(response.body).to eql('')
        end
      end
      describe 'missing long_url param' do
        subject { post '/urls', params: {}.to_json, headers: headers }
        it 'is not created' do
          expect(Url.count).to eql(0)
          subject
          expect(Url.count).to eql(0)
        end
        it 'returns a 400 BAD REQUEST' do
          subject
          expect(response.code.to_i).to eql(400)
        end
        it 'has no body' do
          subject
          expect(response.body).to eql('')
        end
      end
    end
  end
end

