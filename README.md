# TheLittleRascals-Peer-Eval

## Introduction
This Ruby on Rails project is a peer evaluation tool created by The Little Rascals. Peer evaluations are crucial to anybody working in a team and this tool makes it easy to praise teammates, bring up any issues, and, if you are an administrator, oversee your groups to keep track of their strengths and weaknesses.

## Key Features
* Administrator privileges to create, edit, delete, and monitor groups and users
* Surveys for each group member to evaluate their team(s) and for the admins to view the results
* Easy account, project, and team creation for admins
* Clean and simple user interface
* Admin ability to email the group members information about finishing forms

## How to Run the Peer Evaluation Tool
### Step 1: Make Sure You Have Python Installed
For this project, Python 3 is required so that the email features work. To check if you have Python 3, choose your favorite shell and type
```
python --version
```
If the version is 3, we're all set!
If not, please refer to the [official Python website](https://www.python.org/downloads/) to download the latest version.
Additionally, you must add Python to your global paths, so that smtp (email features) will work properly. For more information, please reference https://geek-university.com/python/add-python-to-the-windows-path/.

---
### Step 2: Clone
Now that we're in your favorite shell, enter a folder. Then type:
```
git clone https://github.com/cse3901-2021au-giles/TheLittleRascals-Peer-Eval.git
```
This clones the project so you'll have it on your computer.

---
### Step 3: Download Dependencies
While still in your shell, run:
```
bundle install
```
This will install the dependencies from the Gemfile.

---
### Step 4: Run the Peer Evaluation Tool
To run the web scraper type: 
```
rails server
```
You should now see:
```
...
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
```
or something similar. Click the link and you will be taken to your default browser, or just type in "localhost:3000" in your browser, replacing 3000 with the port specified. Enjoy!

## Other Technical Issues
* Subject to your local environment and the version of required dependencies you are running, it is very common to encounter errors during build process. Please contact the owner (zhong.523@osu.edu) to resolve any issue you have.
###Possible Issues
* WebPacker not running correctly: bundle exec rake webpacker:install
* Database not loading: rails db:schema:load

## Views (Student & Admin)
* Login Page: This page is for introducing the site and for logging in. This page contains a place to input email and password and also a place to input email if you forget your password.
* Account Landing Page: Your dashboard is here and differs if you're an admin or a regular user. For admins, you can see the projects (classes) and the students in your classes. From here you can also add students or add projects (see below). For regular users, the interface looks very similar except you have your opened polls, closed polls , and your team assignments. Both have a welcome message with basic account information, a place to update your profile, and a button to log out.
* Update Profile: All users are able to edit their first and last name, email, and password on this page.
* Polls: Admins are able to create polls for each project (class) and send them out to all members of that project. These polls with allow users (students) to rate and comment their groupmates. Since the polls for the students show up on their landing page, they just need to select the poll and submit when done.
* View Results Page: Admins are able to view the results of the polls they send out. Regular users are also able to view the results of the polls they've completed, as well as the rating and comments they had received from their teammates.
* View Teams Page: For each project (class), admins are able to view the teams: the name of the team, its description, and its members and also be able to modify the team names
* Forget password page: In this page, you can enter your email to receieve a temp password in order for you to log back in.
* Projects: A project belongs to a group, has many teams and polls and can only be created by an admin. Admins can click Add Project to add a new project and click create teams to create respective teams

---
##### Coded by Jack Burgdoerfer, Joseph Hilber, Ashwin Nair, Jiahui Xu, and Jike Zhong
