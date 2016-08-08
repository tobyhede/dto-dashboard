Fabricator(:organisation) do
  name { sequence(:name) { |i| "o-#{i}" } }
  url  'gov.au'
end
