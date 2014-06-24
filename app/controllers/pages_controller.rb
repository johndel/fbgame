class PagesController < ApplicationController
  def index
    scored_users
    game_logic
  end

  def check_name
    if session[:name] == params["myradio"]
      flash.now[:notice] = "Correct Answer! +1 points!"
      current_user.score = current_user.score + 1
    else
      flash.now[:error] = "Wrong Answer. -1 points! The correct answer was: #{session[:name]}"
      current_user.score = current_user.score - 1
    end
    session[:name] = nil
    current_user.save
    scored_users
    game_logic
  end

  private
    def scored_users
      @users = User.order("score DESC").limit(20)
    end

    def game_logic
      if current_user
        @graph = Koala::Facebook::API.new(current_user.oauth_token)
        begin
          @profile = @graph.get_object("me")
          @friends = @graph.get_connections("me", "friends?fields=id,name,gender")
          @selected_friend = @friends.shuffle.pop
          binding.pry
          session[:name] = @selected_friend["name"]
          @names = [@selected_friend["name"]]
          while @names.count < 5
            tmp_friend = @friends.shuffle.pop
            if tmp_friend["id"] != @selected_friend["id"] && tmp_friend["gender"] == @selected_friend["gender"]
              @names << tmp_friend["name"]
            end
          end
        rescue
          redirect_to signout_path
        end
      end
    end
end

# SELECT pid FROM photo WHERE aid IN (SELECT aid,name FROM album WHERE owner=me() AND name="Profile Pictures")
