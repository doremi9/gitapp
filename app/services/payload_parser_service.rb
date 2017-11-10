class PayloadParserService

  def parse(payload)
    {
      organization: {
        name: payload[:organization][:login],
        avatar_url: payload[:organization][:avatar_url],
        description: payload[:organization][:description]
      },
      repository: {
        name: payload[:repository][:full_name]
      },
      pull_request: {
        author: payload[:sender][:login],
        avatar: payload[:sender][:avatar_url],
        pr_id:  payload[:pull_request][:id],
        number: payload[:pull_request][:number],
        state:  payload[:pull_request][:state],
        title:  payload[:pull_request][:title],
        body:   payload[:pull_request][:body]
      }
    }
  end
end