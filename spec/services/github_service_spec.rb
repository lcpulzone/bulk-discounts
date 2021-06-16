require 'rails_helper'

RSpec.describe GithubService, type: :model do
  it "can return the users name" do
    @github_service = GithubService.new
    mock_response = {
      :id=>372941023,
      :node_id=>"MDEwOlJlcG9zaXRvcnkzNzI5NDEwMjM=",
      :name=>"little-esty-shop",
      :full_name=>"jrwhitmer/little-esty-shop",
      :private=>false,
      :owner=>{
        :login=>"jrwhitmer",
        :id=>78382113,
        :node_id=>"MDQ6VXNlcjc4MzgyMTEz",
        :avatar_url=>"https://avatars.githubusercontent.com/u/78382113?v=4",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/jrwhitmer",
        :html_url=>"https://github.com/jrwhitmer",
        :followers_url=>"https://api.github.com/users/jrwhitmer/followers",
        :following_url=>"https://api.github.com/users/jrwhitmer/following{/other_user}",
        :gists_url=>"https://api.github.com/users/jrwhitmer/gists{/gist_id}",
        :starred_url=>"https://api.github.com/users/jrwhitmer/starred{/owner}{/repo}",
        :subscriptions_url=>"https://api.github.com/users/jrwhitmer/subscriptions",
        :organizations_url=>"https://api.github.com/users/jrwhitmer/orgs",
        :repos_url=>"https://api.github.com/users/jrwhitmer/repos",
        :events_url=>"https://api.github.com/users/jrwhitmer/events{/privacy}",
        :received_events_url=>"https://api.github.com/users/jrwhitmer/received_events",
        :type=>"User",
        :site_admin=>false
      },
          :html_url=>"https://github.com/jrwhitmer/little-esty-shop",
          :description=>nil,
          :fork=>true,
          :url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop",
          :forks_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/forks",
          :keys_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/keys{/key_id}",
          :collaborators_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/collaborators{/collaborator}",
          :teams_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/teams",
          :hooks_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/hooks",
          :issue_events_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/issues/events{/number}",
          :events_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/events",
          :assignees_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/assignees{/user}"
    }

    allow(Faraday).to receive(:get).and_return(Faraday::Response.new)
    allow(JSON).to receive(:parse).and_return(mock_response)

    name = @github_service.repo_name

    expect(name).to eq("little-esty-shop")
  end

  it "can return the users amount of pull requests" do
    @github_service = GithubService.new
    mock_response = {
      :id=>372941023,
      :node_id=>"MDEwOlJlcG9zaXRvcnkzNzI5NDEwMjM=",
      :name=>"little-esty-shop",
      :full_name=>"jrwhitmer/little-esty-shop",
      :private=>false,
      :owner=>{
        :login=>"jrwhitmer",
        :id=>78382113,
        :node_id=>"MDQ6VXNlcjc4MzgyMTEz",
        :avatar_url=>"https://avatars.githubusercontent.com/u/78382113?v=4",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/jrwhitmer",
        :html_url=>"https://github.com/jrwhitmer",
        :followers_url=>"https://api.github.com/users/jrwhitmer/followers",
        :following_url=>"https://api.github.com/users/jrwhitmer/following{/other_user}",
        :gists_url=>"https://api.github.com/users/jrwhitmer/gists{/gist_id}",
        :starred_url=>"https://api.github.com/users/jrwhitmer/starred{/owner}{/repo}",
        :subscriptions_url=>"https://api.github.com/users/jrwhitmer/subscriptions",
        :organizations_url=>"https://api.github.com/users/jrwhitmer/orgs",
        :repos_url=>"https://api.github.com/users/jrwhitmer/repos",
        :events_url=>"https://api.github.com/users/jrwhitmer/events{/privacy}",
        :received_events_url=>"https://api.github.com/users/jrwhitmer/received_events",
        :type=>"User",
        :site_admin=>false
      },
          :html_url=>"https://github.com/jrwhitmer/little-esty-shop",
          :description=>nil,
          :fork=>true,
          :url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop",
          :forks_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/forks",
          :keys_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/keys{/key_id}",
          :collaborators_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/collaborators{/collaborator}",
          :teams_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/teams",
          :hooks_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/hooks",
          :issue_events_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/issues/events{/number}",
          :events_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/events",
          :assignees_url=>"https://api.github.com/repos/jrwhitmer/little-esty-shop/assignees{/user}"
    }

    allow(Faraday).to receive(:get).and_return(Faraday::Response.new)
    allow(JSON).to receive(:parse).and_return(mock_response)

    pull_requests = @github_service.repo_pull_requests

    expect(pull_requests).to eq(18)
  end

end
