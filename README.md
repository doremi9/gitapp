# Github Checker

## Description
The idea of this application is to process GitHub webhooks. A user signs up with GitHub and sets his Webhook URL on GitHub to point to this application. Then, the user subscribes to pull request events within his organization and everytime a new pull request is opened on his organization repository the webhook will be sent to this applicaion. The application then will add a comment to the pull request. User can download his organizations and repositories by clicking 'Download data' button.

## Problems solved
1. Authentication with Github - I used Omniauth-github gem
2. Webhooks - webhook JSON does not contain the owner of the organization the event occured on which makes it difficult to associate particular event to a specific user in the application. My idea to solve this problem was to have a user sign up with GitHub first and generate a random 10 character token for him in the background and use it as his unique Webhook URL. The user, then, can access it by visiting Settings page and use it as his own Webhook URL on his organization settings page on GitHub. This ensures that the webhook is not sent (accidentally or deliberately) to somebody that should not receive it and that each particular event that occures within user's organization on Github is associated to a specific user in the application.

## Installation instructions
### Prerequisites

Generate your [Personal Token](https://github.com/settings/tokens) and update .env file.

GITHUB_ACCESS_TOKEN=your_40_character_token

```docker-compose run app rails db:migrate```

```docker-compose up```

visit ```localhost:3001/settings``` and copy your Webhook URL.

Install [Ngrok](https://ngrok.com/)

```cd your_ngrok_fodler``` and type ```./ngrok http 3001``` This exposes your local host to the internet and ensures that GitHub can recognise your computer and acually send webhooks to your app. Take a note of Forwarding URL.

Login to github.com, go to your organization, settings, Webhooks and click add a new webhook. For Pyload URL type "your_ngrok_forwarding_url/your_webhook_url". For example, http://a2ccb535.ngrok.io/d8197b25b3cd05925c1a/webhook. Make sure to subscribe for Pull Request event. After successful configuration, you should receive webhooks to the app.


