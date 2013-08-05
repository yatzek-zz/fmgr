# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Players
require 'player'
require 'game_definition'

GameDefinition.delete_all

GameDefinition.create!(day: 'tue', time: '12:00')
GameDefinition.create!(day: 'thu', time: '12:00')

Player.delete_all

Player.create!(email: 'Jakub.Witkiewicz@gbskyb.com')
Player.create!(email: 'Seb.Briggs@bskyb.com')
Player.create!(email: 'Paul.Murphy2@bskyb.com')
Player.create!(email: 'Lawrence.Wyatt@bskyb.com')
Player.create!(email: 'Anikh.Subhan@bskyb.com')
Player.create!(email: 'Jacek.Szlachta@bskyb.com')
Player.create!(email: 'Christopher.Temple@bskyb.com')
Player.create!(email: 'Imran.Hussain@bskyb.com')
Player.create!(email: 'Andrew.Akien@bskyb.com')
Player.create!(email: 'Satya.Peddireddy@bskyb.com')
Player.create!(email: 'David.Rooks@bskyb.com')
Player.create!(email: 'Prakash.Kudrekar@bskyb.com')
Player.create!(email: 'David.Pacheco@bskyb.com')
Player.create!(email: 'Kiran.Amin@bskyb.com')
Player.create!(email: 'Federico.Roman@bskyb.com')
Player.create!(email: 'John.Petrie@bskyb.com')
Player.create!(email: 'Sukhdev.Bansal@bskyb.com')
Player.create!(email: 'Sukhdeep.Heer@bskyb.com')
Player.create!(email: 'Nahiem.Ayub@bskyb.com')
Player.create!(email: 'Dogan.Narinc2@bskyb.com')
Player.create!(email: 'Will.Walker@bskyb.com')
Player.create!(email: 'Christopher.Kitley@bskyb.com')
Player.create!(email: 'Dominic.Bloch@bskyb.com')
Player.create!(email: 'Sam.Holt@bskyb.com')
Player.create!(email: 'Stuart.Bye@bskyb.com')
Player.create!(email: 'Charlie.Wagner@bskyb.com')
Player.create!(email: 'Richard.Guest@bskyb.com')
Player.create!(email: 'Rafael.Priego@bskyb.com')
Player.create!(email: 'Bogdan.Amihaesie@bskyb.com')
Player.create!(email: 'Laith.Nurie@bskyb.com')
Player.create!(email: 'Andrew.Craig2@bskyb.com')