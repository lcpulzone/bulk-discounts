<div align="center">
  <a href=https://github.com/lcpulzone/bulk-discounts/graphs/contributors><img src="https://img.shields.io/github/contributors/lcpulzone/bulk-discounts.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/bulk-discounts/network/members><img src="https://img.shields.io/github/forks/lcpulzone/bulk-discounts.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/bulk-discounts/stargazers><img src="https://img.shields.io/github/stars/lcpulzone/bulk-discounts.svg?style=for-the-badge" /></a>
  <a href=https://github.com/lcpulzone/bulk-discounts/issues><img src="https://img.shields.io/github/issues/lcpulzone/bulk-discounts.svg?style=for-the-badge" /></a>
<a href=https://www.linkedin.com/in/lcpulzone/><img src="https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555" /></a>
</div>

  <h2 align="center">Bulk Discounts</h2>

  <p align="center">
    An extension to the project Little Esty Shop
    <br />
    <a href="https://github.com/lcpulzone/bulk-discounts/issues">Report Bug</a>
    ·
    <a href="https://github.com/lcpulzone/bulk-discounts/issues">Request Feature</a>
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
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



## About The Project

[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)<br />
![tested with rspec](https://github.com/lcpulzone/bulk-discounts/blob/main/tested-with-rspec.svg)

_This solo project is an extension of a group project called [Little Esty Shop](https://github.com/jrwhitmer/little-esty-shop)_

This project added functionality for merchants to create bulk discounts for their items. A “bulk discount” is a discount based on the quantity of items the customer is buying, for example “20% off orders of 10 or more items”.

**Project Goals:**
* Write migrations to create tables and relationships between tables
Implement CRUD functionality for a resource using forms (form_tag or form_with), buttons, and links
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Use built-in ActiveRecord methods to join multiple tables of data, make calculations, and group data based on one or more attributes
* Write model tests that fully cover the data logic of the application
* Write feature tests that fully cover the functionality of the application

**Bulk Discounts are subject to the following criteria:**

* Bulk discounts should have a percentage discount as well as a quantity threshold
* Bulk discounts should belong to a Merchant
* A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
* Merchants can have multiple bulk discounts
* If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied
* Bulk discounts should apply on a per-item basis
* If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only  
* Other items that did not meet the quantity threshold will not be affected
* The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of * Item B to meet a quantity threshold of 2. They must order 2 or Item A and/or 2 of Item B

## Getting Started

To get a local copy up and running follow these simple example steps

### Prerequisites

» [Ruby](https://www.ruby-lang.org/en/) version 2.7.2<br />
» [Rails](https://rubyonrails.org/) version 5.2.6

### Installation

1. Clone the repo
   ```rb
   git clone https://github.com/lcpulzone/bulk-discounts.git
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

![Little Esty Shop](https://user-images.githubusercontent.com/74436194/120427830-e18e2300-c32f-11eb-907c-723750913e80.png)

See the [open issues](https://github.com/lcpulzone/bulk-discounts/issues) for a list of proposed features (and known issues)


## Contributing

Contributions are what make the open source community such an amazingly rad place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/RadFeature`)
3. Commit your Changes (`git commit -m 'Add some RadFeature'`)
4. Push to the Branch (`git push origin feature/RadFeature`)
5. Open a Pull Request


## Contact

Leigh Cepriano Pulzone - [Linkedin](https://www.linkedin.com/in/lcpulzone/) - [GitHub](https://github.com/lcpulzone) - [Email](lcpulzone@gmail.com)

Project Link: [Bulk Discounts](https://github.com/lcpulzone/bulk-discounts)<br />
Group Project Link: [Little Esty Shop](https://github.com/jrwhitmer/little-esty-shop)<br />
Group Project Contacts: [Little Esty Shop](https://github.com/jrwhitmer/little-esty-shop/graphs/contributors)


## Acknowledgements

» [README Template Source](https://github.com/othneildrew/Best-README-Template)<br />
» [Turing Requirements](https://backend.turing.edu/module2/projects/bulk_discounts)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/lcpulzone/bulk-discounts.svg?style=for-the-badge
[contributors-url]: https://github.com/lcpulzone/bulk-discounts/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/lcpulzone/bulk-discounts.svg?style=for-the-badge
[forks-url]: https://github.com/lcpulzone/bulk-discounts/network/members
[stars-shield]: https://img.shields.io/github/stars/lcpulzone/bulk-discounts.svg?style=for-the-badge
[stars-url]: https://github.com/lcpulzone/bulk-discounts/stargazers
[issues-shield]: https://img.shields.io/github/issues/lcpulzone/bulk-discounts.svg?style=for-the-badge
[issues-url]: https://github.com/lcpulzone/bulk-discounts/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/lcpulzone/
[product-screenshot]: images/screenshot.png
