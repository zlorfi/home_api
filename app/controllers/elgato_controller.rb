class ElgatoController < ApplicationController
  include HTTParty
  HOST = 'http://192.168.178.25:9123/elgato'

  before_action :set_metadata

  def light
    if params.key?(:lights_on) && [true, false].include?(params[:lights_on])
      Rage.logger.debug("BRIGHTNESS #{params[:brightness] || 'not present'}")
      body = { 'lights': [{ 'temperature': 175, 'on': params[:lights_on] ? 1 : 0, 'brightness': params[:brightness] || 55 }]}
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.put(URI("#{HOST}/lights"), body: body.to_json, headers: headers)
      #response = Fiber.await([Fiber.schedule { HTTParty.put(URI("#{HOST}/lights"), body: body.to_json, headers: headers) }])
      render json: { message: response, metadata: @metadata }
    else
      render json: { error: 'Parameter missing or incorect'}, status: 400
    end
  end

  def status
    response = HTTParty.get(URI("#{HOST}/lights"))
    render json: { lights_on: response['lights'][0]['on'] == 1 ? true : false, brightness: response['lights'][0]['brightness'], metadata: @metadata }
  end
end
