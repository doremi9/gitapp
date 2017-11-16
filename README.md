# Github Checker

## Description
The idea of this application is to process GitHub webhooks. A user signs up with GitHub and sets his Webhook URL on GitHub to point to this application. Then, the user subscribes to pull request events within his organization and eveytime a new pull request is opened on his organization repository the webhook will be sent to this applicaion. The application then will add a comment to the pull request.

## Problems solved
1. Authentication with Github - I used Omniauth-github gem
2. Webhooks - webhook JSON does not contain the owner of the organization the event occured on which makes it difficult to associate particular event to a specific user in the application. My idea to solve this problem was to have a user sign up with GitHub first and generate a random 10 character token for him in the background and use it as his unique Webhook URL. The user, then, can access it by visiting Settings page and use it as his own Webhook URL on his organization settings page on GitHub. This ensures that the webhook is not sent (accidentally or deliberately) to somebody that should not receive it and that each particular event that occures within user's organization on Github is associated to a specific user in the application.

## Installation instructions

```bash docker-compose run app rails db:migrate```

```bash docker-compose up```

visit 

```bash localhost:3001```

