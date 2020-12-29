# Chores App
This project is the full-stack web app for the Chores Project.

## Getting Started

This app uses docker & docker-compose to run locally. 
This provides a quick & easy way to get set up.

Once the app is running on your computer, you can enter 
the container's CLI and interact with it as you would 
any Linux system.

### Docker setup
1. Install docker and docker-compose
   1. https://docs.docker.com/desktop/
   2. https://docs.docker.com/compose/install/
2. Enable VT-x (hardware virtualization) on your computer
  - This is deferent for every computer, but can usually be found in your BIOS settings
  - Macs have this enabled by default, but if you notice containers running very slow, it may be turned off.  Reboot your computer and hold CMD-OPT-P-R during boot to re-enable it
3. Run the following in the chores directory
    ````
   > docker-compose build
   > docker-compose up
    ````
4. Once the container is started you can open another terminal and enter the container
    ````
   > docker-compose exec web bash
    ````
5. Once inside the container

## Running Tests
We use rspec for tests. There is also a gem called 'guard' 
installed. Guard facilitates some automatic running of tests.

1. Enter the container CLI:
    ````
    > docker-compose exec web bash
    ````
2. Run tests manually if desired:
    ````
    > rspec
    ````
3. Run guard to run tests automatically
    ````
   > bundle exec guard
   ````
4. See the guard docs for info on guard:
    1. https://github.com/guard/guard

## Code Formatting
We use hound to check the code formatting on github. We
have rubocop installed as a gem to check/correct it locally.

1. Enter the container CLI:
    ````
    > docker-compose exec web bash
    ````
2. Run rubocop to report on formatting issues:
    ````
    > rubocop
    ````
2. Run rubocop to fix most issues:
    ````
    > rubocop -a
    ````
2. Run rubocop to fix everything it can (unsafe fixes):
    ````
    > rubocop -A
    ````

## Branching Structure

- Please make branches off of the latest develop branch.
- Please name branches lik this:
  - "{issue id}_{brief name of issue}"
  - Example: "74_fix_email_bug"
