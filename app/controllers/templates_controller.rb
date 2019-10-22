class TemplatesController < ApplicationController
  def new
    @template = Template.new
    @diary_id = session[:diary_id] = params[:diary_id]
  end

  def create
    @template = Template.new(template_params)
    @diary_id = session[:diary_id]
    if @template.save
      redirect_to new_diary_work_path(@diary_id)
      session[:diary_id] = nil
    else
      render 'new'
    end
  end
  
  def get_body
    template = Template.find(params[:template_id])
    @template_body = template.body
    respond_to do |format|
      format.js
    end
  end
  
  private
  
  def template_params
    params.require(:template).permit(:name, :body)
  end
  
end