1. Publish on Github (I just do this through their Atom plugin)
2. Set up [Semaphore](https://semaphoreci.com/)
3. Set up [CodeClimate](https://codeclimate.com/)
4. Integrate Semaphore and CodeClimate via Semphore's Integration tab on the settings page.
5. Setup up staging and production apps on Heroku (see [instructions](https://devcenter.heroku.com/articles/multiple-environments))
6. Link apps to Github so commits are referenced
7. Create pipeline on Heroku
8. Enable review apps on pipeline
9. Use Semaphore to create automatic deploy to Heroku staging app after a successful build completes for the master branch
