class ElgatoController < ApplicationController
  include HTTParty
  HOST = 'http://192.168.178.25:9123/elgato'

  before_action :set_metadata

  def light
    if params.key?(:lights_on) && [true, false].include?(params[:lights_on])
      body = { 'lights': [{ 'temperature': 175, 'on': params[:lights_on] ? 1 : 0, 'brightness': 55 }]}
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.put(URI("#{HOST}/lights"), body: body.to_json, headers: headers)
      #response = Fiber.await([Fiber.schedule { HTTParty.put(URI("#{HOST}/lights"), body: body.to_json, headers: headers) }])
      render json: { page: response, metadata: @metadata }
    else
      render json: { message: 'Parameter missing or incorect'}, status: 400
    end
  end

  def status
    response = HTTParty.get(URI("#{HOST}/lights"))
    render json: { lights_on: response['lights'][0]['on'] == 1 ? true : false, metadata: @metadata }
  end
end
