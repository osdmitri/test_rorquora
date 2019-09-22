class AnswersController < ApplicationController
  def edit
    redirect_to :new_user_session && return unless user_signed_in?

    @answer = Answer.find(params[:id])

    if @answer.nil? || @answer.user != current_user
      flash[:alert] = "You don't have rights to edit this answer"
      redirect_to root_path
    end
  end

  def create
    redirect_to :new_user_session && return unless user_signed_in?

    @answer = current_user.answers.create(answer_params)
    @answer.save
    redirect_to @answer.question
  end

  def update
    redirect_to :new_user_session && return unless user_signed_in?

    @answer = Answer.find(params[:id])

    if @answer.nil? || @answer.user != current_user
      flash[:alert] = "You don't have rights to update this answer"
      redirect_to root_path
      return
    end

    if @answer.update(answer_params)
      redirect_to @answer.question
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to :new_user_session && return unless user_signed_in?

    @answer = Answer.find(params[:id])
    redirect_to root_path && return if @answer.nil?
    @question = @answer.question
    @answer.destroy if @answer.user == current_user
    redirect_to @question
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :question_id)
  end
end
