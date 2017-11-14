class WebhookService
  UserNotFound = Class.new(StandardError)

  def call(params)
    if params[:github][:action] == "opened"
      user = User.find_by(gh_webhook_token: params[:gh_webhook_token])
      raise UserNotFound if user.blank?
      save_webhook(user, params)
    end
  end

  private

  def save_webhook(user, params)
    user.organizations.find_or_create_by(
      name: params[:organization][:login],
      avatar_url: params[:organization][:avatar_url],
      description: params[:organization][:description]
      )
      .repositories.find_or_create_by(
        name: params[:repository][:full_name],
      ).pull_requests.find_or_create_by(
        pr_id: params[:pull_request][:id],
        number: params[:pull_request][:number],
        state: params[:pull_request][:state],
        title: params[:pull_request][:title],
        body: params[:pull_request][:body],
        author: params[:sender][:login],
        author_avatar_url: params[:sender][:avatar_url]
      ).comments.create(
        text: "Hey, everything is OK!", gif_url: gif_url
      )
  end

  def gif_url
    Giphy.random('excited').image_url.to_s
  end
end
