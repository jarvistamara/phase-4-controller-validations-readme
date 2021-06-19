class Bird < ApplicationRecord
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # added rescue_from
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    validates :name, presence: true, uniqeness: true

    def create
        # create! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
        bird = Bird.create!(bird_params)
        render json: bird, status: :created
      end
      
      def update
        bird = find_bird
        # update! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
        bird.update!(bird_params)
        render json: bird
      end 

      private

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_message }, status: :unprocessable_entity
  end

end
