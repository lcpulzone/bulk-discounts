class GithubService
  attr_reader :name,
              :pulls,
              :commits_and_names

  def initialize
    @name ||= repo_name
    @pulls ||= repo_pull_requests
    @commits_and_names ||= repo_commits_and_names
  end

  def repo_name
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop'
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:name]
  end

  def repo_pull_requests
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop/pulls?state=all'
    JSON.parse(response.body, symbolize_names: true).count
  end

  def repo_commits_and_names
    response = Faraday.get 'https://api.github.com/repos/jrwhitmer/little-esty-shop/stats/contributors'
    parsed = JSON.parse(response.body, symbolize_names: true)

    parsed.each_with_object({}) do |login, total|
      total[login[:author][:login]] = login[:total]
    end
  end
end
