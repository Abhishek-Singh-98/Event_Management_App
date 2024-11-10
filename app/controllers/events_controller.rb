class EventsController < ApplicationController
  before_action :find_event_manager, only: [:create]
  before_action :find_events, :check_availability, :find_user_for_rsvp, only: [:rsvp_events, :update_rsvp]
  before_action :check_akready_rsvp_present, only: [:rsvp_events]

  def create
    @event = Event.new(event_params)
    @event.user = @manager
    if @event.save
      render json: @event
    else
      render json: @event.errors.messages, status: 422
    end
  end

  # def cancel_event
    
  # end

  def rsvp_events
    return render json: {error: 'Status is missing.'}, status: 422 unless params[:status].present?
    rsvp = Rsvp.new(user: @user, event: @event, rsvp_date: DateTime.now,
                    status: params[:status])
    if rsvp.save
      render json: {rsvp: "Your rsvp is created for #{@event.title}"}
    else
      render json: {rsvp: "Something wrong happened"}, status: 422
    end
  end

  def update_rsvp
    rsvp = Rsvp.find(params[:rsvp_id])
    return render json: {rsvp: "No RSVP present like this"}, status: 403 unless rsvp.present?
    return render json: {rsvp: "This RSVP doesn't belongs to you."}, status: 401 if @user != rsvp.user
    begin
    rsvp.update(status: params[:status])
    render json: {rsvp: "Your RSVP's staus changed to #{params[:status]}"}
    rescue => e
      render json: {rsvp: e.messages}
    end
  end

  private

  def find_events
    @event = Event.find(params[:event_id])
    unless @event.present?
      render json: {event: "Invalid Event for rsvping."}, status: 422
    end
    @event
  end

  def find_user_for_rsvp
    @user = User.find(params[:user_id])
    # user_rsvp = @user&.rsvps&.where(event_id: params[:event_id]) if @user.present?
    if !@user.present? || (@user.event_manager? && @event.user_id == @user.id )
      render json: 'Something wrong happened or Invalid User error.', status: 422
    end
    @user
  end

  def check_already_rsvp_present
    user_rsvp = @user.rsvps&.where(event_id: params[:event_id])
    if user_rsvp.present?
      render json: {error: 'Already you rsvp is present.'}
    end
  end

  def check_availability
    if @event.max_capacity < 1
      render json: {error: "Capacity full!! See You at Next Events."}
    end
  end
  
  def find_event_manager
    @manager = User.find(params[:user_id])
    unless @manager.event_manager?
      render json: {error: 'Not authorized to create Events.'}, status: 401
    end
    @manager
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :start_time , :end_time,
          :max_capacity, category_ids: [])
  end
end
