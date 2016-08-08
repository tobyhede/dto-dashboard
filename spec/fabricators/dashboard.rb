Fabricator(:dashboard) do
  organisation
  name { sequence(:name) { |i| "d-#{i}" } }
end
