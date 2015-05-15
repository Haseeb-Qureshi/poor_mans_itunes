class NotesController < ApplicationController
  def create
    @note = Note.new(
      note: note_params[:note],
      user_id: current_user.id,
      track_id: params[:track_id]
    )
    flash[:notice] = "Note successfully created" if @note.save
    redirect_to track_url(params[:track_id])
  end

  def destroy
    @note = Note.find(params[:id])
    if current_user != @note.user && !current_user.admin?
      render text: "Not authorized", status: 403
    else
      @note.destroy
      redirect_to track_url(@note.track)
    end
  end

  private

  def note_params
    params.require(:note).permit(:note)
  end
end
