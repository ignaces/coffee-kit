class Api::OperationsController < Api::ApiController

  def status
    render json: { status: 'ok' }
  end

end
