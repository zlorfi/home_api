class WledController < ApplicationController
  include HTTParty
  HOST = 'http://192.168.178.110/json'

  before_action :set_metadata

  def light
    if params.key?(:lights_on) && [true, false].include?(params[:lights_on])
      Rage.logger.debug("BRIGHTNESS #{params[:brightness] || 'not present'}")
      body = { 'on': params[:lights_on], 'bri': params[:brightness] || 187 }
      headers = { 'Content-Type': 'application/json' }
      #response = Fiber.await([Fiber.schedule { HTTParty.post(URI("#{HOST}/state"), body: body.to_json, headers: headers) }])
      response = HTTParty.post(URI("#{HOST}/state"), body: body.to_json, headers: headers)
      render json: { message: response, metadata: @metadata }
    else
      render json: { error: 'Parameter missing or incorect'}, status: 400
    end
  end

  def status
    response = HTTParty.get(URI("#{HOST}/state"))
    render json: { lights_on: response['on'], brightness: response['bri'], metadata: @metadata }
  end
end
