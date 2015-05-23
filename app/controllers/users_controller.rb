class UsersController < ApplicationController

	before_action :set_user

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			set_session_user @user.id
			redirect_to user_path(@user.id)
		else
			flash[:warning] = "Couldn't create a user"
			render :new
		end
	end

	def show
		@question_data = parse_questions @user.questions
	end

	def edit
	end

	def update
		@user.update_attributes(user_params)
		if @user.save
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	def search_user_questions
		result = parse_questions @user.questions_by(params[:search_by],params[:description)
		result.to_json
	end

	private

	def set_user
		@user = User.find_by(id: params[:id])
	end

	def user_params
		params.require(:user).permit(:username,:email,:password)
	end

	def parse_questions (questions)
		questions.map do |question|
			Hash[title: question.title,
				answers: question.answers.count, 
				comments: question.comments.count, 
				votes: question.votes.count,
				karma: question.karma]
		end
	end

end