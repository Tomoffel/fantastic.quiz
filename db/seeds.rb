# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

vwl = Category.create( name: 'VWL' )
bwl = Category.create( name: 'BWL')
it = Category.create( name: 'IT' )

Category.create(name: 'Rechnungswesen', parent_id: bwl.id)
Category.create(name: 'Softwareentwicklung', parent_id: it.id)
