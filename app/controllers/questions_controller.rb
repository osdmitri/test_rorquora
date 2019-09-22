class QuestionsController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc).all
  end

  def show
    begin
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Question not found"
      redirect_to root_path
    else
      @answers = @question.answers.order(created_at: :asc).all
      @answer = Answer.new
      @followed = user_signed_in? ? current_user.followed_questions.where(question: @question).exists? : false
      @followed_author = user_signed_in? ? current_user.followed_users.where(to: @question.user).exists? : false
    end
  end

  def new
    redirect_to :new_user_session unless user_signed_in?

    @question = Question.new
  end

  def edit
    redirect_to :new_user_session && return unless user_signed_in?

    begin
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Question not found"
      redirect_to root_path
    else
      if @question.nil? || @question.user != current_user
        flash[:alert] = "You don't have rights to edit this question"
        redirect_to root_path
      end
    end
  end

  def create
    redirect_to :new_user_session && return unless user_signed_in?

    @question = current_user.questions.create(question_params)

    if @question.save
      follow_question(@question)
      redirect_to @question
    else
      render 'new'
    end
  end

  def update
    redirect_to :new_user_session && return unless user_signed_in?

    begin
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Question not found"
      redirect_to root_path
    else
      if @question.user != current_user
        flash[:alert] = "You don't have rights to update this question"
        redirect_to root_path
        return
      end

      if @question.update(question_params)
        redirect_to @question
      else
        render 'edit'
      end
    end
  end

  def destroy
    redirect_to :new_user_session && return unless user_signed_in?

    @question = Question.find(params[:id])
    redirect_to root_path && return if @question.nil?
    @question.destroy if @question.user == current_user
    redirect_to root_path
  end

  def follow
    redirect_to :new_user_session && return unless user_signed_in?

    @question = Question.find(params[:question_id])
    redirect_to root_path and return if @question.nil?
    follow_question(@question)
    redirect_to @question
  end

  def followed
    redirect_to :new_user_session && return unless user_signed_in?

    @questions = Question.joins(:followed_questions).where(followed_questions: { user: current_user })
    render 'index'
  end

  def unfollow
    redirect_to :new_user_session && return unless user_signed_in?

    begin
      @question = Question.find(params[:question_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    else
      current_user.followed_questions.where(question: @question).delete_all
      redirect_to @question
    end
  end

  def your
    redirect_to :new_user_session && return unless user_signed_in?

    @questions = Question.where(user: current_user).order(created_at: :desc)
    render 'index'
  end

  private

  def follow_question(question)
    current_user.followed_questions.where(question: question).first_or_create unless question.nil? && user_signed_in?
  end

  def question_params
    params.require(:question).permit(:title, :text)
  end
end
