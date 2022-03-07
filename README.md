# Programming Exercise - Grouping

[Zipline Hiring Exercise - Grouping](https://github.com/retailzipline/hiring-exercises/tree/main/grouping)

For a given CSV file and a pre-defined matcher, generate a new CSV file adding a new ID grouped by the selected matcher type.

## Assumptions

- For a given matcher, the rows will be the same only if a specific matcher repeats in any other lines in for a set of columns (i.e., `phone1`, `phone2`, `phone3`, etc.).

  - Example:
    | name | phone1 | phone2 |
    |------|------------------|------------|
    | John | (555) 123 - 1234 | |
    | Jane | | 5551231234 |
    | Vivi | (555) 123 1235 | 5551231234 |

    All records above should have the same ID

## Install

### Clone the repository

```shell
git clone git@github.com:vivifranca/zipline-test-vivi.git
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should be something like `ruby 2.7.2`

If not, install the right ruby version using [rvm](https://rvm.io/) (it could take a while):

```shell
rvm install 2.7.2
```

### Install dependencies

```shell
bundle install
```

## Run

To run the matcher just execute the following command:

```shell
bin/find_matchers.rb
```

It contains a multiple choice options of inputs and matchers. If you would like to test a different file, just add a new entry on file `bin/find_matchers.rb` (line 19 at `FILE` variable)

## Test

```shell
rspec
```
