class Unauthorized < Devise::FailureApp
  def route(scope)
    :root_url
  end
end