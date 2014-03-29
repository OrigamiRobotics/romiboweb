class AttachmentsController < ApplicationController
  respond_to :js, :html

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = Attachment.new(attachment_params)
    if @attachment.save
      flash[:success] = 'Upload was successful'
    end
  end


  private
  def attachment_params
    params.require(:attachment).permit(:name)
  end
end
