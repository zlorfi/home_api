class WledController < ApplicationController
  include HTTParty

  before_action :set_metadata

  def light
    if params.key?(:lights_on) && [true, false].include?(params[:lights_on])
      body = { 'on': params[:lights_on], 'bri': params[:brightness] || 187 }
      headers = { 'Content-Type': 'application/json' }
      #response = Fiber.await([Fiber.schedule { HTTParty.post(URI("#{WLED_HOST}/state"), body: body.to_json, headers: headers) }])
      response = HTTParty.post(URI("#{ENV['WLED_HOST']}/state"), body: body.to_json, headers: headers)
      render json: { message: JSON.parse(response.body), metadata: @metadata }
    else
      render json: { error: 'Parameter missing or incorect'}, status: 400
    end
  end

  def toggle
    request = HTTParty.get(URI("#{ENV['WLED_HOST']}/state"))
    if request.code == 200
      light_status = request['on'] ? true : false
      body = { 'on': !light_status, 'bri': params[:brightness] || 187 }
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.post(URI("#{ENV['WLED_HOST']}/state"), body: body.to_json, headers: headers)
      render json: { message: JSON.parse(response.body), metadata: @metadata }
    else
      render json: { error: 'Can not request toggle state'}, status: 400
    end
  end

  def status
    response = HTTParty.get(URI("#{ENV['WLED_HOST']}/state"))
    render json: { lights_on: response['on'], brightness: response['bri'], metadata: @metadata }
  end
end
