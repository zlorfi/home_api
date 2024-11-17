class PiholeController < ApplicationController
  include HTTParty

  before_action :set_metadata

  def disable
    if params.key?(:duration) && (params[:duration]).is_a?(Integer)
      query = { disable: params[:duration], auth: ENV['PIHOLE_SECRET']}
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.get(URI("#{ENV['PIHOLE_HOST']}/api.php"), query: query, headers: headers, verify: false)
      #response = Fiber.await([Fiber.schedule { HTTParty.put(URI("#{PIHOLE_HOST}/lights"), body: body.to_json, headers: headers) }])
      render json: { message: JSON.parse(response.body), metadata: @metadata }
    else
      render json: { error: 'Parameter missing or incorect'}, status: 400
    end
  end
end
