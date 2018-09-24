# URLShortener: A URL shortner in 4 hours
Hello, and thank you for reviewing my homework assignment for the engineering team. I appreciate the opportunity to audition with you guys.

No URL's were harmed in the making of this code. 😇

## 🎓 The Assignment
*Note: This assignment was provided by the company. I am including it here verbatim.*
1. In answering the assignment, please submit code as if you intended to ship it to production. We want to see your best work 😄. Please make sure to write tests!
2. We believe this should take less than 4 hours to complete, but understand you may have other commitments and time constraints. Please let us know (roughly) when we should expect your answers (e.g. “over the weekend”). Let us know if you need more time.
3. Build a simple URL shortening service (like Bit.ly). Your service should meet the requirements below.
4. The home page of your app should have a text field for the user to enter a URL and a submit button to request the shortened URL.
5. When the User submits their entered URL, return back a unique shortened URL for them to use. (You only need to worry about the path of the URL, not the domain... assume this code will be deployed on a domain that is already short, like “site.co”).
6. Your site should properly handle using the shortened URLs: Requests to shortened URLs should redirect to the original URL.
7. Handle basic errors: If the user enters a garbage URL to be shortened, return back an error message that the input needs to be a proper URL.
8. Your code should be a Rails app.
9. Feel free to use any gems/frameworks that you deem helpful.
10. Remember there is no need for any login/authentication system for this project.
11. We hope this goes without saying, but using an entire existing solution on the Internet will not be considered passing 😄.
12. Send us a ZIP file of your entire codebase, along with any special instructions to use it beyond starting the server and visiting localhost:3000 😄.

Examples:
- Input: http://www.google.com Output: http://localhost:3000/zy3F23f1
- Input: aefoi heafioh Output: [Error -- this does not look like a valid URL]

## 🏃 My Solution
1. If you use [vagrant](./Vagrantfile): `vagrant up`, `vagrant ssh`, `cd ~/urlshortener`
2. If you don't use vagrant, just `cd` to this folder on a machine with Ruby & PostgreSQL installed and run `bundle` ([installs RSpec](./Gemfile))
3. Run `rake db:setup` & `rake db:migrate`
4. Start the server: `bin/rails server` or `bin/rails server -b 0.0.0.0` if you're using Vagrant
5. To run RSpec suite: `rspec`

## ✂️ Corners I Cut
Given the 4 hour timebox, I cut a lot of corners:

1. I used HTML, CSS, and JQuery directly for the view layer -- no Action View, React, or any of the other techniques I'd use in a real production stack
2. I don't enforce shortened URL's to be unique (e.g., if 3 people all shorten `aol.com`, 3 shortcodes are generated)
3. I only tested the `POST #create` endpoint -- not the `GET #show` 302 redirection
4. The 404 page is barebones
5. I took a liberal view of what constitues a "valid URL" (is a URL without a protocol, like `aol.com`, a valid URL?)
6. Concerns and helpers aren't abstracted
7. Production-scale performance was ignored; e.g., a RDBMS isn't appropriate, some gems could be removed, etc.

## 🤓 My Plan of Attack
✅ = done
⏳ = planned, but ran out of time
🚨 = todo

1. ✅ Set up a Vagrant 1-click booter
2. ✅ Create a Rails project that is API-only
3. ✅ Build & test `POST /url` JSON endpoint, which handles valid and junk URL's
4. ✅ Design a cute landing page on paper
5. ✅ Code HTML & CSS for landing page
6. ✅ Code jQuery form submission for landing page that creates a short URL using `POST /url` JSON endpoint, which handles valid and junk URL's
7. ✅ Build & test `GET /[:id]` endpoint that 302 redirects the user's browser, and displays an error if the URL id doesn't exist
8. ⏳ If time allows, implement more performant DynamoDB datastore
9. ⏳ If time allows, implement more performant Sinatra-based backend
10. ⏳ If time allows, deploy to AWS
11. ✅ Document what I did for reviewer in README

## 🥇 Conclusion
I am happy with my result. I aimed to demonstrate that I can take a basic MVP and implement it with clean, well-documented code with good frontend/backend separation of concerns. I look forward to discussing my submission with your team.

Thanks for reading!

![Alt Text](https://media.giphy.com/media/3oEjI5VtIhHvK37WYo/giphy.gif)
