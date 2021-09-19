<div align="center">
  <a href=https://github.com/lcpulzone/tea_time/graphs/contributors><img src="https://img.shields.io/github/contributors/lcpulzone/tea_time.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/tea_time/network/members><img src="https://img.shields.io/github/forks/lcpulzone/tea_time.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/tea_time/stargazers><img src="https://img.shields.io/github/stars/lcpulzone/tea_time.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/tea_time/issues><img src="https://img.shields.io/github/issues/lcpulzone/tea_time.svg?style=for-the-badge" /></a>
<a href=https://www.linkedin.com/in/lcpulzone/><img src="https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555" /></a>
</div>

  <h2 align="center">Tea Time</h2>

  <p align="center">
    Tea, delivered just in the nick of time.
    <br />
    <a href="https://github.com/lcpulzone/tea_time/issues">Report Bug</a>
    ·
    <a href="https://github.com/lcpulzone/tea_time/issues">Request Feature</a>
    <br />
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#testing">Testing</a></li>
      </ul>
    </li>
    <li><a href="#schema">Schema</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



## About The Project

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)<br />
![tested with rspec](https://github.com/lcpulzone/tea_time/blob/main/tested-with-rspec.svg)

The goal of this project is to  create a Rails API for a Tea Subscription Service within a time limit of approximately 8 hours.  

The minimum endpoints asked for are:
*  An endpoint to subscribe a customer to a tea subscription
*  An endpoint to cancel a customer’s tea subscription
*  An endpoint to see all of a customer’s subscriptions (active and cancelled)


## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

» [Ruby](https://www.ruby-lang.org/en/) version 2.7.2<br />
» [Rails](https://rubyonrails.org/) version 5.2.6

### Installation

1. Clone the repo
   ```rb
   git clone https://github.com/lcpulzone/tea_time.git
   ```
2. Install gems
   ```rb
   bundle install
   ```
3. Run
   ```rb
   rails db:{create,migrate}
   ```

### Testing

[RSpec](https://rspec.info/)

1. To run testing suite
```rb
bundle exec rspec
```


## Schema

![database_schema](https://github.com/lcpulzone/tea_time/blob/main/db_schema.33.52.png?raw=true)

See the [open issues](https://github.com/lcpulzone/tea_time/issues) for a list of proposed features (and known issues).


## Endpoints

| DESCRIPTION | ACTION | PATH |
|--|--|--|
| create a new tea | POST | localhost:3000/api/v1/teas |
| create a new customer | POST | localhost:3000/api/v1/customers |
| create a new subscription | POST | localhost:3000/api/v1/subscriptions |
| update a customer's subscription status | PATCH | localhost:3000/api/v1/customers/<customer_id>/subscriptions/<subscription_id> |
| get all a customer's subscriptions | GET | localhost:3000/api/v1/customers/<customer_id>/subscriptions |


## Contributing

Contributions are what make the open source community such an amazingly rad place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/RadFeature`)
3. Commit your Changes (`git commit -m 'Add some RadFeature'`)
4. Push to the Branch (`git push origin feature/RadFeature`)
5. Open a Pull Request


## Contact

Leigh Cepriano Pulzone - [Linkedin](https://www.linkedin.com/in/lcpulzone/) - [GitHub](https://github.com/lcpulzone) - [Email](lcpulzone@gmail.com)

Project Link: [Tea Time](https://github.com/lcpulzone/tea_time)



## Acknowledgements

» [README Template Source](https://github.com/othneildrew/Best-README-Template)<br />
» [Turing Requirements](https://mod4.turing.edu/projects/take_home/take_home_be)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lcpulzone/tea_time.svg?style=for-the-badge
[contributors-url]: https://github.com/lcpulzone/tea_time/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lcpulzone/tea_time.svg?style=for-the-badge
[forks-url]: https://github.com/lcpulzone/tea_time/network/members
[stars-shield]: https://img.shields.io/github/stars/lcpulzone/tea_time.svg?style=for-the-badge
[stars-url]: https://github.com/lcpulzone/tea_time/stargazers
[issues-shield]: https://img.shields.io/github/issues/lcpulzone/tea_time.svg?style=for-the-badge
[issues-url]: https://github.com/lcpulzone/tea_time/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/lcpulzone/
[product-screenshot]: images/screenshot.png


# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.5.3.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

## Visual Schema

![Little Esty Shop](https://user-images.githubusercontent.com/74436194/120427830-e18e2300-c32f-11eb-907c-723750913e80.png)
