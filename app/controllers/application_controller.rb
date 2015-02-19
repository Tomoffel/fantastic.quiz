class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :check_category_role
  helper_method :check_question_role

  def check_category_role(typ)
    array = Array.new

    typ.all.each do |t|
      if (current_user.has_role?(t.name) || current_user.has_role?(t.name + "_full") || current_user.has_role?(t.name + "_see") || current_user.has_role?(:admin))
        array.push(t)
      end
    end

    return array
  end

  def check_question_role(typ)
    array = Array.new

    typ.all.each do |t|
      if (current_user.has_role?(t.id.to_s) || current_user.has_role?(t.id.to_s + "_full") || current_user.has_role?(t.id.to_s + "_see") || current_user.has_role?(:admin))
        array.push(t)
      end
    end

    return array
  end


end
