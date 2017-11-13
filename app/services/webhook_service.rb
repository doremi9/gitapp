class WebhookService

  def handle_webhook(payload)
    if payload[:github][:action] == "opened"
      save_webhook(payload)
    end
  end

  private

  def save_webhook(payload)
    organization(payload[:organization]).repositories.find_or_create_by(
      name: payload[:repository][:name]
      ).pull_requests.find_or_create_by(
        pr_id: payload[:pull_request][:pr_id],
        state: payload[:pull_request][:state],
        number: payload[:pull_request][:number],
        title: payload[:pull_request][:title],
        body: payload[:pull_request][:body],
        author: payload[:pull_request][:author],
        author_avatar_url: payload[:pull_request][:avatar]
      ).comments.create(
        text: "Hey, everything is OK!", gif_url: gif_url
        )
  end

  def organization(hash)
    Organization.find_by(name: hash[:name]) || create_organization(hash[:name])
  end

  def create_organization(hash)
    Organization.create(
      name: hash[:name],
      avatar_url: hash[:avatar_url],
      description: hash[:description]
    )
  end

  def gif_url
    Giphy.random('excited').image_url.to_s
  end
end
