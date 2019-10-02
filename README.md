# Abalone Analytics
The Bodega Marine Laboratory's White Abalone captive breeding program is working to prevent the extinction of the [White Abalone](https://www.biographic.com/posts/sto/fighting-for-a-foothold) (Haliotis sorenseni), an endangered marine snail. White abalone are one of seven species found in California and are culturally significant to the native people of the area. White abalone were perilously overfished throughout the 20th century, resulting in a 99 percent population decrease by the end of the 1970s. This group is working to reverse their decline and have already seen some great success, they currently have more abalone in the lab than exist in the wild!

[Ruby for Good](https://rubyforgood.org/) is supporting these efforts by developing a data tracking and analytics system for Abalone population trends, mortality rates, and breeding programs to help save this species from extinction.

## Getting Started

### Prerequisites
This application is built on following and you must have these installed before you begin:
* Ruby (2.6.3)
* Rails (5.2)
* PostgreSQL (tested on 9.x)

### Setup
After cloning this repo, execute the following commands in your CLI:
```
gem install bundler
bundle install
rake db:create
rake db:migrate
rake db:seed
```

Then, run `bundle exec rails s` and browse to http://localhost:3000/.

### Running Background Jobs

The app uses the gem [delayed_job](https://github.com/collectiveidea/delayed_job) for processing CSVs. To run background jobs, run the following command in your terminal:
```
rake jobs:work
```

To confirm background jobs are processing, try uploading a CSV at `http://localhost:3000/file_uploads/new`. You should see the job complete in your CLI and see the file upload results here at `http://localhost:3000/file_uploads`.

## Contribute
We would love to have you contribute! Checkout the Issues tab and make sure you understand the acceptance criteria before starting one. Before you start, get familiar with important terms, how the app works right now, sample data and the steps to MVP below:

### Get Familiar with the App

This app is still in early stages of development (MVP). We have defined our [MVP and additional milestones here](https://github.com/rubyforgood/abalone/milestones)

Take a look at the current [Issues](https://github.com/rubyforgood/abalone/issues), which lay out our path to MVP. Feel free to assign one to yourself and take it on! If you have any questions about requirements, post your question in the issue or email Ellen Cornelius at gellinellen@gmail.com.

### The Problem
Our stakeholder, the Bodega Marine Laboratory, has more data that they can keep track of! They want to have a central data repository for all of their abalone captive breeding data instead of just spreadhseets. It is hard to run reports and anlytics on the data when it's not all in one place.

### The Solution
We are building an app which has the following capabilities:
1. Stores raw data: There are several different types of CSVs that the lab has been amassing (Mortality Tracking Data, Pedigree Data, Population Estimate Data, Spawning Success Data, Tagged Animal Assessment Data, Untagged Animal Assessment Data, and Wild Collection Data). Examples of these CSVs can be found in the [`db/sample_data_files`](https://github.com/rubyforgood/abalone/tree/master/db/sample_data_files) directory.
2. Imports CSVs: Users are able to import single CSVs and in bulk. Users should generally submit cleaned CSVs, but the app should alert users if there are parsing problems and which rows need to be fixed. 
3. Display Charts and Analytics: For MVP, we would like to display a Histogram binned in 1cm increments of different body lengths for a certain cohort or group of cohorts.
4. Export CSVs: TBD.

#### Jargon
* Cohort = This is how the lab coloquilly refer to each of their populations spawned on a certain date. It's bascially a note/nickname for each group of animals with a particular SHL #/spawning date. Written as `place_YYYY`

#### File Upload Architecture


## Deployment
The application is currently deployed on a DigitalOcean droplet via Capistrano. Once your public SSH key has been added to the appropriate user on the necessary server(s), use `bundle exec cap production deploy` to deploy the application, run migrations, and restart the Puma application server. Puma is reverse-proxied behind Nginx. The Nginx configuration is currently maintained outside of the Rails development pipeline. Currently live at [abalone.blrice.net](http://abalone.blrice.net/).

## And Don't Forget...

...that Gary needs you.

![a white abalone](https://github.com/rubyforgood/abalone/blob/master/app/assets/images/Burgess%20white%20ab%201.png)

_Photo credit: John Burgess/The Press Democrat_

