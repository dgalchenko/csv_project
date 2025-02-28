# How to set up locally:
```
bin/bundle install
yarn install
bin/rails db:setup
bin/rails db:migrate
bin/rails s
```

# How to test locally:
1. As an admin, go to http://localhost:3000/admin/companies/upload
2. Upload a CSV file with companies' data (you can find the CSV-file in `config/data/companies.csv`)
3. Then as a user, go to root http://localhost:3000, where you can now dynamically search for companies data

# How to run tests locally:
```
rails test
```