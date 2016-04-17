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

GameDefinition.create!(day: 'tue', time: '12:00', disabled: true)
GameDefinition.create!(day: 'wed', time: '12:00')
GameDefinition.create!(day: 'thu', time: '12:00', disabled: true)

#Player.delete_all