require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'user@test.com'
  u.password 'please'
end

Factory.define :member_company do |mc|
  mc.name 'Test Company'
  mc.code 'TEST'
end

Factory.define :season do |s|
  s.name 'Test Season'
  s.start_date '2000-01-01'
  s.end_date '2000-12-31'
end