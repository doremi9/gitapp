class WebhookService

  def handle_webhook(params)
    if params[:github][:action] == "opened"
      save_webhook(params)
    end
  end

  private

  def save_webhook(params)
    organization(params[:organization]).repositories.find_or_create_by(
      name: params[:repository][:full_name],
      user_id: 12
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

  def organization(hash)
    Organization.find_or_create_by(
      name: hash[:login],
      avatar_url: hash[:avatar_url],
      description: hash[:description],
      user_id: 12
      ) 
  end

  def gif_url
    Giphy.random('excited').image_url.to_s
  end
end
