require 'csv'

puts "CREATE COMMUNITIES"
@company = %W[ #{'New York Yankees'} #{'Teach For America'} Facebook #{'Random House'} #{'City University of New York'} #{'Lilla G. Frederick Pilot Middle School'} #{'Cool Chip Technologies'} #{'National Latina Institute For Reprodcutive Health'} #{'Stony Brook University'} #{'Meditech'} #{'Wellington Management Company'} #{'Connecticut College'} ]
@culture = %W[ African African-American Nigerian Ethiopian Eritrean #{'South African'} Egyptian Algerian #{'Cape Verdean'} Latino Dominican #{'Puerto Rican'} Mexican Cuban Columbian Brazilian Bolivian Argentinian Chilean #{'Costa Rican'} Ecuadorian Guyanese Uruguayan Peruvian Paraguayan Portuguese Guatemalan Salvadorian Venezuelan Panamanian Honduran #{'West Indian'} Jamaican Trinidadian Haitian #{'Middle Eastern'} Afghan Albanian Vietnamese Armenian Indonesian Israeli Asian Chinese Indian Filipino Japanese Taiwanese Korean European Italian Irish French German British Dutch Russian Spaniard Greek Scottish #{'Native American'} ]
@degree = %W[ Associate's Bachelor's Master's Doctoral #{"Pursuing Associate's"} #{"Pursuing Bachelor's"} #{"Pursuing Master's"} #{"Pursuing Doctoral"} #{"High School"} ]
@field = %W[ Agriculture Anthropology Architecture #{'Area Studies'} Archaeology Astronomy Biology Business Chemistry #{'Cognitive Science'} Communications #{'Computer Science'} #{'Ethnic Studies'} Divinity Economics Education Engineering Entertainment Environment Finance #{'Gender Studies'} Geography History Journalism Law Linguistics Literature Marketing Mathematics Medicine Military #{'Performing Arts'} Philosophy Physics #{'Political Science'} #{'Public Health'} Psychology Religion #{'Sexuality Studies'} #{'Social Work'} Sociology Sports Technology Transportation #{'Visual Arts'} Writing ]
@gender = %W[ Male Female ]
@orientation = %W[ Heterosexual Lesbian Gay Bisexual Transgender ]
@profession = %W[ Actor Doctor Lawyer Writer ]
@relationship = %W[ Single #{'In a Relationship'} Married ]
@religion = %W[ Agnostic Athiest Bahai Buddhist Christian Confucianist Hindu Jain Jewish Muslim Rasta Shintoist Sikh Taoist Wicca ]
@school = %W[ #{'Yale University'} #{'Harvard University'} #{'Cornell University'} #{'Brown University'} #{'Massachusetts Institute of Technology'} #{'Rutgers University'} #{'New York University'}]
@standing = %W[ Alumni #{'Graduate Student'} Undergraduate ]

# group interest
%w( company culture degree field gender orientation profession relationship religion school standing ).each do |type|
  instance_variable_get("@#{type}").each do |name|
    type.capitalize.constantize.create name: name, filter_name: name, slug: name.parameterize, verified: true
  end
end

Carmen::Country.all.each do |country|
  country = Country.create(name: country.name, filter_name: country.name, country_code: country.code, slug: country.name.parameterize, verified: true)
  puts country.name
end

CSV.foreach('lib/data/cities-dev.csv') do |row|
  country = Country.find_by(country_code: row[4], verified: true)
  puts country.name
  city = country.communities.create!(name: row[1], filter_name: "#{row[1]}, #{country.country_code}", country_name: country.name, country_code: country.country_code, latitude: row[2], longitude: row[3], slug: row[1].parameterize, verified: true, type: "City")
  puts city.name
  sleep 1
end

puts "CREATE USERS"
20.times do
  User.create(
    email: Faker::Internet.email,
    password: Devise.friendly_token[0,20],
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    communities: [Community.all.sample, Community.all.sample, Community.find_by(name: "Dominican")]
  )
end

puts "CREATE GROUPS"
Community.find_by(name: "Dominican").communities.create(
  name: "National Dominican Student Conference",
  filter_name: "NDSC",
  slug: "ndsc",
  verified: true,
  type: "Group"
)