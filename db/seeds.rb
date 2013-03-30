# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Players
require "player"
require "game_definition"

GameDefinition.delete_all

GameDefinition.create!(day: 'tue', time: '12:00')

Player.delete_all

Player.create!(name: 'Jakub', surname: 'Witkiewicz', email: 'Jakub.Witkiewicz@gbskyb.com')
Player.create!(name: 'Maria', surname: 'Shodunke', email: 'Maria.Shodunke@bskyb.com')
Player.create!(name: 'Gareth', surname: 'Porter', email: 'Gareth.Porter@bskyb.com')
Player.create!(name: 'Krishan', surname: 'Lakha', email: 'Krishan.Lakha@bskyb.com')
Player.create!(name: 'John', surname: 'Boyes', email: 'John.Boyes@bskyb.com')
Player.create!(name: 'Nauman', surname: 'Khan', email: 'Nauman.Khan@bskyb.com')
Player.create!(name: 'Seb', surname: 'Briggs', email: 'Seb.Briggs@bskyb.com')
Player.create!(name: 'Paul', surname: 'Murphy', email: 'Paul.Murphy2@bskyb.com')
Player.create!(name: 'Himanshu', surname: 'Kohli', email: 'Himanshu.Kohli@bskyb.com')
Player.create!(name: 'Nigel', surname: 'Pepper', email: 'Nigel.Pepper@bskyb.com')
Player.create!(name: 'Jacob', surname: 'Farrugia', email: 'Jacob.Farrugia@bskyb.com')
Player.create!(name: 'Lawrence', surname: 'Wyatt', email: 'Lawrence.Wyatt@bskyb.com')
Player.create!(name: 'Shenal', surname: 'Devani', email: 'Shenal.Devani@bskyb.com')
Player.create!(name: 'Anikh', surname: 'Subhan', email: 'Anikh.Subhan@bskyb.com')
Player.create!(name: 'Dan', surname: 'Knight', email: 'Dan.Knight@bskyb.com')
Player.create!(name: 'Jacek', surname: 'Szlachta', email: 'Jacek.Szlachta@bskyb.com')
Player.create!(name: 'Massimo', surname: 'Battestini', email: 'Massimo.Battestini@bskyb.com')
Player.create!(name: 'Mansoor', surname: 'Fazil', email: 'Mansoor.Fazil@bskyb.com')
Player.create!(name: 'Jamie', surname: 'English', email: 'Jamie.English@bskyb.com')
Player.create!(name: 'Sarndeep', surname: 'Nijjar', email: 'Sarndeep.Nijjar@bskyb.com')
Player.create!(name: 'Christopher', surname: 'Temple', email: 'Christopher.Temple@bskyb.com')
Player.create!(name: 'Kunal', surname: 'Behl', email: 'Kunal.Behl@bskyb.com')
Player.create!(name: 'Imran', surname: 'Hussain', email: 'Imran.Hussain@bskyb.com')
Player.create!(name: 'Robert', surname: 'Howe', email: 'Robert.Howe@bskyb.com')
Player.create!(name: 'Andrew', surname: 'Akien', email: 'Andrew.Akien@bskyb.com')
Player.create!(name: 'Paul', surname: 'Makkar', email: 'Paul.Makkar@bskyb.com')
Player.create!(name: 'Gregory', surname: 'Kuzdenyi', email: 'Gregory.Kuzdenyi@bskyb.com')
Player.create!(name: 'Dogan', surname: 'Narinc', email: 'Dogan.Narinc@bskyb.com')