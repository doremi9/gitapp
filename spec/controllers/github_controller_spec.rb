require 'rails_helper'

RSpec.describe GithubController, type: :controller do
  let(:params) { payload }

  describe "POST #webhooks" do

    it "creates or finds and organization, repository, pull request and adds a comment" do
      allow(controller).to receive(:params).and_return(params)
      puts controller.params

    # zapisze nową organizację, jesli jeszcze nie istnieje
    # nie zapisze, jeśli już istnieje
    # zapisze nowe repozytorium w organizacji, jeśli jeszcze nie istnieje
    # nie zapisze nowego repozytorium do organizacji, jesli już istnieje
    # zapisze nowy pull request do repozytorium w organizacji jeśli jeszcze nie istnieje
    # nie zapisze nowego pull request'u do repozytorium w organizacji jeśli już istnieje
    # stworzy nowy komentarz do pull requestu z następujacymi paramterami:
    # text: "Hej, everything is OK!", gif_url: "some url"
    end
  end
end

