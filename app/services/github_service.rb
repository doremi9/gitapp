class GithubService

  def initialize(user, token)
    @user   = user
    @client = Octokit::Client.new(:access_token => token)
  end

  def call
    save_organizations
    save_repositories
    pull_requests
  end

  private

    def save_organizations
      @client.organizations.each { |org| @user.organizations.find_or_create_by(
        name:        org[:login],
        avatar_url:  org[:avatar_url],
        description: org[:description]
        )}
    end

    def save_repositories
      Organization.all.each do |organization| 
        @client.org_repos(organization.name, type: "owner").each do |repo|
          organization.repositories.find_or_create_by(name: repo.full_name,
            user: @user
            )
        end
      end
    end

    def pull_requests
      Repository.all.each do |repository|
        Octokit.pull_requests(repository.name).each do |pull_request|
          repository.pull_requests.find_or_create_by(
            pr_id:  pull_request.id,
            number: pull_request.number,
            state:  pull_request.state,
            title:  pull_request.title,
            body:   pull_request.body
            )
        end
      end
    end

end
