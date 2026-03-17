module Api
  class MapsController < ApplicationController
    # GET /api/map?session_id=:token
    def show
      nodes = nodes_for_session || MapGenerator.call

      render json: { nodes: nodes }
    end

    private

    def nodes_for_session
      token = params[:session_id]
      return nil if token.blank?

      session = GameSession.find_by(session_token: token)
      return nil unless session
      return nil if session.finished? || session.expires_at < Time.current

      session.map_nodes
    end
  end
end
