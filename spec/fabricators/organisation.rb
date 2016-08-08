Fabricator(:organisation) do
  name { sequence(:name) { |i| "organisation-#{i}" } }
  url  'gov.au'
end
