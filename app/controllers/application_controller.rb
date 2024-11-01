class ApplicationController < RageController::API
  rescue_from SocketError do |_|
    render json: { message: "error" }, status: 500
  end

  rescue_from Errno::ENETUNREACH do |_|
    render json: { message: 'Host unreachable' }, status: 503
  end

  def set_metadata
    @metadata = { format: "json", time: Time.now.to_i }
  end
end
