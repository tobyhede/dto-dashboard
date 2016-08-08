Fabricator(:dashboard) do
  organisation
  name { sequence(:name) { |i| "dashboard-#{i}" } }
end
