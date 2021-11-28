# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

student_one = {
    :name => "Jike",
    :email => "jike@jike.com"
}

student_two = {
    :name => "Jake",
    :email => "jake@jake.com"
}

Student.create(student_one)
Student.create(student_two)