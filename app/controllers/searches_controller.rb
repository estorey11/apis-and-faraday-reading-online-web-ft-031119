class SearchesController < ApplicationController
  def search
  end

  def foursquare
     @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'SNU4MTNPBTCLYGGWHFJZ3I2FDRY3TDG5HRFVQUANPZWRG1R0'
      req.params['client_secret'] = '1R1JCGHWPW0DGR2F3MGJ1P002CKXGJB2YOHN0GRJGXGYJXJS'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    
    body = JSON.parse(@resp.body)
    
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    
    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end
    
    render 'search'
  end
end
