class ElgatoController < ApplicationController
  include HTTParty

  before_action :set_metadata

  def light
    if params.key?(:lights_on) && [true, false].include?(params[:lights_on])
      body = { 'lights': [{ 'temperature': 175, 'on': params[:lights_on] ? 1 : 0, 'brightness': params[:brightness] || 55 }]}
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.put(URI("#{ENV['ELGATO_HOST']}/lights"), body: body.to_json, headers: headers)
      #response = Fiber.await([Fiber.schedule { HTTParty.put(URI("#{ELGATO_HOST}/lights"), body: body.to_json, headers: headers) }])
      render json: { message: JSON.parse(response.body), metadata: @metadata }
    else
      render json: { error: 'Parameter missing or incorect'}, status: 400
    end
  end

  def toggle
    request = HTTParty.get(URI("#{ENV['ELGATO_HOST']}/lights"))
    if request.code == 200
      light_status = request['lights'][0]['on'] == 1 ? true : false
      body = { 'lights': [{ 'temperature': 175, 'on': light_status ? 0 : 1, 'brightness': params[:brightness] || 55 }]}
      headers = { 'Content-Type': 'application/json' }
      response = HTTParty.put(URI("#{ENV['ELGATO_HOST']}/lights"), body: body.to_json, headers: headers)
      render json: { message: JSON.parse(response.body), metadata: @metadata }
    else
      render json: { error: 'Can not request toggle state'}, status: 400
    end
  end

  def status
    response = HTTParty.get(URI("#{ENV['ELGATO_HOST']}/lights"))
    render json: { lights_on: response['lights'][0]['on'] == 1 ? true : false, brightness: response['lights'][0]['brightness'], metadata: @metadata }
  end
end
