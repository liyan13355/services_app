class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @filterrific = initialize_filterrific(
      User,
      params[:filterrific],
      :select_options => {
        sorted_by: User.options_for_sorted_by,
        with_country_id: Country.options_for_select
      },
    ) or return

    @users = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
    

  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_to home_path, notice: 'Thanks for signing up!'


    else 
      render template: 'users/new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    

    def user_from_params
      name = user_params.delete(:name)
      service = user_params.delete(:service)
      email = user_params.delete(:email)
      country = user_params.delete(:country)
      price = user_params.delete(:price)
      password = user_params.delete(:password)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.name = name
        user.password = password
        user.service = service
        user.email = email
        user.country = country
        user.price = price
      end
    end

    def user_params
      params[Clearance.configuration.user_parameter] || Hash.new
    end
end
