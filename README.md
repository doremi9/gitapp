# Github Checker

##Description
The application is meant for processing GitHub webhooks

##Problems solved
1. Authentication with Github - I used Omniauth-github gem
2. Webhooks 
   Problem: webhook JSON does not contain the owner of the organization the event occured on which makes it difficult to associate particular event to a specific user in the application. My idea to solve this problem was to have a user sign up with GitHub first and generate a random 10 character token for him in the background and use it as his unique Webhook URL. The user, then, should visit Settings page to get his URL and use it as his own Webhook URL on his organization settings page on GitHub. This ensures that the webhook is not sent (accidentally or deliberately by somebody) to somebody that should not receive it and that each particular event that occures within user's organization on Github is associated to a specific user in the application.

## Installation instructions

```bash docker-compose run app rails db:migrate```
```bash docker-compose up```

visit ```bash localhost:3001```

